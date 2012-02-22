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

/*This is the first open sign */
#define FIRST_OPEN_APP @"FirstOpenApplication"

/* Flag judge whether open cover or joy project*/       
#define COVER_FLAG_ZERO @"0"

/* Flag judge whether open cover or joy project*/
#define JOY_FLAG_ONE @"1"


@interface UserDefaultKeySet : NSObject {
    
}

+ (void)saveToUserDefaults:(NSString*)myString forKey:(NSString*)key;
+ (NSString*)retrieveFromUserDefaultsByKey:(NSString*)key;
+ (NSInteger) intervalSinceNow: (NSString *) theDate;
@end
