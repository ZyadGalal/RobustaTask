//
//  RepoModel.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>

@interface RepoModel : NSObject

@property (nonatomic , strong) NSString *repoName;
@property (nonatomic , strong) NSString *ownerName;
@property (nonatomic , strong) NSURL *ownerAvatarURL;

@end
