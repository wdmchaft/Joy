//
//  CategoryViewController_iPad.h
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SQLiteOperation.h"
#import "Utils.h"
#import "SQLData.h"
#import "ItemViewController_iPad.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"

@interface CategoryViewController_iPad : UIViewController <AVAudioPlayerDelegate,AdWhirlDelegate>{
    NSArray *category;
    AVAudioPlayer *tapPlayer;
}
- (void) initCategoryItem;
- (void) addAdWhirlAds;
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;
@end
