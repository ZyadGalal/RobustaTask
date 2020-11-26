//
//  AppDelegate.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import "AppDelegate.h"
#import "HomeRouterImpl.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: [HomeRouterImpl createHomeView]];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];

    return YES;
}


@end
