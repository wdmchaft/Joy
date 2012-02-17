//
//  CFGLog.h
//  Joy
//
//  Created by mac on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif