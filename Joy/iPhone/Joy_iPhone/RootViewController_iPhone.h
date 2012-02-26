//
//  RootViewController_iPhone.h
//  Joy
//
//  Created by mac on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Utils.h"
#import "SQLData.h"
#import "JoyAppDelegate.h"

#import "CategoryViewController_iPhone.h"
#import "SettingViewController_iPhone.h"
#import "ItemViewController_iPhone.h"
#import "ItemShowController_iPhone.h"
//#import "PasswordController_iPhone.h"
#import "SliderViewController_iPhone.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"
@class SQLiteOperation;
@interface RootViewController_iPhone : UIViewController <AVAudioPlayerDelegate,UITextFieldDelegate,AdWhirlDelegate>{
    NSArray         *       labelTitle;
    AVAudioPlayer   *       tapPlayer;
    UIView          *       view;
    NSArray         *       password;
}
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;

- (void) initItems;
- (void) ifPassWord;
- (void) cleanPasswordView;
- (void) cleanItemsView;
- (void) addAdWhirlAds;
@end
