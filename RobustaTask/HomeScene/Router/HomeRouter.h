//
//  HomeRouter.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"

@protocol HomeRouter < NSObject >

+(UIViewController *) createHomeView;
-(void) navigateToRepoDetailsFromView: (id<HomeView>) view;
@end
