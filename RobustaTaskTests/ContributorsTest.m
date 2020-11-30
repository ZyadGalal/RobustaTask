//
//  ContributorsTest.m
//  RobustaTaskTests
//
//  Created by Zyad Galal on 30/11/2020.
//

#import <XCTest/XCTest.h>
#import "ContributorsInteractor.h"
#import "ContributorsView.h"
#import "ContributorsPresenter.h"
#import "ContributorsPresenterImpl.h"
#import "RobustaTaskTests-Swift.h"
#import "MockContributorsInteractor.h"
#import "ContributorsRouterImpl.h"
#import "ContributorsRouter.h"

@interface ContributorsTest : XCTestCase

@end

@implementation ContributorsTest
MockContributorsViewController *contributorsView;
id< ContributorsInteractor > contributorsInteractor;
id< ContributorsPresenter > contributorsPresenter;
id<ContributorsRouter> contributorsRouter;
- (void)setUp {
    contributorsView = [[MockContributorsViewController alloc] initWithNibName:@"ContributorsViewController" bundle:nil];
    contributorsInteractor = [[MockContributorsInteractor alloc] init];
    contributorsRouter = [[ContributorsRouterImpl alloc] init];
    contributorsPresenter = [[ContributorsPresenterImpl alloc] init];
    
    [contributorsPresenter initWithView:contributorsView interactor:contributorsInteractor router:contributorsRouter contributorsURL:[[NSURL alloc] initWithString:@"https://api.github.com/repos/wycats/merb-core/contributors"]];
    
    contributorsView.presenter = contributorsPresenter;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGetContributors {
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    contributorsView.expectation = expectation;
    [contributorsPresenter viewDidLoad];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSUInteger itemsCount = [contributorsPresenter contributorsCount];
        NSAssert(itemsCount == 3, @"");
    }];
}

@end
