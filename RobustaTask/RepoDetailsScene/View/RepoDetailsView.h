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
-(void) updateUIWithModel: (RepoModel *) model languages: (NSDictionary *) languages totalLines:(int) totalLines ;
-(void) didFailFetchingDataWithError: (NSString *) error;

@end
