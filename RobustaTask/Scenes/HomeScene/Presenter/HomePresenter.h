//
//  HomePresenter.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>
#import "HomeView.h"
#import "HomeInteractor.h"
#import "HomeRouter.h"
#import "RepoModel.h"

@protocol HomePresenter< NSObject >

@property (nonatomic , weak) id <HomeView> view;
@property (nonatomic , strong) id <HomeInteractor> interactor;
@property (nonatomic , strong) id <HomeRouter> router;
@property (nonatomic) BOOL isFetchingNewPage;

-(void) initWithView: (id < HomeView >) view interactor: (id < HomeInteractor >) interactor router: (id < HomeRouter >) router ;
-(void) viewDidLoad;
-(void) didSelectRepoAtIndex: (int) index;
-(void) fetchNewPage;
-(NSUInteger) repositoriesCount;
-(RepoModel *) getItemAtIndex: (int) index;
@end

