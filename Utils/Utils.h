//
//  Utils.h
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>
#import "JoyAppDelegate.h"
//COVER_SHOW_INTERVAL define the tag gap of the control target in scrollView 
#define COVER_SHOW_INTERVAL 20000
#define RATE_STRING         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=507355366"
#define SELF_AD_URL         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=507343235"

#define Background_iPhone   @"Item_background.jpg"
#define Background_iPad     @"blackbackground_ipad.jpg"
#define ITEM_BK_PHONE       @"btn_report.png"
#define ButtonCheck         @"check.png"
#define ButtonChecked       @"checked.png"
#define ButtonStar          @"star.png"
#define ButtonStared        @"starred.png"
#define ButtonTodo          @"todo.png"
#define ButtonTodoed        @"todoed.png"
#define LevelStar           @"level_start"
#define TapPlayFileName     @"tap.mp3"
#define ScrollDetails       @"scrolldetail.png"

#define COVER_PAGE_IPHONE   @"iphone_splash.jpg"
#define COVER_PAGE_IPAD     @"ipad_splash.jpg"    

#define DATABASE_US         @"SexDatabase_US.sqlite"
#define DATABASE_CH         @"SexDatabase_CH.sqlite"

#define YOUMENG_MOB_ID      @"4efc1f915270154c39000008"
#define ADWHIRL_ID_IPHONE   @"1b0207f0e1f6403aa670653b39cbc8b1"
#define ADWHIRL_ID_IPAD     @"b80d9bd0340e4bf8a4bdd8691c71931c"



@interface Utils : NSObject <MFMailComposeViewControllerDelegate>{
    
}
//public method to init a Button
+ (UIButton *)      addCoverButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage;
//public method to init a label
+ (UILabel *)       addCoverLabelToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(UITextAlignment)alignment:(UIColor *)textColor:(UIFont *)font;
//public method to init a textView
+ (UITextView *)    addCoverTextViewToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(BOOL)editable:(BOOL)scrollEnable:(BOOL)endEditing:(UIFont *)font:(UIColor *)textColor;
//public method to init a imageView
+ (UIImageView *)   addCoverImageViewToView:(CGRect)frameSize:(UIImage *)image:(NSInteger)tag:(CGFloat)alpha;
//change audioPlayer if needed
+ (AVAudioPlayer *) addCoverAVAudioPlayer:(AVAudioPlayer *)audioPlayer;
//judge whether soundplayer could play a sound
+ (BOOL) ifSoundPlayerCouldPlay;

//public method to init a Button
+ (UIButton *) addButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage;
//public method to init a Label
+ (UILabel *) addLabelToView:(CGRect)frameSize:(NSInteger)tag:(NSString *)title:(CGFloat)size;
//public method to init a ImageView
+ (UIImageView *) addImageViewToView:(CGRect)frameSize:(NSInteger)tag:(UIImage *)image;
//public method to init a ImageViewWithOutImage
+ (UIImageView *) addImageViewToViewWithoutImage:(CGRect)frameSize:(NSInteger)tag;
//public method to init a TextView
+ (UITextView *) addTextViewToView:(CGRect)frameSize:(NSInteger)tag:(CGFloat)size:(UIColor *)BkColor:(UIColor *)textColor;
//another way to add Label
+ (UILabel *) addButtonLabelToView:(CGRect)frameSize:(NSInteger)tag:(NSString *)title:(CGFloat)size:(UIColor *)textColor;
//init a sound player
+ (AVAudioPlayer *) initSoundPlayer:(NSString *)soundFileName:(NSInteger)loopsNum;
//stop a sound player
+ (void)stopSoundPlayer:(AVAudioPlayer *)player;

@end
