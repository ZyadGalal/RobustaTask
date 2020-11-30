//
//  HomeInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import "HomeInteractorImpl.h"
#import "NetworkClient.h"
#import "RepoModel.h"
#import "AppDelegate.h"

@interface HomeInteractorImpl()
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation HomeInteractorImpl

int currentPage = 0;
- (void)dealloc
{
    NSLog(@"deall form repo Home Interactor");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.context = [self managedObjectContext];
    }
    return self;
}
- (void)fetchRepositoriesWithCompletion:(completionHandler)completion {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://api.github.com/repositories"];
    [NetworkClient performRequestWithURL:url CompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (weakSelf == nil) {
            NSLog(@"self is nil");
            return ;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil , error);
            });
        }
        else{
                NSError *error = nil;
                NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(nil,error);
                    });
                    return;
                }
                //remove all records from core data entity
                [strongSelf deleteReposFromCoreData];
                //Loop on response to save in core data
                for (NSDictionary * responseDictionary in responseJSON) {
                    NSDictionary *ownerDict = responseDictionary[@"owner"];
                    NSString *description = responseDictionary[@"description"];
                    RepoModel *repository = RepoModel.new;
                    repository.repoName = responseDictionary[@"name"];;
                    repository.ownerName = ownerDict[@"login"];
                    repository.ownerAvatarURL = ownerDict[@"avatar_url"];
                    repository.contributorsURL = responseDictionary[@"contributors_url"];
                    repository.githubLink = responseDictionary[@"html_url"];
                    repository.languagesLink = responseDictionary[@"languages_url"];
                    if ([description isKindOfClass:[NSString class]]){
                        repository.repoDescription = description;
                    }
                    
                    [strongSelf saveDataToLocalDatabaseWithModel:repository];
                }
                //get first page to return
                NSMutableArray<RepoModel *> *repos = NSMutableArray.new;
                [repos addObjectsFromArray: [strongSelf fetchNewPageRepositories]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(repos , nil);
                });
        }
    }];
    
}

-(void) saveDataToLocalDatabaseWithModel: (RepoModel *) model {
    NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Repo" inManagedObjectContext: self.context];
    [transaction setValue:model.ownerName forKey:@"ownerName"];
    [transaction setValue:model.ownerAvatarURL forKey:@"ownerAvatarURL"];
    [transaction setValue:model.repoName forKey:@"repoName"];
    [transaction setValue:model.repoDescription forKey:@"repoDescription"];
    [transaction setValue:model.languagesLink forKey:@"languagesLink"];
    [transaction setValue:model.githubLink forKey:@"githubLink"];
    [transaction setValue:model.contributorsURL forKey:@"contributorsURL"];
    
    // Save the context
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
}
-(NSArray *) fetchNewPageRepositories{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.context]];
    NSError* error = nil;
    request.fetchOffset = currentPage * 10;
    request.fetchLimit = 10;
    NSArray* response = [self.context executeFetchRequest:request error:&error];
    if (error) {
        return @[];
    }
    currentPage += 1;
    return response;
    
}
-(void) deleteReposFromCoreData{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Repo"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    
    [self.context executeRequest:delete error:&deleteError];
    if (deleteError) {
        NSLog(@"error while deleting %@", deleteError);
    }
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = [[delegate persistentContainer] viewContext];
    }
    return context;
}

- (NSUInteger )numberOfReposInEntity {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Repo"];
    NSError *deleteError = nil;
    
    NSUInteger objectsCount = [self.context countForFetchRequest:request error:&deleteError];
    if (deleteError) {
        NSLog(@"error while deleting %@", deleteError);
    }
    return objectsCount;
}

@end
