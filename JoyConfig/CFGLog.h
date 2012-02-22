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

