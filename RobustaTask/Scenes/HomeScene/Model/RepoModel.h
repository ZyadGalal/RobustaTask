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
@property (nonatomic , strong) NSString *ownerAvatarURL;
@property (nonatomic , strong) NSString *contributorsURL;
@property (nonatomic , strong) NSString *githubLink;
@property (nonatomic , strong) NSString *languagesLink;
@property (nonatomic , strong) NSString * _Nullable repoDescription;

@end
