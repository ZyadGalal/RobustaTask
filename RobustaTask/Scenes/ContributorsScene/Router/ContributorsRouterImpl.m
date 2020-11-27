//
//  ContributorsRouterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "ContributorsRouterImpl.h"
#import "RobustaTask-Swift.h"

@implementation ContributorsRouterImpl

+ (UIViewController *)createDetailsViewWithContributorsURL:(NSURL *)url {
    ContributorsViewController *contributorsView = [[ContributorsViewController alloc] initWithNibName:@"ContributorsViewController" bundle:nil];
    
    ContributorsInteractorImpl *interactor = [[ContributorsInteractorImpl alloc] init];
    ContributorsRouterImpl *router = [[ContributorsRouterImpl alloc] init];
    ContributorsPresenterImpl *presenter = [[ContributorsPresenterImpl alloc] init];

    [presenter initWithView:contributorsView interactor:interactor router:router contributorsURL:url];

    contributorsView.presenter = presenter;
    return contributorsView;
}

@end
