//
//  ItemViewController_iPhone.h
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SQLiteOperation.h"
#import "ItemShowController_iPhone.h"
#import "Utils.h"
#import "UserDefaultKeySet.h"
#import "iToast.h"
#import "rateus.h"
#import "SQLData.h"

@interface ItemViewController_iPhone : UIViewController <AVAudioPlayerDelegate,UIScrollViewDelegate>{
    UIScrollView *itemScrollView;
    NSMutableArray *content;
    NSInteger startFlag;
    AVAudioPlayer *tapPlayer;
    NSInteger loadNum;
}
@property (nonatomic, retain) UIScrollView *itemScrollView;
@property (nonatomic) NSInteger startFlag;
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;
@property (nonatomic, retain) NSMutableArray *content;
- (void) initItemView;
- (void) initDataSource;
- (void) initBonusModelView;
- (void) cleanAllViews;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end
