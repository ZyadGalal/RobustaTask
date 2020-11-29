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

@property (nonatomic) NSUInteger numberOfRepos;

@end

@implementation HomePresenterImpl

@synthesize view;
@synthesize router;
@synthesize interactor;
@synthesize isFetchingNewPage = _isFetchingNewPage;


- (void)dealloc
{
    NSLog(@"deall form repo Home presnenter");
}

-(void) initWithView:(id<HomeView>)view interactor:(id<HomeInteractor>)interactor router:(id<HomeRouter>)router {
    self.view = view;
    self.router = router;
    self.interactor = interactor;
}
- (void)viewDidLoad{
    self.isFetchingNewPage = FALSE;
    [self fetchRepositories];
}
- (void) fetchRepositories {
    __weak typeof(self) weakSelf = self;
    [self.view showIndicator];
    [interactor fetchRepoWithCompletion:^(NSMutableArray * _Nullable response, NSError * _Nullable error) {
        if (weakSelf == nil) {
            NSLog(@"self is nil");
            return ;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view hideIndicator];
        if (error) {
            [strongSelf.view didFailFetchingDataWithError:error.localizedDescription];
        }
        else{
            strongSelf.repositories = response;
            strongSelf.numberOfRepos = [strongSelf.interactor numberOfReposInEntity];
            [strongSelf.view didFetchDataSuccessfully];
        }
    }];
}
//MARK: -fetch new page from coredata
- (void)fetchNewPage {
    self.isFetchingNewPage = TRUE;
    if ([self.repositories count] < self.numberOfRepos){
        [self.repositories addObjectsFromArray:[interactor fetchDataWithOffset:self.repositories.count]];
        [self.view didFetchDataSuccessfully];
        self.isFetchingNewPage = FALSE;
    }
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
