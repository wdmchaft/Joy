//
//  CoverRootController_iPhone.h
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SQLData.h"
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>

@interface CoverRootController_iPhone : UIViewController <UIScrollViewDelegate,AVAudioPlayerDelegate,MFMailComposeViewControllerDelegate>{
    //CateFlag is the flag to show which cate should init with.
    NSInteger           cateFlag;
    //tabBarFlag is the flag to choose whether tabBar was choosen
    NSInteger           tabBarFlag;
    NSArray         *   jokeList;
    UIScrollView    *   scrollView;
}
@property (nonatomic)           NSInteger           catesFlag;
@property (nonatomic)           NSInteger           tabBarFlag;
@property (nonatomic, retain)   NSArray         *   jokeList;
@property (nonatomic, retain)   UIScrollView    *   scrollView;

- (void) initScrollView;
- (void) addImageViewToScrllView : (NSInteger)index;
- (void) addTextViewToScrollView : (NSInteger)index;
- (void) addLabelToScrollView : (NSInteger)index;
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
- (void) changeImageViewContent;
- (void) changeTextViewContent;
- (void) changeLabelContent;

@end
