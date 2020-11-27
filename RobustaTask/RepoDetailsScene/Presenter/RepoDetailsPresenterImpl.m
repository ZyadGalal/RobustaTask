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
    if ([[UIApplication sharedApplication] canOpenURL:model.githubLink]) {
        [[UIApplication sharedApplication] openURL:model.githubLink options:@{} completionHandler:nil];
    }
}

-(void) getLanguages {
    [self.view showIndicator];
    [interactor getUsedLanguagesFromURL:model.languagesLink Completion:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.view hideIndicator];
        if (error) {
            [self.view didFailFetchingDataWithError:error.localizedDescription];
        }
        int totalLinesOfCode = 0;
        for (id key in response) {
            id value = response[key];
            totalLinesOfCode = totalLinesOfCode + [value intValue];
        }
        [self.view updateUIWithModel:self.model languages:response totalLines:totalLinesOfCode];
    }];
}

@end
