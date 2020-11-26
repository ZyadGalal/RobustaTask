//
//  HomePresenterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <Foundation/Foundation.h>
#import "HomePresenterImpl.h"
@implementation HomePresenterImpl

@synthesize view;
@synthesize router;
@synthesize interactor;

-(void) initWithView:(id<HomeView>)view interactor:(id<HomeInteractor>)interactor router:(id<HomeRouter>)router {
    self.view = view;
    self.router = router;
    self.interactor = interactor;
}

@end
