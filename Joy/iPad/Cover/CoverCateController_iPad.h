//
//  CoverCateController_iPad.h
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SQLData.h"
#import "CoverFavController_iPad.h"
#import "Reachability.h"
#import "InAppPurchaseManager.h"

@interface CoverCateController_iPad : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    //tabBarFlag is the flag to choose whether tabBar was choosen
    UITableView     *   tbView;
    NSInteger           tabBarFlag;
    InAppPurchaseManager    *   inapp;
}
@property (nonatomic, retain) UITableView       *   tbView;
@property (nonatomic)           NSInteger           tabBarFlag;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)manageIndappWithIndex:(NSInteger)indexNum;
- (void)changeToItemViewControllerWithIndex:(NSInteger)indexNum;
@end
