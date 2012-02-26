//
//  CategoryViewController_iPhone.h
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SQLiteOperation.h"
#import "ItemViewController_iPhone.h"
#import "Utils.h"
#import "SQLData.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"
@class SQLiteOperation;
@interface CategoryViewController_iPhone : UIViewController  <AVAudioPlayerDelegate,AdWhirlDelegate>{
    SQLiteOperation *sqliteOperation;
    NSArray *category;
    AVAudioPlayer *tapPlayer;
}
- (void) initCategoryItem;
- (void) addAdWhirlAds;
@property (nonatomic, retain) AVAudioPlayer *tapPlayer;
@end
