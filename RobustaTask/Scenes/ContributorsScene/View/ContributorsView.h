//
//  ContributorsView.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

@protocol ContributorsView <NSObject>

-(void) didFetchDataSuccessfully;
-(void) didFailFetchingDataWithError: (NSString *) error;
-(void) showIndicator;
-(void) hideIndicator;

@end
