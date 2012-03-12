//
//  ItemShowController_iPad.h
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SQLData.h"
#import "Utils.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"
#import "UserDefaultKeySet.h"
#import "ShareViewController_iPad.h"
#import "GADBannerView.h"

@interface ItemShowController_iPad : UIViewController <AVAudioPlayerDelegate,UIScrollViewDelegate,AdWhirlDelegate,GADBannerViewDelegate>{
    UIScrollView *itemScrollView;
    NSMutableArray *content;
    NSInteger startFlag;
    NSMutableArray *imageArray;
    NSMutableArray *sexImages;
    
    UITextView *textView;
    UIButton *triedButton;
    UIButton *starButton;
    UIButton *todoButton;
    
    NSTimer *timer;
    NSInteger iFlag;
    AVAudioPlayer *tapPlayer;
    BOOL didReceivedIdFlag;
    GADBannerView *bannerView_;
}
@property (nonatomic, retain) UIScrollView *itemScrollView;
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *sexImages;
@property (nonatomic) NSInteger startFlag;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 

- (void) initLittleStartImageViewWithoutImage;
- (void) initScrollView;
- (void) initTextViewAndButton;
- (UIImage *)findImage:(NSInteger)index;
- (void) starShow;
- (void) textViewTextShow;
- (void) startPlayAnimation;
- (void) updateParamarray:(NSString *)sqlString;
- (void) buttonImageShow;
- (void) initSexImages;
- (void) addAdWhirlAds;
@end
