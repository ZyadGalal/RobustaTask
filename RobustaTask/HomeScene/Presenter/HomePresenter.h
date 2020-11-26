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

@property (nonatomic , strong) id <HomeView> view;
@property (nonatomic , strong) id <HomeInteractor> interactor;
@property (nonatomic , strong) id <HomeRouter> router;

-(void) initWithView: (id < HomeView >) view interactor: (id < HomeInteractor >) interactor router: (id < HomeRouter >) router ;
-(void) viewDidLoad;
-(NSUInteger) repositoriesCount;
-(RepoModel *) getItemAtIndex: (int) index;
@end

