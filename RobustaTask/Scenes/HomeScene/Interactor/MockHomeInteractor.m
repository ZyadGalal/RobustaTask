//
//  MockHomeInteractor.m
//  RobustaTaskTests
//
//  Created by Zyad Galal on 29/11/2020.
//

#import <Foundation/Foundation.h>
#import "MockHomeInteractor.h"
#import <CoreData/CoreData.h>
#import "RepoModel.h"
#import "AppDelegate.h"

@interface MockHomeInteractor()
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation MockHomeInteractor
int currentPage = 0;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.context = [self managedObjectContext];
    }
    return self;
}

- (void)fetchRepositoriesWithCompletion:(completionHandler)completion {
    NSError *error = nil;
    NSDictionary *jsonObject = @[@{@"name" : @"Zyad"
                                   , @"contributors_url":@"https://api.github.com/repos/mojombo/grit/contributors"
                                   , @"languages_url": @"https://api.github.com/repos/mojombo/grit/languages"
                                   , @"html_url" : @"https://github.com/ZyadGalal/RobustaTask"
                                   , @"description":@"zyad mahmoud galal"
                                   , @"owner" : @{
                                           @"login" : @"Zyad Galal"
                                           ,@"avatar_url": @"galal"
                                   }}];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil,error);
            return;
        });
    }
    
    if ([NSJSONSerialization isValidJSONObject:jsonObject] == YES) {
        NSLog(@" ;) \n");
    }
    else{
        NSLog(@"Epic Fail! \n");
        
    }
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    //remove all records from core data entity
    [self deleteReposFromCoreData];

    //Loop on response to save in core data

    for (NSDictionary *responseDictionary in responseJSON) {
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
        
        for (int i = 0 ; i < 100 ; i++){
            [self saveDataToLocalDatabaseWithModel:repository];
        }
    }

    
    //get first page to return
    NSMutableArray<RepoModel *> *repos = NSMutableArray.new;
    [repos addObjectsFromArray: [self fetchNewPageRepositories]];
    completion(repos , nil);

}

-(void) saveDataToLocalDatabaseWithModel: (RepoModel *) model {
    self.context = [self managedObjectContext];
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
    self.context = [self managedObjectContext];
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
    self.context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Repo"];
    NSError *deleteError = nil;
    
    NSUInteger objectsCount = [self.context countForFetchRequest:request error:&deleteError];
    if (deleteError) {
        NSLog(@"error while deleting %@", deleteError);
    }
    return objectsCount;
}
@end
