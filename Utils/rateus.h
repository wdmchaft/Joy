//
//  rateus.h
//  dressup
//
//  Created by mac on 11-11-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMObjectSingleton.h"
#import "Utils.h"
#import "JoyAppDelegate.h"
#import "UserDefaultKeySet.h"

#warning remove this warning if you have already defined rateus url
#ifndef APP_ID
#define APP_ID @"490087011"
#endif

#define RATEUS_UNLOCK_COULD_UNLOCK_THIS_PRODUCT_NOW_NOTIFICATION @"rateus_unlock_could_unlock_this_product_now"

#define RATEUS_UNLOCK_ALERT_TITLE            @"Have you RATED?"
#define RATEUS_UNLOCK_RATE_MSG_RATE1ST       @"Please rate us first!"
#define RATEUS_UNLOCK_RATE_MSG_RATE1ST_TAG   0
#define RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB     @"Sorry, we can't find your rating in our database temporarily. If you have just rated, pleae try \"UNLOCK\" secs later. Otherwise, please rate us fisrt. thanks!"
#define RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB_TAG 1
#define RATEUS_UNLOCK_RATE_MSG_FINAL_ASK     @"Have you rated this app?"
#define RATEUS_UNLOCK_RATE_MSG_FINAL_ASK_TAG 2
#define RATEUS_AFTER_TIMES_TITLE             @"Please RATE us"
#define RATEUS_AFTER_TIMES_MSG               @"You have launched this game %d times. Please rate us at app store. Thank you for your support!"
#define RATEUS_AFTER_TIMES_MSG_TAG          -1

#define RATEUS_UNLOCK_ASK_TIMES              2
#define RATEUS_AFTER_TIMES_MAX_COUNT         10


#define  RATEUS_YES_CLICK_TIMES_KEY        @"rateus_yesclicktimes"
#define RATEUS_RATE_CLICK_TIMES_KEY        @"rateus_rateclicktimes"
#define RATEUS_PRODUCT_LOAD_TIMES_KEY      @"rateus_productloadtimes"

@interface rateus : NSObject {
    NSInteger rateUsClickTimes;
    NSInteger yesClickTimes;
    NSInteger productLoadTimes;
}

@property (nonatomic) NSInteger rateUsClickTimes;
@property (nonatomic) NSInteger yesClickTimes;
@property (nonatomic) NSInteger productLoadTimes;

+ (rateus *) sharedRateUs;


- (BOOL) callMeEachTimeTheProductUnlockClickHappens; //test if the user had really rated us, if so return YES. if not return NO and show alert windows.
- (void) callMeWhenRateUsClickHappens; //set the rate us clicked flag to indicate that the rated us has been clicked
- (BOOL) callMeEachTimeTheProductLoad; //count the loading times of the product, if large then RATEUS_AFTER_TIMES_MAX_COUNT, it would show alert window asking for rating until the user clicked the `rateus` button
- (BOOL) didUserReallyRatedUs; //indicate whether the user has rated us

- (void) resetRateus;//reset the flags in the rates us to default

- (void) setrateUsClickTimes:(NSInteger)clickTimes;

@end
