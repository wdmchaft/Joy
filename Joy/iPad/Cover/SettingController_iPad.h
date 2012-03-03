//
//  SettingController_iPad.h
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>
#import "JoyAppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface SettingController_iPad : UIViewController <MFMailComposeViewControllerDelegate>{
    AVAudioPlayer   *   audioPlayer;
}
@property (nonatomic, retain)   AVAudioPlayer   *   audioPlayer;
- (void) initImageViews;
- (void) initLabels;
- (void) initButtons;
- (void) initSlider;
- (void) initSwitch;
- (void) audioPlayerPlay;

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg;
- (void) sendEMail:(NSString *)emailTitle:(NSString *)emailAddress;
- (void) displayComposerSheet:(NSString *)emailTitle;
- (void) launchMailAppOnDevice:(NSString *)emailAddress;
- (void) mailComposeController:(MFMailComposeViewController *)controller   
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error ;
@end
