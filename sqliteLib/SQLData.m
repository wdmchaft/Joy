//
//  SQLData.m
//  Joy
//
//  Created by mac on 12-2-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SQLData.h"


@implementation SQLData
@synthesize cateArray;

//implement this interface as singleton
#pragma mark Singleton definition
GTMOBJECT_SINGLETON_BOILERPLATE(SQLData, sharedSQLData)

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    self = [super init];
    cateArray = [[NSArray alloc] initWithObjects:@"Animals",@"Appearance",@"Bar",@"Blonde",@"Dirty",@"Entertainment",@"Ethnic",@"Family",@"Food",@"Gender",@"Holidays",@"Jobs", @"Knock Knock", @"Literature",@"Money", @"Monster",@"Politics",@"Random",@"Religion",@"School",@"Sport",@"Tasteless",@"Technology",@"Transportation",@"Yo mama",nil];
    CLog(@"the cateArray count is %d", [cateArray count]);
    return self;
}

- (NSArray *) getCoverAllContentList{
    return  [[[SQLiteOperation sharedSQLOpt] selectData:@"select indexNum, jokeContent, categoryName, favouriteFlag from joke" resultColumns:4] retain];
}

- (NSArray *) getCoverPartContentList:(NSString *)cateName{
    return [[[SQLiteOperation sharedSQLOpt] selectData:[NSString stringWithFormat: @"select indexNum, jokeContent, categoryName, favouriteFlag from joke where categoryName = '%@'", cateName] resultColumns:4] retain];
}

- (NSArray *) getCoverFavoriteContentList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:@"select indexNum, jokeContent, categoryName, favouriteFlag from joke where favouriteFlag = 1" resultColumns:4] retain];
}

- (NSString *)  getCoverCateStringFromArray:(NSInteger )cateIndex{
    return [cateArray objectAtIndex:cateIndex];
}

//This method have a problem about release nsarray, which will be fixed in the next version
- (BOOL) setCoverFavoriteFlag:(NSString *)index:(NSString *)flagNum{  
    NSArray *paramarray = [[NSArray alloc] initWithObjects:flagNum,index, nil];
    return [[SQLiteOperation sharedSQLOpt] dealData:@"UPDATE joke SET favouriteFlag=? WHERE indexNum=?" paramArray:paramarray];
}
//get password if the joy part could use
- (NSArray *)   getJoyPasswordFlagList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:@"select note,keywords from pose where id = 1" resultColumns:2] retain];
}

- (NSArray *)   getCategoryFlagList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:@"select id,name,picNmae,link from pose_category" resultColumns:4] retain];
}
- (NSMutableArray *)   getSelectTopTenInfoList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:SelectTopInfo resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectPoseInfoList:(NSString *)cateIndex{
    return [[[SQLiteOperation sharedSQLOpt] selectData:[NSString stringWithFormat: @"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where categoryId = '%@'", cateIndex] resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectFavoriteInfoList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:SelectFavourite resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectDoneInfoList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:SelectDone resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectUnDoneInfoList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:SelectUnDone resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectTodoInfoList{
    return [[[SQLiteOperation sharedSQLOpt] selectData:SelectTodo resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectAllInfoList{
    return  [[[SQLiteOperation sharedSQLOpt] selectData:SelectAll resultColumns:10] retain];
}
- (NSMutableArray *)   getSelectImageInfoList{
    return  [[[SQLiteOperation sharedSQLOpt] selectData:@"select id,poseId,picName from sexImage order by poseId asc" resultColumns:3] retain];
}
- (BOOL) updateParamarrayWithSqlString:(NSString *)sqlString withIndex:(NSString *)indexNum{
    NSArray *paramarray = [[NSArray alloc] initWithObjects:indexNum, nil];
    return [[SQLiteOperation sharedSQLOpt] dealData:@"UPDATE joke SET favouriteFlag=? WHERE indexNum=?" paramArray:paramarray];
}
- (NSMutableArray *)   getSelectInfoBySliderWithSqlString:(NSString *)sqlString{
    return [[[SQLiteOperation sharedSQLOpt] selectData:sqlString resultColumns:10] retain];
}

- (BOOL)        updatePasswordFlag{
    return [[SQLiteOperation sharedSQLOpt] dealData:UpdatePasswordFlag paramArray:nil];
}
- (BOOL)        updatePasswordWithString:(NSString *)password{
    NSArray *paramarray = [[NSArray alloc] initWithObjects:password, nil];
    return [[SQLiteOperation sharedSQLOpt] dealData:UpdatePassword paramArray:paramarray];
}

- (void)dealloc
{
    [cateArray release];
    [super dealloc];
}
@end
