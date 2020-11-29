//
//  NetworkClient.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import<Foundation/Foundation.h>

@interface NetworkClient : NSObject

typedef void (^completion)(NSData* _Nullable  data , NSError* _Nullable  error);

+(void) performRequestWithURL: (NSURL* _Nonnull) url CompletionHandler: (completion _Nullable) completion;

@end
