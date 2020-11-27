//
//  HomePresenterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>
#import "HomePresenterImpl.h"

@interface HomePresenterImpl()
@property (strong , nonatomic) NSMutableArray<RepoModel *> *repositories;
@end

@implementation HomePresenterImpl

@synthesize view;
@synthesize router;
@synthesize interactor;

-(void) initWithView:(id<HomeView>)view interactor:(id<HomeInteractor>)interactor router:(id<HomeRouter>)router {
    self.view = view;
    self.router = router;
    self.interactor = interactor;
}
- (void)viewDidLoad{
    [self fetchRepositories];
}
- (void) fetchRepositories {
    [self.view showIndicator];
    [interactor fetchRepoWithCompletion:^(NSMutableArray * _Nullable response, NSError * _Nullable error) {
        [self.view hideIndicator];
        if (error) {
            [self.view didFailFetchingDataWithError:error.localizedDescription];
        }
        else{
            self.repositories = response;
            [self.view didFetchDataSuccessfully];
        }
    }];
}
- (NSUInteger) repositoriesCount{
    return [self.repositories count];
}

- (RepoModel *)getItemAtIndex:(int)index {
    return self.repositories[index];
}

- (void)didSelectRepoAtIndex:(int)index {
    [router navigateToRepoDetailsFromView:view repoModel:self.repositories[index]];
}



@end
