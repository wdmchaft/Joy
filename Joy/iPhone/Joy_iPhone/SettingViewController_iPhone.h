//
//  SettingViewController_iPhone.h
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "PasswordController_iPhone.h"
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>
@interface SettingViewController_iPhone : UIViewController <AVAudioPlayerDelegate,MFMailComposeViewControllerDelegate>{
    
}
-(void)sendEMail;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
@end
