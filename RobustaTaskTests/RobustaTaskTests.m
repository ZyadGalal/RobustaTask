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
#import "RobustaTask-Swift.h"
#import "MockHomeInteractor.h"
#import "HomeRouterImpl.h"
#import "HomeRouter.h"
@interface RobustaTaskTests : XCTestCase

@end

@implementation RobustaTaskTests
HomeViewController *view;
id< HomeInteractor > interactor;
id< HomePresenter > presenter;
id<HomeRouter> router;
- (void)setUp {
    view = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    interactor = [[MockHomeInteractor alloc] init];
    router = [[HomeRouterImpl alloc] init];
    presenter = [[HomePresenterImpl alloc] init];
    [presenter initWithView:view interactor:interactor router:router];
    view.presenter = presenter;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testFetchRepo {
    __block NSArray *requestResponse = nil;
    
    [interactor fetchRepoWithCompletion:^(NSMutableArray * _Nullable response, NSError * _Nullable error) {
        requestResponse = response;
    }];
    NSAssert(requestResponse != nil, @"");
}
-(void) testPaginatingWithLastFiveElements {
    NSArray *response = [interactor fetchDataWithOffset:95];
    
    NSAssert(response.count == 5, @"");
}

@end
