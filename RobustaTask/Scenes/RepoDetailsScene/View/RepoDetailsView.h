//
//  RepoDetailsView.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//
#import "RepoModel.h"
@protocol RepoDetailsView <NSObject>

-(void) showIndicator;
-(void) hideIndicator;
-(void) updateUIWithOwnerName: (NSString *) name repoName:(NSString *) repoName avatarURL: (NSURL *) url repoDescription: (NSString *) description languages: (NSDictionary *) languages totalLines:(int) totalLines ;
-(void) didFailFetchingDataWithError: (NSString *) error;

@end
