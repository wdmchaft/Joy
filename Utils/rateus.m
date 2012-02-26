//
//  rateus.m
//  dressup
//
//  Created by mac on 11-11-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "rateus.h"

@implementation rateus
@synthesize yesClickTimes;
@synthesize rateUsClickTimes;
@synthesize productLoadTimes;

//implement this interface as singleton
#pragma mark Singleton definition
GTMOBJECT_SINGLETON_BOILERPLATE(rateus, sharedRateUs);

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    self = [super init];

    //init click times
    NSString *yesClickTimes_str = [UserDefaultKeySet retrieveFromUserDefaultsByKey:RATEUS_YES_CLICK_TIMES_KEY];
    if (yesClickTimes_str) {
        yesClickTimes = [yesClickTimes_str intValue];
    }else{
        [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_YES_CLICK_TIMES_KEY];
        yesClickTimes = 0;
    }
    
    NSString *rateUsClickTimes_str = [UserDefaultKeySet retrieveFromUserDefaultsByKey:RATEUS_RATE_CLICK_TIMES_KEY];
    if (rateUsClickTimes_str) {
        rateUsClickTimes = [rateUsClickTimes_str intValue];
    }else{
        [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_RATE_CLICK_TIMES_KEY];
        rateUsClickTimes = 0;
    }

     
    NSString *productLoadTimes_str = [UserDefaultKeySet retrieveFromUserDefaultsByKey:RATEUS_PRODUCT_LOAD_TIMES_KEY];
    if (productLoadTimes_str) {
        productLoadTimes = [productLoadTimes_str intValue];
    }else{
        [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_PRODUCT_LOAD_TIMES_KEY];
        productLoadTimes = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)resetRateus
{
    [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_YES_CLICK_TIMES_KEY];
    yesClickTimes    = 0;

    [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_RATE_CLICK_TIMES_KEY];
    rateUsClickTimes = 0;

    [UserDefaultKeySet saveToUserDefaults:@"0" forKey:RATEUS_PRODUCT_LOAD_TIMES_KEY];
    productLoadTimes = 0;
}

- (void)increaseYesClickTimes
{
    if (++yesClickTimes > RATEUS_UNLOCK_ASK_TIMES * 2 ) {
        yesClickTimes = RATEUS_UNLOCK_ASK_TIMES * 2; //avoid over flow
    }
    
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", yesClickTimes] forKey:RATEUS_YES_CLICK_TIMES_KEY];
}

- (void)increaseProductLoadTimes
{
    if (++productLoadTimes > RATEUS_AFTER_TIMES_MAX_COUNT * 2) {
        productLoadTimes = RATEUS_AFTER_TIMES_MAX_COUNT * 2; //avoid over flow
    }
    
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", productLoadTimes] forKey:RATEUS_PRODUCT_LOAD_TIMES_KEY];
}

- (void)callMeWhenRateUsClickHappens
{
    rateUsClickTimes = 1;
    //SexAppDelegate *appDelegate = (SexAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    //appDelegate.haveUserRated = 1;
    //[Utils saveToUserDefaults:@"1" forKey:@"haveUserRated"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:RATE_STRING]];
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", rateUsClickTimes] forKey:RATEUS_RATE_CLICK_TIMES_KEY];    
}

- (BOOL)didUserReallyRatedUs
{
    //here use the `large then` to avoid some unkown events
    if ((yesClickTimes >= RATEUS_UNLOCK_ASK_TIMES) && (rateUsClickTimes >= 1)) {
        return YES;
    }
    
    return NO;
}


- (BOOL)callMeEachTimeTheProductLoad
{
    if (rateUsClickTimes >= 1) {
        return YES;
    }
    
    [self increaseProductLoadTimes];
    
    if (productLoadTimes > RATEUS_AFTER_TIMES_MAX_COUNT) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:RATEUS_AFTER_TIMES_TITLE
                                                        message:[NSString stringWithFormat:RATEUS_AFTER_TIMES_MSG, productLoadTimes]
                                                       delegate:self
                                              cancelButtonTitle:@"Rate Later"          //BUTTON INDEX 0
                                              otherButtonTitles:@"RATE NOW!", nil];    //BUTTON INDEX 1
        alert.tag = RATEUS_AFTER_TIMES_MSG_TAG;                                         //ALERT RATEUS_AFTER_TIMES_MSG
        [alert show];
        [alert release];
    }
    
    return NO;
}

- (BOOL)callMeEachTimeTheProductUnlockClickHappens
{
    if ([self didUserReallyRatedUs]) {
        return YES;
    }
    
    //never clicked rateus that wanna unlock products
    if(rateUsClickTimes == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:RATEUS_UNLOCK_ALERT_TITLE
                                                        message:RATEUS_UNLOCK_RATE_MSG_RATE1ST
                                                       delegate:self
                                              cancelButtonTitle:@"Rate Later"          //BUTTON INDEX 0
                                              otherButtonTitles:@"RATE NOW!", nil];    //BUTTON INDEX 1
        alert.tag = RATEUS_UNLOCK_RATE_MSG_RATE1ST_TAG;                                //ALERT RATEUS_UNLOCK_RATE_MSG_RATE1ST
        [alert show];
        [alert release];
        return NO;
    }
    
    //cliked once rate us then click the unlock butons
    if ((rateUsClickTimes == 1)&&(yesClickTimes == 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:RATEUS_UNLOCK_ALERT_TITLE
                                                        message:RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB
                                                       delegate:self
                                              cancelButtonTitle:@"Yes, I have"     //BUTTON INDEX 0
                                              otherButtonTitles:@"No, rate now",nil]; //BUTTON INDEX 1
        alert.tag = RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB_TAG;                           //ALERT RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB
        [alert show];
        [alert release];
        return NO;
    }
    
    //for all the other circumstances
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:RATEUS_UNLOCK_ALERT_TITLE
                                                    message:RATEUS_UNLOCK_RATE_MSG_FINAL_ASK
                                                   delegate:self
                                          cancelButtonTitle:@"Yes,I have"           //BUTTON INDEX 0
                                          otherButtonTitles:@"No,I haven't",nil];   //BUTTON INDEX 1
    alert.tag = RATEUS_UNLOCK_RATE_MSG_FINAL_ASK_TAG;                               //ALERT RATEUS_UNLOCK_RATE_MSG_FINAL_ASK
    [alert show];
    [alert release];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == RATEUS_AFTER_TIMES_MSG_TAG) {//RATEUS_AFTER_TIMES_MSG
        if (buttonIndex == 1) {//rate now button 
            NSLog(@"rate us++");
            [self callMeWhenRateUsClickHappens];
        }if (buttonIndex == 0) {
            NSLog(@"NO");
        }
    }
    
    if (alertView.tag == RATEUS_UNLOCK_RATE_MSG_RATE1ST_TAG) {
        if (buttonIndex == 1) {//rate us now!!!
            NSLog(@"rate us++");
            [self callMeWhenRateUsClickHappens];
        }if (buttonIndex == 0) {
            NSLog(@"NO");
        }
    }
    
    if (alertView.tag == RATEUS_UNLOCK_RATE_MSG_NOT_IN_DB_TAG) {
        if (buttonIndex == 1) { //rate us now!!!
            NSLog(@"rate us++");
            [self callMeWhenRateUsClickHappens];
        }else if(buttonIndex == 0){ //yes i have
            NSLog(@"yes++");
            [self increaseYesClickTimes];
        }
    }
    
    if (alertView.tag == RATEUS_UNLOCK_RATE_MSG_FINAL_ASK_TAG) {
        if (buttonIndex == 0) { //yes button
            NSLog(@"yes++");
            [self increaseYesClickTimes];
            if ([self didUserReallyRatedUs]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:RATEUS_UNLOCK_COULD_UNLOCK_THIS_PRODUCT_NOW_NOTIFICATION object:nil];
            }
        }        
    }
    

}

- (void) setrateUsClickTimes:(NSInteger)clickTimes{
    rateUsClickTimes = clickTimes;
}

@end
