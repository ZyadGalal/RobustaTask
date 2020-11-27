//
//  RepoDetailsPresenter.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "RepoDetailsView.h"
#import "RepoDetailsRouterImpl.h"
#import "RepoDetailsInteractorImpl.h"

@protocol RepoDetailsPresenter <NSObject>

@property (nonatomic , strong) id <RepoDetailsView> view;
@property (nonatomic , strong) id <RepoDetailsInteractor> interactor;
@property (nonatomic , strong) id <RepoDetailsRouter> router;
@property (nonatomic , strong) RepoModel *model;
-(void) initWithView: (id <RepoDetailsView> ) view interactor:(id <RepoDetailsInteractor>) interactor router:(id<RepoDetailsRouter>) router model:(RepoModel *)model;
@end
