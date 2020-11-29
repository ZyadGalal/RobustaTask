//
//  ContributorsPresenterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>
#import "ContributorsPresenterImpl.h"

@interface ContributorsPresenterImpl()
@property (nonatomic , strong) NSURL *contributorsURL;
@property (nonatomic , strong) NSMutableArray<ContributorsModel *> *contributors;

@end
@implementation ContributorsPresenterImpl

@synthesize interactor;
@synthesize router;
@synthesize view;


- (void)dealloc
{
    NSLog(@"deall form repo contri presnenter");
}

- (void)initWithView:(id<ContributorsView>)view interactor:(id<ContributorsInteractor>)interactor router:(id<ContributorsRouter>)router contributorsURL:(NSURL *)url {
    self.view = view;
    self.interactor = interactor;
    self.router = router;
    self.contributorsURL = url;
}
-(void) viewDidLoad {
    [self getContributors];
}

- (ContributorsModel *)getItemAtIndex:(int)index {
    return self.contributors[index];
}


- (NSUInteger)repositoriesCount {
    return self.contributors.count;
}

-(void) getContributors {
    __weak typeof(self) weakSelf = self;
    [self.view showIndicator];
    [interactor fetchContributorsWithURL:self.contributorsURL Completion:^(NSMutableArray * _Nullable response, NSError * _Nullable error) {
        if (weakSelf == nil) {
            NSLog(@"self is nil");
            return;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view hideIndicator];
        if (error) {
            [strongSelf.view didFailFetchingDataWithError:error.localizedDescription];
        }
        else{
            strongSelf.contributors = response;
            [strongSelf.view didFetchDataSuccessfully];
        }
    }];
}
@end
