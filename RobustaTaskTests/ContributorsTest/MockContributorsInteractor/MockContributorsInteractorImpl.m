//
//  ContributorsInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>
#import "MockContributorsInteractor.h"
#import "ContributorsModel.h"

@implementation MockContributorsInteractor


- (void)dealloc
{
    NSLog(@"deall form repo contrib Interactor");
}


- (void)fetchContributorsWithURL:(NSURL *)url Completion:(completionHandler)completion {
    NSError *error = nil;
    NSDictionary *jsonObject = @[@{@"login" : @"Zyad" , @"avatar_url": @"galal"} , @{@"login" : @"Zyad" , @"avatar_url": @"galal"},@{@"login" : @"Zyad" , @"avatar_url": @"galal"}];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil,error);
            return;
        });
    }
    
    if ([NSJSONSerialization isValidJSONObject:jsonObject] == YES) {
        
        NSLog(@" ;) \n");
    }
    else{
        
        NSLog(@"Epic Fail! \n");
        
    }
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray<ContributorsModel *> *contributors = NSMutableArray.new;
    for (NSDictionary * contributorDictionary in responseJSON) {
        ContributorsModel *contributor = ContributorsModel.new;
        contributor.contributorName = contributorDictionary[@"login"];
        contributor.contributorAvatarURL = [[NSURL alloc] initWithString:contributorDictionary[@"avatar_url"]];
        [contributors addObject:contributor];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(contributors , nil);
    });
}




@end
