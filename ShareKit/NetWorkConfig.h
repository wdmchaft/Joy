//
//  NetWorkConfig.h
//  Joy
//
//  Created by mac on 12-3-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "Reachability.h"

#define SHKSinaWeiboConsumerKeyUrl      @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKSinaWeiboConsumerKey.html"
#define SHKSinaWeiboConsumerSecretUrl   @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKSinaWeiboConsumerSecret.html"
#define SHKDoubanConsumerKeyUrl         @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKDoubanConsumerKey.html"
#define SHKDoubanConsumerSecretUrl      @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKDoubanConsumerSecret.html"
#define SHKRenRenAppIdUrl               @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKRenRenAppId.html"
#define SHKRenRenConsumerKeyUrl         @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKRenRenConsumerKey.html"
#define SHKRenRenConsumerSecretUrl      @"http://www.zichaoli.com/tl1XvKRq4TcauQc1Ppr1kFdIwpNtPGAG/JoyOfSex/SHKRenRenConsumerSecret.html"

@interface NetWorkConfig : NSObject {
    
}
+ (NSString *) getSHKConsumerSignFromUrl:(NSString *)urlString;

@end
