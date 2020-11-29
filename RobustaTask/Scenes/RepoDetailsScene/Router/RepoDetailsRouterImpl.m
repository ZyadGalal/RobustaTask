//
//  RepoDetailsRouterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "RepoDetailsRouterImpl.h"
#import "RobustaTask-Swift.h"
#import "ContributorsRouterImpl.h"
@implementation RepoDetailsRouterImpl


- (void)dealloc
{
    NSLog(@"deall form repo details Router");
}


+ (UIViewController *)createDetailsViewWithModel:(RepoModel *)model {
    RepoDetailsViewController *detailsView = [[RepoDetailsViewController alloc] initWithNibName:@"RepoDetailsViewController" bundle:nil];
    
    RepoDetailsInteractorImpl *interactor = [[RepoDetailsInteractorImpl alloc] init];
    RepoDetailsRouterImpl *router = [[RepoDetailsRouterImpl alloc] init];
    RepoDetailsPresenterImpl *presenter = [[RepoDetailsPresenterImpl alloc] init];
    
    [presenter initWithView:detailsView interactor:interactor router:router model:model];
    detailsView.presenter = presenter;
    return detailsView;
}

- (void)navigateToContributorsFromView:(id)view contributorsURL:(NSURL *)url { 
    UIViewController *contributorsView = [ContributorsRouterImpl createDetailsViewWithContributorsURL:url];
    if ([view isKindOfClass:[UIViewController class]]) {
        [[(UIViewController *) view navigationController] pushViewController:contributorsView animated:YES];
    }
}


@end
