//
//  RepoDetailsPresenterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>
#import "RepoDetailsPresenterImpl.h"

@interface RepoDetailsPresenterImpl()
@end

@implementation RepoDetailsPresenterImpl

@synthesize interactor;
@synthesize router;
@synthesize view;
@synthesize model;

- (void)dealloc
{
    NSLog(@"deall form repo details presnenter");
}

- (void)initWithView:(id<RepoDetailsView>)view interactor:(id<RepoDetailsInteractor>)interactor router:(id<RepoDetailsRouter>)router model:(RepoModel *)model {
    self.view = view;
    self.interactor = interactor;
    self.router = router;
    self.model = model;
}

-(void) viewDidLoad {
    [self getLanguages];
}

- (void)didClickOnGithubButton {
    if ([[UIApplication sharedApplication] canOpenURL:[[NSURL alloc]initWithString:model.githubLink]]) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc]initWithString:model.githubLink] options:@{} completionHandler:nil];
    }
}

- (void)didClickOnContributorsButton {
    [self.router navigateToContributorsFromView:view contributorsURL:[[NSURL alloc]initWithString:model.contributorsURL]];
}

-(void) getLanguages {
    __weak typeof(self) weakSelf = self;

    [self.view showIndicator];
    [interactor getUsedLanguagesFromURL:[[NSURL alloc]initWithString: model.languagesLink] Completion:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        if (weakSelf == nil) {
            NSLog(@"self is nil");
            return ;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view hideIndicator];
        if (error) {
            [strongSelf.view didFailFetchingDataWithError:error.localizedDescription];
        }
        int totalLinesOfCode = 0;
        for (id key in response) {
            id value = response[key];
            totalLinesOfCode = totalLinesOfCode + [value intValue];
        }
        
        [strongSelf.view updateUIWithOwnerName:strongSelf.model.ownerName repoName:strongSelf.model.repoName avatarURL:[[NSURL alloc] initWithString: strongSelf.model.ownerAvatarURL] repoDescription:strongSelf.model.repoDescription languages:response totalLines:totalLinesOfCode];
        
    }];
}

@end
