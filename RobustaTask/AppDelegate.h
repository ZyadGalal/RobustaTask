//
//  AppDelegate.h
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate , NSObject>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;


- (void)saveContext;
@end

