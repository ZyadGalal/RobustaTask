//
//  RobustaTaskTests.m
//  RobustaTaskTests
//
//  Created by Zyad Galal on 29/11/2020.
//

#import <XCTest/XCTest.h>
#import "HomeInteractor.h"
#import "HomeView.h"
#import "HomePresenter.h"
#import "HomePresenterImpl.h"
#import "RobustaTaskTests-Swift.h"
#import "MockHomeInteractor.h"
#import "HomeRouterImpl.h"
#import "HomeRouter.h"

@interface RobustaTaskTests : XCTestCase

@end

@implementation RobustaTaskTests
MockHomeViewController *mockView;
id< HomeInteractor > interactor;
id< HomePresenter > presenter;
id<HomeRouter> router;
- (void)setUp {
    mockView = [[MockHomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    interactor = [[MockHomeInteractor alloc] init];
    router = [[HomeRouterImpl alloc] init];
    presenter = [[HomePresenterImpl alloc] init];
    [presenter initWithView:mockView interactor:interactor router:router];
    
    mockView.presenter = presenter;
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testFetchRepoNotNil {
    __block NSArray *requestResponse = nil;
    [interactor fetchRepositoriesWithCompletion:^(NSMutableArray * _Nullable response, NSError * _Nullable error) {
        requestResponse = response;
    }];
    NSAssert(requestResponse != nil, @"");
}
-(void) testFetchRepoCount {
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    mockView.expectation = expectation;
    [presenter viewDidLoad];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSUInteger itemsCount = [presenter repositoriesCount];
        NSAssert(itemsCount == 10 , @"");
    }];

    

}
-(void) testPaginating {
    NSArray *response = [interactor fetchNewPageRepositories];
    
    NSAssert(response.count == 10, @"");
}
-(void) testRepositoriesCount{
    [presenter viewDidLoad];
    NSInteger repoCount = [presenter repositoriesCount];
    NSAssert(repoCount == 10, @"");
}

@end
