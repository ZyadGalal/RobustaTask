//
//  HomeInteractor.h
//  RobustaTask
//
//  Created by Zyad Galal on 29/11/2020.
//

#import <Foundation/Foundation.h>

@protocol HomeInteractor <NSObject>
typedef void (^completionHandler)(NSMutableArray* _Nullable response , NSError* _Nullable error);

-(void) fetchRepositoriesWithCompletion:(completionHandler _Nonnull) completion;
-(NSArray * _Nonnull) fetchNewPageRepositories;
-(NSUInteger ) numberOfReposInEntity;
@end
