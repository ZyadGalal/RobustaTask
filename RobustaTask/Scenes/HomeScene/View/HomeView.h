//
//  HomeView.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>

@protocol HomeView <NSObject>
-(void) didFetchNewPage;
-(void) didFetchDataSuccessfully;
-(void) didFailFetchingDataWithError: (NSString *) error;
-(void) showIndicator;
-(void) hideIndicator;
@end
