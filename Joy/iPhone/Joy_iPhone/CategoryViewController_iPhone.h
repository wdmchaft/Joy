//
//  CategoryViewController_iPhone.h
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "ItemViewController_iPhone.h"
#import "Utils.h"
#import "SQLData.h"
#import "AdWhirlDelegateProtocol.h"
#import "AdWhirlView.h"
#import "Reachability.h"
#import "InAppPurchaseManager.h"

@interface CategoryViewController_iPhone : UIViewController  <AVAudioPlayerDelegate,AdWhirlDelegate>{
    NSArray *category;
    AVAudioPlayer *tapPlayer;
    InAppPurchaseManager    *   inapp;
}

- (void) initCategoryItem;
- (void) addAdWhirlAds;

@property (nonatomic, retain) AVAudioPlayer *tapPlayer;

- (void) manageIndappWithIndex:(NSInteger)indexNum;
- (void) changeToItemViewControllerWithIndex:(NSInteger)indexNum;

@end
