//
//  RootViewController_iPad.h
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Utils.h"
#import "SQLData.h"

#import "JoyAppDelegate.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"
#import "CategoryViewController_iPad.h"
#import "ItemViewController_iPad.h"
#import "ItemShowController_iPad.h"
#import "PasswordController_iPad.h"
#import "SliderViewController_iPad.h"
#import "ProgressBarController_iPad.h"

@interface RootViewController_iPad : UIViewController <AVAudioPlayerDelegate,UITextFieldDelegate,AdWhirlDelegate>{
    NSArray *labelTitle;
    AVAudioPlayer *tapPlayer;
    UIView *view;
    NSArray *password;
}
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;

- (void) initItems;
- (void) ifPassWord;
- (void) cleanPasswordView;
- (void) cleanItemsView;
- (void) addAdWhirlAds;
@end
