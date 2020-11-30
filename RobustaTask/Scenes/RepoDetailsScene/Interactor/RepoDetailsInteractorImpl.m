//
//  RepoDetailsInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import "RepoDetailsInteractorImpl.h"
#import "NetworkClient.h"
@implementation RepoDetailsInteractorImpl

- (void)dealloc
{
    NSLog(@"deall form repo details Interactor");
}

- (void)getUsedLanguagesFromURL:(NSURL *)url Completion:(comp)completionHandler {
    [NetworkClient performRequestWithURL:url CompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil , error);
            });
        }
        else{
            NSError *error = nil;
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler(nil,error);
                    return;
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(responseJSON , nil);
            });
        }
    }];
}

@end
