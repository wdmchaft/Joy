//
//  CFGLog.h
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
/*
 Macro used to delete NSLog when app release
 See the preprocessing macro
 */
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

/*
 *Rember this config should check before uploading
 *
 1.COVER_OPEN_TIME:         in Utils.h
 2.COVER_OPEN_SERVER_FLAG:  REQUEST_URL in UserDefaultKey.h
 3.SELF_AD_URL:             REQUEST_AD_URL in UserDefaultKey.h
 4.RATE_US_URL:             RATE_STRING in Utils.h
 5.ADMOB_ID_IPHONE_URL:     in UserDefaultKey.h
 6.ADMOB_ID_IPAD_URL:       in UserDefaultKey.h
 7.INAPP_PRODUCT_ID:        in InAppPurchaseManager.h
 8.SINA_KEY:                in NetWorkConfig.h
 9.SINA_SECRET:             in NetWorkConfig.h
 10.DOUBAN_KEY:             in NetWorkConfig.h
 11.DOUBAN_SECRET:          in NetWorkConfig.h
 12.RENREN_KEY:             in NetWorkConfig.h
 13.RENREN_SECRET:          in NetWorkConfig.h
 14.YOUMENG_MOB_ID          in Utils.h
 *
 *
 */