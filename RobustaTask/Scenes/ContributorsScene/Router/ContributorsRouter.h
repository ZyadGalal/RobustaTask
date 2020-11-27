//
//  ContributorsRouter.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <UIKit/UIKit.h>
@protocol ContributorsRouter <NSObject>

+(UIViewController *) createDetailsViewWithContributorsURL:(NSURL *) url ;


@end
