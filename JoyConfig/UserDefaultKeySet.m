//
//  UserDefaultKeySet.m
//  Joy
//
//  Created by mac on 12-2-16.
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

@end
