//
//  SQLData.h
//  Joy
//
//  Created by mac on 12-2-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMObjectSingleton.h"
#import "SQLiteOperation.h"

@interface SQLData : NSObject {
@private
    NSArray * cateArray;
}
@property (nonatomic, retain) NSArray * cateArray;


+ (SQLData *)   sharedSQLData;
- (NSArray *)   getCoverAllContentList;
- (NSArray *)   getCoverPartContentList:(NSString *)cateName;
- (NSArray *)   getCoverFavoriteContentList;
- (NSString *)  getCoverCateStringFromArray:(NSInteger )cateIndex;

@end
