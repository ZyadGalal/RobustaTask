//
//  HomeRouterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <UIKit/UIKit.h>
#import "HomeRouterImpl.h"
#import "RobustaTask-Swift.h"

@implementation HomeRouterImpl

+ (UIViewController *)createHomeView {
    HomeViewController *homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    HomeInteractorImpl *interactor = [[HomeInteractorImpl alloc] init];
    HomeRouterImpl *router = [[HomeRouterImpl alloc] init];
    HomePresenterImpl *presenter = [[HomePresenterImpl alloc] init];
    [presenter initWithView:homeView interactor:interactor router:router];
    homeView.presenter = presenter;
    return homeView;;
    
}

@end
