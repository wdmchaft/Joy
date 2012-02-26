//
//  JoyAppDelegate_iPad.m
//  Joy
//
//  Created by mac on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "JoyAppDelegate_iPad.h"

@implementation JoyAppDelegate_iPad
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    /*
     NSString * FirstOpenAppString = [UserDefaultKeySet retrieveFromUserDefaultsByKey:FIRST_OPEN_APP];
     if (FirstOpenAppString == nil) {
     [self MakeSureWhichControllerShouldBeOpen];  
     }else if([FirstOpenAppString isEqualToString:COVER_FLAG_ZERO]){
     
     }else{
     
     }
     */
    //[self coverControllerShouldOpen];
    [self joyControllerShouldOpen];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) makeSureWhichControllerShouldBeOpen{
    
}

- (void) coverControllerShouldOpen{
    self.window.rootViewController = self.tabBarController;
}

- (void) joyControllerShouldOpen{
    RootViewController_iPad *rootViewController = [[RootViewController_iPad alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
    rootViewController.title = @"Sex Positions";
    navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navigationController;
    [rootViewController release];
}

- (void)dealloc
{
    [tabBarController release];
	[super dealloc];
}

@end
