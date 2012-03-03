//
//  UserDefaultKeySet.h
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
/*
 This file is some define of NSUserDefaults Keys and Methods
 */

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

/*This is the first open sign */
#define FIRST_OPEN_APP      @"FirstOpenApplication"

/* Flag judge whether open cover or joy project*/       
#define COVER_FLAG_ZERO     @"0"

/* Flag judge whether open cover or joy project*/
#define JOY_FLAG_ONE        @"1"

#define REQUEST_URL         @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/507355366.html"

#define REQUEST_AD_URL      @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/"


@interface UserDefaultKeySet : NSObject {
    
}

+ (void)        saveToUserDefaults:(NSString*)myString forKey:(NSString*)key;
+ (NSString*)   retrieveFromUserDefaultsByKey:(NSString*)key;
+ (NSInteger)   intervalSinceNow: (NSString *) theDate;
+ (NSString *)  getSignFromServer;
+ (NSString *)  getAdSignFromServer;
@end
