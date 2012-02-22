//
//  CoverCateController_iPhone.h
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SQLData.h"
#import "CoverFavController_iPhone.h"


@interface CoverCateController_iPhone : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    UITableView     *   tbView;
    NSInteger           tabBarFlag;
}
@property (nonatomic, retain) UITableView       *   tbView;
@property (nonatomic)           NSInteger           tabBarFlag;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
