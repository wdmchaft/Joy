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

#define SelectTopInfo   @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where manMark = 1"
#define SelectPoseInfo  @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where categoryId = "
#define SelectFavourite @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where isMarkFavorite = 1"
#define SelectDone      @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where isMarkDone = 1"
#define SelectUnDone    @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where isMarkDone = 0"
#define SelectTodo      @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where isMarkCheck = 1"
#define SelectAll       @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose"
#define SelectUnDoneInfoListWithoutPurchase          @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where isMarkDone = 0 and (categoryId = 1 or categoryId = 2 or categoryId = 4)"
#define SelectAllWithoutPurchase    @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where categoryId = 1 or categoryId = 2 or categoryId = 4"

#define UpdateFavZero   @"UPDATE pose SET isMarkFavorite=0 WHERE id=?"
#define UpdateFavOne    @"UPDATE pose SET isMarkFavorite=1 WHERE id=?"
#define UpdateDoneZero  @"UPDATE pose SET isMarkDone=0 WHERE id=?"
#define UpdateDoneOne   @"UPDATE pose SET isMarkDone=1 WHERE id=?"
#define UpdateTodoZero  @"UPDATE pose SET isMarkCheck=0 WHERE id=?"
#define UpdateTodoOne   @"UPDATE pose SET isMarkCheck=1 WHERE id=?"

#define UpdatePasswordFlag  @"update pose set note = 1 where id = 1"
#define UpdatePassword      @"update pose set keywords = ? where id = 1"
#define SelectPassword      @"select note,keywords from pose where id = 1"

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
- (BOOL)        setCoverFavoriteFlag:(NSString *)index:(NSString *)flagNum;

- (NSArray *)   getJoyPasswordFlagList;
- (NSArray *)   getCategoryFlagList;
- (NSMutableArray *)   getSelectTopTenInfoList;
- (NSMutableArray *)   getSelectPoseInfoList:(NSString *)cateIndex;
- (NSMutableArray *)   getSelectFavoriteInfoList;
- (NSMutableArray *)   getSelectDoneInfoList;
- (NSMutableArray *)   getSelectUnDoneInfoList;
- (NSMutableArray *)   getSelectTodoInfoList;
- (NSMutableArray *)   getSelectAllInfoList; 
- (NSMutableArray *)   getSelectImageInfoList;
- (NSMutableArray *)   getSelectInfoBySliderWithSqlString:(NSString *)sqlString; 
- (NSMutableArray *)   getSelectUnDoneInfoListWithoutPurchase;
- (NSMutableArray *)   getSelectAllInfoListWithoutPurchase; 

- (BOOL)        updateParamarrayWithSqlString:(NSString *)sqlString withIndex:(NSString *)indexNum;
- (BOOL)        updatePasswordFlag;
- (BOOL)        updatePasswordWithString:(NSString *)password;
@end
