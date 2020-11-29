//
//  HomeInteractor.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>

@protocol HomeInteractor <NSObject>
typedef void (^completionHandler)(NSMutableArray* _Nullable response , NSError* _Nullable error);

-(void) fetchRepoWithCompletion:(completionHandler) completion;
-(NSArray *) fetchDataWithOffset: (int) offset;
-(NSUInteger *) numberOfReposInEntity;
@end
