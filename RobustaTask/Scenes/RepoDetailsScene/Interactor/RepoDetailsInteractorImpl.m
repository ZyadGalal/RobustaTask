//
//  RepoDetailsInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "RepoDetailsInteractorImpl.h"
#import "NetworkClient.h"
@implementation RepoDetailsInteractorImpl



- (void)getUsedLanguagesFromURL:(NSURL *)url Completion:(comp)completionHandler {
    [NetworkClient performRequestWithURL:url CompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error){
            completionHandler(nil , error);
        }
        else{
            NSError *error = nil;
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                completionHandler(nil,error);
                return;
            }
            completionHandler(responseJSON , nil);
        }
    }];
}

@end
