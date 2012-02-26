//
//  ItemViewController_iPad.h
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SQLData.h"
#import "UserDefaultKeySet.h"
#import "ItemShowController_iPad.h"
#import "Utils.h"
#import "iToast.h"
#import "rateus.h"
@interface ItemViewController_iPad : UIViewController <AVAudioPlayerDelegate,UIScrollViewDelegate>{
    UIScrollView *itemScrollView;
    NSMutableArray *content;
    NSInteger startFlag;
    AVAudioPlayer *tapPlayer;
    NSInteger loadNum;
}
@property (nonatomic, retain) UIScrollView *itemScrollView;
@property (nonatomic) NSInteger startFlag;
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;
@property (nonatomic, retain) NSMutableArray * content;
- (void) initItemView;
- (void) initDataSource;
- (void) initBonusModelView;
- (void) cleanAllViews;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
@end
