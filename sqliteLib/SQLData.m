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
    return [[[SQLiteOperation sharedSQLOpt] selectData:@"select indexNum, jokeContent, categoryName, favouriteFlag from joke where favouriteFlag = 0" resultColumns:4] retain];
}

- (NSString *)  getCoverCateStringFromArray:(NSInteger )cateIndex{
    NSLog(@"%d",cateIndex);
    NSLog(@"%@",[cateArray objectAtIndex:cateIndex]);
    return [cateArray objectAtIndex:cateIndex];
}

- (void)dealloc
{
    [cateArray release];
    [super dealloc];
}
@end
