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

- (void)fetchRepoWithCompletion:(completionHandler)completion {
    
    self.context = [self managedObjectContext];
    //remove all records from core data entity
    [self deleteReposFromCoreData];
    //Loop on response to save in core data
    RepoModel *repository = RepoModel.new;
    repository.repoName = @"zyad galal";
    repository.ownerName = @"zyad galal";
    repository.ownerAvatarURL = @"zyad galal";
    repository.contributorsURL = @"zyad galal";
    repository.githubLink = @"zyad galal";
    repository.languagesLink = @"zyad galal";
    repository.repoDescription = @"zyad galal";
    
    for (int i = 0 ; i < 100 ; i++){
        [self saveDataToLocalDatabaseWithModel:repository];
    }
    //get first page to return
    NSMutableArray<RepoModel *> *repos = NSMutableArray.new;
    [repos addObjectsFromArray: [self fetchDataWithOffset:0]];
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
-(NSArray *) fetchDataWithOffset: (NSUInteger) offset {
    self.context = [self managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.context]];
    NSError* error = nil;
    request.fetchOffset = offset;
    request.fetchLimit = 10;
    NSArray* response = [self.context executeFetchRequest:request error:&error];
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
