//
//  JoyAppDelegate_iPhone.h
//  Joy
//
//  Created by mac on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoyAppDelegate.h"
#import "UserDefaultKeySet.h"
#import "CoverRootController_iPhone.h"
#import "RootViewController_iPhone.h"

@interface JoyAppDelegate_iPhone : JoyAppDelegate <UINavigationControllerDelegate>{
    UITabBarController      *   tabBarController;
    UINavigationController  *   navigationController;
}
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (void) makeSureWhichControllerShouldBeOpen;
- (void) coverControllerShouldOpen;
- (void) joyControllerShouldOpen;
@end
