//
//  RepoDetailsRouter.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import<UIkit/UIKit.h>
#import "RepoModel.h"
#import "RepoDetailsView.h"
@protocol RepoDetailsRouter <NSObject>

+(UIViewController *) createDetailsViewWithModel:(RepoModel *) model ;
-(void) navigateToContributorsFromView: (id<RepoDetailsView>) view contributorsURL:(NSURL *) url;

@end
