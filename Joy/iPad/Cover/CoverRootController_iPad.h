//
//  CoverRootController_iPad.h
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"
#import "SQLData.h"
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>
#import "MoreJokeController_iPad.h"
#import "SettingController_iPad.h"

@interface CoverRootController_iPad : UIViewController <UIScrollViewDelegate,AVAudioPlayerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>{
    //CateFlag is the flag to show which cate should init with.
    NSInteger           cateFlag;
    //tabBarFlag is the flag to choose whether tabBar was choosen
    NSInteger           tabBarFlag;
    NSArray         *   jokeList;
    UIScrollView    *   scrollView;
    AVAudioPlayer   *   audioPlayer;
    UIButton        *   favButton;
}
@property (nonatomic)           NSInteger           catesFlag;
@property (nonatomic)           NSInteger           tabBarFlag;
@property (nonatomic, retain)   NSArray         *   jokeList;
@property (nonatomic, retain)   UIScrollView    *   scrollView;
@property (nonatomic, retain)   AVAudioPlayer   *   audioPlayer;

- (void) initScrollView;
- (void) addImageViewToScrllView : (NSInteger)index;
- (void) addTextViewToScrollView : (NSInteger)index;
- (void) addLabelToScrollView : (NSInteger)index;
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
- (void) changeImageViewContent;
- (void) changeTextViewContent;
- (void) changeLabelContent;
- (void) audioPlayerPlay;

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg;
- (void) sendEMail;
- (void) displayComposerSheet;
- (void) launchMailAppOnDevice;
- (void) mailComposeController:(MFMailComposeViewController *)controller   
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
@end
