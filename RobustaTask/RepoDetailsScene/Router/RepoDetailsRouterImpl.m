//
//  RepoDetailsRouterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "RepoDetailsRouterImpl.h"
#import "RobustaTask-Swift.h"

@implementation RepoDetailsRouterImpl



+ (UIViewController *)createDetailsView {
    RepoDetailsViewController *detailsView = [[RepoDetailsViewController alloc] initWithNibName:@"RepoDetailsViewController" bundle:nil];
    
    RepoDetailsInteractorImpl *interactor = [[RepoDetailsInteractorImpl alloc] init];
    RepoDetailsRouterImpl *router = [[RepoDetailsRouterImpl alloc] init];
    RepoDetailsPresenterImpl *presenter = [[RepoDetailsPresenterImpl alloc] init];
    
    [presenter initWithView:detailsView interactor:interactor router:router];
    detailsView.presenter = presenter;
    return detailsView;
    
}

@end
