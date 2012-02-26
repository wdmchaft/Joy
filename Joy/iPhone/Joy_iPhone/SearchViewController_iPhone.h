//
//  SearchViewController_iPhone.h
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteOperation.h"
#import "ItemShowController_iPhone.h"
#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
@class SQLiteOperation;
@interface SearchViewController_iPhone : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource> {
    SQLiteOperation *sqliteOperation;
    UITableView *tbView;
    NSMutableArray *content;
    NSMutableArray	*filteredListContent;
    UITableViewCell *nibLoadedCell;
}
@property (nonatomic, retain) IBOutlet UITableView *tbView;
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;
@end
