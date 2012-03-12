//
//  JoyAppDelegate_iPhone.m
//  Joy
//
//  Created by mac on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "JoyAppDelegate_iPhone.h"

@implementation JoyAppDelegate_iPhone
@synthesize tabBarController;
@synthesize navigationController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [MobClick setDelegate:self reportPolicy:BATCH];
    NSString * FirstOpenAppString = [UserDefaultKeySet retrieveFromUserDefaultsByKey:FIRST_OPEN_APP];
    if (FirstOpenAppString == nil) {
        [self makeSureWhichControllerShouldBeOpen];  
    }else if([FirstOpenAppString isEqualToString:COVER_FLAG_ZERO]){
        [self coverControllerShouldOpen];
    }else{
        [self joyControllerShouldOpen];
    }
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.DATABASE_NAME = DATABASE_CH;
    
    //[self coverControllerShouldOpen];
    //[self joyControllerShouldOpen]; 
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)judgeIfDatabaseIsCH{
    NSString *  currentLanguage     =   [[NSLocale preferredLanguages] objectAtIndex:0];
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
        appDelegate.DATABASE_NAME = DATABASE_CH;
    }else{
        appDelegate.DATABASE_NAME = DATABASE_US;
    }
}

- (void) makeSureWhichControllerShouldBeOpen{
    if ([UserDefaultKeySet intervalSinceNow:COVER_OPEN_TIME] == 1) {
        [UserDefaultKeySet saveToUserDefaults:@"1" forKey:FIRST_OPEN_APP];
        [self joyControllerShouldOpen];
    }else{
        if ([[UserDefaultKeySet getSignFromServer] intValue] == 1) {
            [UserDefaultKeySet saveToUserDefaults:@"1" forKey:FIRST_OPEN_APP];
            [self joyControllerShouldOpen];
        }else{            
            [UserDefaultKeySet saveToUserDefaults:@"0" forKey:FIRST_OPEN_APP];
            [self coverControllerShouldOpen];
        }  
    }
}

- (void) coverControllerShouldOpen{
    self.window.rootViewController = self.tabBarController;
}

- (void) joyControllerShouldOpen{
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:COVER_PAGE_IPHONE]];
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.SELF_AD_URL = [SELF_AD_URL_HEAD stringByAppendingString:[UserDefaultKeySet getAdSignFromServer]];
    appDelegate.ADMOB_ID_IPHONE = [UserDefaultKeySet getAdMobIdiPhoneFromServer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                      target: self
                                                    selector: @selector(joyControllerOpen)
                                                    userInfo: nil
                                                     repeats: NO];
}

- (void) joyControllerOpen{
    RootViewController_iPhone *rootViewController = [[RootViewController_iPhone alloc] initWithNibName:@"RootViewController_iPhone" bundle:nil];
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.DATABASE_NAME isEqualToString:DATABASE_CH]) {
        rootViewController.title = @"性趣";
    }else{
        rootViewController.title = @"Sex Positions";
    }
    BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
    if(isProUpgradePurchased == NO){           
        if ([UserDefaultKeySet judgeNetworkReachability] == YES) {
            appDelegate.SCROLLVIEW_HEIGHT   =   30;
            appDelegate.IMAGEVIEW_HEIGHT    =   230;
            appDelegate.TEXTVIEW_HEIGHT     =   260;
            appDelegate.BUTTONVIEW_HEIGHT   =   345;
            appDelegate.SCROLLVIEW_HEIGHT_F =   240;
        }else{
            appDelegate.SCROLLVIEW_HEIGHT   =   50;
            appDelegate.IMAGEVIEW_HEIGHT    =   270;
            appDelegate.TEXTVIEW_HEIGHT     =   300;
            appDelegate.BUTTONVIEW_HEIGHT   =   390;
            appDelegate.SCROLLVIEW_HEIGHT_F =   260;
        }
    }else{
        appDelegate.SCROLLVIEW_HEIGHT   =   50;
        appDelegate.IMAGEVIEW_HEIGHT    =   270;
        appDelegate.TEXTVIEW_HEIGHT     =   300;
        appDelegate.BUTTONVIEW_HEIGHT   =   390;
        appDelegate.SCROLLVIEW_HEIGHT_F =   260;
    }
    appDelegate.JOY_SOUND_FLAG = 1;
    navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navigationController;
    [rootViewController release];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {        
        if ([self.navigationController.viewControllers count] == 1) {
            [self.navigationController.topViewController viewWillAppear:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }  
}

- (void)dealloc
{
    [tabBarController release];
    [navigationController release];
	[super dealloc];
}

@end
