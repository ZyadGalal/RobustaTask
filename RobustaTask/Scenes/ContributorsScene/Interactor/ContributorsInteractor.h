//
//  ContributorsInteractor.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

@protocol ContributorsInteractor <NSObject>

typedef void (^completionHandler)(NSMutableArray* _Nullable response , NSError* _Nullable error);

-(void) fetchContributorsWithURL:(NSURL * _Nonnull) url Completion:(completionHandler _Nullable) completion;

@end
