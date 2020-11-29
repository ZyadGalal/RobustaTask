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


- (void)dealloc
{
    NSLog(@"deall form repo Home Interactor");
}


- (void)fetchRepoWithCompletion:(completionHandler)completion {
    __weak typeof(self) weakSelf = self;

    NSURL *url = [[NSURL alloc] initWithString:@"https://api.github.com/repositories"];
    [NetworkClient performRequestWithURL:url CompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (weakSelf == nil) {
            NSLog(@"self is nil");
            return ;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error){
            completion(nil , error);
        }
        else{
            NSError *error = nil;
            NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                completion(nil,error);
                return;
            }
            strongSelf.context = [strongSelf managedObjectContext];
            [strongSelf deleteReposFromCoreData];
            for (NSDictionary * repoDict in responseJSON) {
                NSDictionary *ownerDict = repoDict[@"owner"];
                NSString *description = repoDict[@"description"];
                RepoModel *repository = RepoModel.new;
                repository.repoName = repoDict[@"name"];;
                repository.ownerName = ownerDict[@"login"];
                repository.ownerAvatarURL = ownerDict[@"avatar_url"];
                repository.contributorsURL = repoDict[@"contributors_url"];
                repository.githubLink = repoDict[@"html_url"];
                repository.languagesLink = repoDict[@"languages_url"];
                if ([description isKindOfClass:[NSString class]]){
                    repository.repoDescription = description;
                }
                else{
                    repository.repoDescription = nil;
                }
                [strongSelf saveDataToLocalDatabaseWithModel:repository];
            }
            NSMutableArray<RepoModel *> *repos = NSMutableArray.new;
            [repos addObjectsFromArray: [strongSelf fetchDataWithOffset:0]];
            completion(repos , nil);
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
-(NSArray *) fetchDataWithOffset: (int) offset {
    //self.context = [self managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.context]];
    NSError* error = nil;
    request.fetchOffset = offset;
    request.fetchLimit = 10;
    NSArray* response = [self.context executeFetchRequest:request error:&error];
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

- (NSUInteger *)numberOfReposInEntity {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Repo"];
    NSError *deleteError = nil;

    NSUInteger* objectsCount = (NSUInteger) [self.context countForFetchRequest:request error:&deleteError];
    if (deleteError) {
        NSLog(@"error while deleting %@", deleteError);
    }
    return objectsCount;
}

@end
