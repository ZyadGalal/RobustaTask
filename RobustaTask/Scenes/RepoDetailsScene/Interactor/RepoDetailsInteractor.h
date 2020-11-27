//
//  RepoDetailsInteractor.h
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>

@protocol RepoDetailsInteractor <NSObject>

typedef void (^comp)(NSDictionary* _Nullable response , NSError* _Nullable error);


-(void) getUsedLanguagesFromURL: (NSURL *) url Completion:(comp) completionHandler;

@end
