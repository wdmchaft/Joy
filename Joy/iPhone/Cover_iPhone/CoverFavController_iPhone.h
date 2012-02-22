//
//  CoverFavController_iPhone.h
//  Joy
//
//  Created by mac on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLData.h"
#import "Utils.h"
#import "CoverRootController_iPhone.h"


@interface CoverFavController_iPhone : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    //which category is choosen
    NSInteger           cateFlag;
    //which point of joke is choosen
    NSInteger           pointFlag;
    //whether this class is a favorite joke container
    NSInteger           favFlag;
    NSArray         *   jokeList;
    UITableView     *   tbView;
    NSInteger           tabBarFlag;
    
}
@property (nonatomic)           NSInteger                   cateFlag;
@property (nonatomic, retain)   NSArray                 *   jokeList;
@property (nonatomic, retain)   UITableView             *   tbView;
@property (nonatomic)           NSInteger           tabBarFlag;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
