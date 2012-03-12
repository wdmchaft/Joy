//
//  Utils.m
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils
+ (UIButton *) addCoverButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = frameSize;
    button.tag       = tag;
    [button setBackgroundImage:upImage forState:UIControlStateNormal];
    [button setBackgroundImage:downImage forState:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)  addCoverLabelToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(UITextAlignment)alignment:(UIColor *)textColor:(UIFont *)font{
    UILabel * label         =   [[UILabel alloc] initWithFrame:frameSize];
    label.backgroundColor   =   bgcolor;
    label.text              =   text;
    label.tag               =   tag;
    label.textAlignment     =   alignment;
    label.textColor         =   textColor;
    label.font              =   font;
    return label;
}

+ (UITextView *)    addCoverTextViewToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(BOOL)editable:(BOOL)scrollEnable:(BOOL)endEditing:(UIFont *)font:(UIColor *)textColor{
    UITextView * textView       =   [[UITextView alloc] initWithFrame:frameSize];
    textView.text               =   text;
    textView.editable           =   editable;
    textView.scrollEnabled      =   scrollEnable;
    textView.tag                =   tag;
    textView.font               =   font;
    textView.backgroundColor    =   bgcolor;
    textView.textColor          =   textColor;
    [textView endEditing:endEditing];
    return textView;
}

+ (UIImageView *)   addCoverImageViewToView:(CGRect)frameSize:(UIImage *)image:(NSInteger)tag:(CGFloat)alpha{
    UIImageView * imageView     =   [[UIImageView alloc] initWithFrame:frameSize];
    imageView.image             =   image;
    imageView.tag               =   tag;
    imageView.alpha             =   alpha;
    return imageView;
}

+ (AVAudioPlayer *) addCoverAVAudioPlayer:(AVAudioPlayer *)audioPlayer{
    if (audioPlayer) {
        [audioPlayer stop];
        [audioPlayer release];
        audioPlayer = nil;
    }
    NSString *musicFilePath =   [[NSBundle mainBundle] pathForResource:@"digitalbeep" ofType:@"wav"];   
	NSURL *musicURL         =   [[NSURL alloc] initFileURLWithPath:musicFilePath]; 	
	audioPlayer             =   [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];	
	audioPlayer.volume      =   1.0f;
	[musicURL release];
	[audioPlayer prepareToPlay];
	return audioPlayer;
}

+ (BOOL)ifSoundPlayerCouldPlay{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.COVER_SOUND_FLAG;
}

/*
 *last api is copy from old version
 *most used in joy part
 */
+ (UIButton *) addButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = frameSize;
    button.tag       = tag;
    [button setBackgroundImage:upImage forState:UIControlStateNormal];
    [button setBackgroundImage:downImage forState:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *) addLabelToView:(CGRect)frameSize:(NSInteger)tag:(NSString *)title:(CGFloat)size{
    UILabel *label  = [[UILabel alloc] initWithFrame:frameSize];
    label.tag       = tag;
    label.font      = [UIFont systemFontOfSize:size];
    label.textColor = [UIColor whiteColor];
    label.text      = title;
    label.textAlignment = UITextAlignmentCenter;
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (UIImageView *) addImageViewToView:(CGRect)frameSize:(NSInteger)tag:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frameSize];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;  
    imageView.tag          = tag;
    imageView.image        = image;
    return imageView;
}
+ (UIImageView *) addImageViewToViewWithoutImage:(CGRect)frameSize:(NSInteger)tag{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frameSize];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;  
    imageView.tag          = tag;
    return imageView;
}

+ (UITextView *) addTextViewToView:(CGRect)frameSize:(NSInteger)tag:(CGFloat)size:(UIColor *)BkColor:(UIColor *)textColor{
    UITextView *textView        = [[UITextView alloc] initWithFrame:frameSize];
    textView.tag                = tag;
    textView.font               = [UIFont systemFontOfSize:size];
    textView.backgroundColor    = BkColor;
    textView.textColor          = textColor;
    [textView setEditable:NO];
    [textView endEditing:YES];
    textView.scrollEnabled=YES;
    return textView;
}

+ (UILabel *) addButtonLabelToView:(CGRect)frameSize:(NSInteger)tag:(NSString *)title:(CGFloat)size:(UIColor *)textColor{
    UILabel *label  = [[UILabel alloc] initWithFrame:frameSize];
    label.tag       = tag;
    label.font      = [UIFont systemFontOfSize:size];
    label.textColor = textColor;
    label.text      = title;
    label.textAlignment = UITextAlignmentCenter;
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (AVAudioPlayer *) initSoundPlayer:(NSString *)soundFileName:(NSInteger)loopsNum{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:soundFileName ofType:nil];
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];              
    AVAudioPlayer *Player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];          
    [musicURL release];
    Player.numberOfLoops = loopsNum;
    [Player prepareToPlay];
    Player.volume=1.0f;
    return  Player;
}

+ (void)stopSoundPlayer:(AVAudioPlayer *)player{
    if (player) {
        [player stop];
        [player release];
        player = nil;
    }
}


@end
