//
//  RepoDetailsPresenterImpl.m
//  RobustaTask
//
//  Created by Zyad Galal on 27/11/2020.
//

#import <Foundation/Foundation.h>
#import "RepoDetailsPresenterImpl.h"

@implementation RepoDetailsPresenterImpl



@synthesize interactor;
@synthesize router;
@synthesize view;

- (void)initWithView:(id<RepoDetailsView>)view interactor:(id<RepoDetailsInteractor>)interactor router:(id<RepoDetailsRouter>)router {
    self.view = view;
    self.interactor = interactor;
    self.router = router;
}

@end
