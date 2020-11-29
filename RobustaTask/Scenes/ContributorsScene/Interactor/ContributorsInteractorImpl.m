//
//  ContributorsInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>
#import "ContributorsInteractorImpl.h"
#import "NetworkClient.h"
#import "ContributorsModel.h"

@implementation ContributorsInteractorImpl


- (void)dealloc
{
    NSLog(@"deall form repo contrib Interactor");
}


- (void)fetchContributorsWithURL:(NSURL *)url Completion:(completionHandler)completion {
    [NetworkClient performRequestWithURL:url CompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error){
            completion(nil , error);
        }
        else{
            NSError *error = nil;
            NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                completion(nil,error);
                return;
            }

            NSMutableArray<ContributorsModel *> *contributors = NSMutableArray.new;
            for (NSDictionary * contributorDictionary in responseJSON) {
                ContributorsModel *contributor = ContributorsModel.new;
                contributor.contributorName = contributorDictionary[@"login"];
                contributor.contributorAvatarURL = [[NSURL alloc] initWithString:contributorDictionary[@"avatar_url"]];
                
                [contributors addObject:contributor];
            }
            completion(contributors , nil);
        }
    }];

}

@end
