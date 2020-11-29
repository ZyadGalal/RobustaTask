//
//  ContributorsPresenter.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "ContributorsInteractor.h"
#import "ContributorsRouter.h"
#import "ContributorsView.h"
#import "ContributorsModel.h"

@protocol ContributorsPresenter <NSObject>

@property (nonatomic , weak) id <ContributorsView> view;
@property (nonatomic , strong) id <ContributorsInteractor> interactor;
@property (nonatomic , strong) id <ContributorsRouter> router;

-(void) initWithView: (id < ContributorsView >) view interactor: (id < ContributorsInteractor >) interactor router: (id < ContributorsRouter >) router contributorsURL:(NSURL *) url;
-(void) viewDidLoad;
-(NSUInteger) repositoriesCount;
-(ContributorsModel *) getItemAtIndex: (int) index;

@end
