//
//  HomeInteractorImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import "HomeInteractorImpl.h"
#import "NetworkClient.h"
#import "RepoModel.h"

@implementation HomeInteractorImpl

- (void)fetchRepoWithCompletion:(completionHandler)completion {
    NSURL *url = [[NSURL alloc] initWithString:@"https://api.github.com/repositories"];
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

            NSMutableArray<RepoModel *> *repos = NSMutableArray.new;
            for (NSDictionary * repoDict in responseJSON) {
                NSString *name = repoDict[@"name"];
                NSDictionary *ownerDict = repoDict[@"owner"];
                NSString *ownerName = ownerDict[@"login"];
                NSString *ownerAvatar = ownerDict[@"avatar_url"];
                NSString *contributorsURL = repoDict[@"contributors_url"];
                NSString *githubLink = repoDict[@"html_url"];
                NSString *languageLink = repoDict[@"languages_url"];
                NSString *description = repoDict[@"description"];
                RepoModel *repository = RepoModel.new;
                repository.repoName = name;
                repository.ownerName = ownerName;
                repository.ownerAvatarURL = [[NSURL alloc] initWithString:ownerAvatar];
                repository.contributorsURL = [[NSURL alloc] initWithString:contributorsURL];
                repository.githubLink = [[NSURL alloc] initWithString:githubLink];
                repository.languagesLink = [[NSURL alloc] initWithString:languageLink];
                if ([description isKindOfClass:[NSString class]]){
                    repository.repoDescription = description;
                }
                else{
                    repository.repoDescription = nil;
                }
                [repos addObject:repository];
            }
            completion(repos , nil);
        }
    }];
}

@end
