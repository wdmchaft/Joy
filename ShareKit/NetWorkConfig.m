//
//  NetWorkConfig.m
//  Joy
//
//  Created by mac on 12-3-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetWorkConfig.h"


@implementation NetWorkConfig
+ (NSString *) getSHKConsumerSignFromUrl:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [ASIHTTPRequest setDefaultTimeOutSeconds:3];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString * response = [request responseString];
        response = [response stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        return response;
    }else{
        NSString * response = @"0";
        return response;
    }
}
@end
