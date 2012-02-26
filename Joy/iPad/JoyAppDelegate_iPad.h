//
//  JoyAppDelegate_iPad.h
//  Joy
//
//  Created by mac on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoyAppDelegate.h"
#import "UserDefaultKeySet.h"
#import "CoverRootController_iPad.h"
#import "RootViewController_iPad.h"

@interface JoyAppDelegate_iPad : JoyAppDelegate <UINavigationControllerDelegate>{
    UITabBarController      *   tabBarController;
    UINavigationController  *   navigationController;
}
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (void) makeSureWhichControllerShouldBeOpen;
- (void) coverControllerShouldOpen;
- (void) joyControllerShouldOpen;

@end
