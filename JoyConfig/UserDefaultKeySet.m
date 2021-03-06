//
//  UserDefaultKeySet.m
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDefaultKeySet.h"


@implementation UserDefaultKeySet

+ (void)saveToUserDefaults:(NSString*)myString forKey:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    { [standardUserDefaults setObject:myString forKey:key];
        [standardUserDefaults synchronize];
    }
}


+ (NSString*)retrieveFromUserDefaultsByKey:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults]; 
    NSString *val = nil;
    if (standardUserDefaults)
        val = [standardUserDefaults objectForKey:key];
    return val;
}

+ (NSInteger) intervalSinceNow: (NSString *) theDate 
{    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late - now;
    NSInteger flag = 0;
    if (cha/86400<1) {
        flag = 1;
    }
    [date release];
    return flag;
}

+ (NSString *) getSignFromServer{
    NSURL *url = [NSURL URLWithString:REQUEST_URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [ASIHTTPRequest setDefaultTimeOutSeconds:3];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString * response = [request responseString];
        return response;
    }else{
        NSString * response = @"0";
        return response;
    }    
}

+ (NSString *)  getAdSignFromServer{
    NSURL *url = [NSURL URLWithString:REQUEST_AD_URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [ASIHTTPRequest setDefaultTimeOutSeconds:3];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString * response = [request responseString];
        response = [response stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        return response;
    }else{
        NSString * response = @"491265501";
        return response;
    }  
}

+ (BOOL)judgeNetworkReachability{
    BOOL Reachable = NO;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];            
    switch (status) {
        case NotReachable:{
            Reachable = NO;
            break;
        }            
        default:
            Reachable = YES;
            break;
    }
    return Reachable;
}
/*
 *main id is @"a14f50530315281" and @"a14f5053a7755c0"
 *imergency id is @"a14f58684fe002c" and @"a14f5868a49d7f5"
 *
 */
+ (NSString *) getAdMobIdiPhoneFromServer{
    NSURL *url = [NSURL URLWithString:ADMOB_ID_IPHONE_URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [ASIHTTPRequest setDefaultTimeOutSeconds:3];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString * response = [request responseString];
        response = [response stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        return response;
    }else{
        NSString * response = @"a14f58684fe002c";
        return response;
    }
}
+ (NSString *) getAdMobIdiPadFromServer{
    NSURL *url = [NSURL URLWithString:ADMOB_ID_IPAD_URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [ASIHTTPRequest setDefaultTimeOutSeconds:3];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString * response = [request responseString];
        response = [response stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        return response;
    }else{
        NSString * response = @"a14f5868a49d7f5";
        return response;
    }
}

@end
