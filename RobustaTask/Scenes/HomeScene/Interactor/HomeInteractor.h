//
//  HomeInteractor.h
//  RobustaTask
//
//  Created by Zyad Galal on 29/11/2020.
//

#import <Foundation/Foundation.h>

@protocol HomeInteractor <NSObject>
typedef void (^completionHandler)(NSMutableArray* _Nullable response , NSError* _Nullable error);

-(void) fetchRepoWithCompletion:(completionHandler _Nonnull) completion;
-(NSArray * _Nonnull) fetchDataWithOffset: (NSUInteger) offset;
-(NSUInteger ) numberOfReposInEntity;
@end
