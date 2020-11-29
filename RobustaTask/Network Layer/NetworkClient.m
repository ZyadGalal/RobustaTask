//
//  NetworkClient.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import "NetworkClient.h"

@implementation NetworkClient

+ (void)performRequestWithURL:(NSURL *)url CompletionHandler:(completion)completion {
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"finished fetching data");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                completion(nil,error);
            }
            else{
                completion(data,nil);
            }
        });
    }] resume];
}

@end
