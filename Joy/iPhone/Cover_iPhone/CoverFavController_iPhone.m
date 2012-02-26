//
//  CoverFavController_iPhone.m
//  Joy
//
//  Created by mac on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverFavController_iPhone.h"


@implementation CoverFavController_iPhone
@synthesize cateFlag;
@synthesize jokeList;
@synthesize tbView;
@synthesize tabBarFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [jokeList release];
    [tbView removeFromSuperview];
    NSLog(@"favcontroller dealloc");
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView * topbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    topbarView.image = [UIImage imageNamed:@"topbar.png"];
    [self.view addSubview:topbarView];
    [topbarView release];
    
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 320, 60) :0 :[UIColor clearColor] :@"Favorites" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    tbView              =   [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 380) style:UITableViewStylePlain];
    tbView.dataSource   =   self;
    tbView.delegate     =   self;
    [self.view addSubview:tbView];
    [tbView release];
    
    switch (tabBarFlag) {
        case 1:   
            jokeList = [[SQLData sharedSQLData] getCoverAllContentList];
            break;
        case 2:
            jokeList = [[SQLData sharedSQLData] getCoverPartContentList:[[SQLData sharedSQLData] getCoverCateStringFromArray:cateFlag]];
            topLabel.text = [[SQLData sharedSQLData] getCoverCateStringFromArray:cateFlag];            
            break;
        case 3:
            jokeList = [[SQLData sharedSQLData] getCoverFavoriteContentList];
            break;
        default:
            break;
    }
    
    if (tabBarFlag == 2) {
        UIButton * button   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 15, 25, 25) :0 :[UIImage imageNamed:@"backButton@2x.png"] :nil];
        [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jokeList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row % 2 == 0) {
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GreyBar_Large.png"]]];
    }else{
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBar_Large.png"]]];
    }
    /*
    cell.textLabel.backgroundColor      =   [UIColor clearColor];
    cell.textLabel.frame                =   CGRectMake(0, 0, 200, 70);
    cell.textLabel.font                 =   [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];     
    cell.textLabel.textColor            =   [UIColor blackColor];
    cell.textLabel.textAlignment        =   UITextAlignmentLeft;
    cell.textLabel.text                 =   [[jokeList objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.textLabel.numberOfLines        =   3;
    */ 
    CLog(@"check if this done");
    UILabel * label                     =   (UILabel *)[cell viewWithTag:10];
    if (label == nil) {
        UILabel * label                 =   [Utils addCoverLabelToView:CGRectMake(10, 0, 280, 70):10 :[UIColor clearColor] :[[jokeList objectAtIndex:indexPath.row] objectAtIndex:1] :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"TrebuchetMS-Bold" size:14]];
        label.numberOfLines             =   3;
        [[cell contentView] addSubview:label];
        [label release];
    }else{
        label.text                      =   [[jokeList objectAtIndex:indexPath.row] objectAtIndex:1];
    }
    
    UILabel * cateLabel                 =   (UILabel *)[cell viewWithTag:11];
    if (cateLabel ==nil) {
        UILabel * cateLabel             =   [Utils addCoverLabelToView:CGRectMake(200, 65, 100, 15):11 :[UIColor clearColor] :[[jokeList objectAtIndex:indexPath.row] objectAtIndex:2] :UITextAlignmentCenter:[UIColor blueColor] :[UIFont fontWithName:@"Courier-BoldOblique" size:11]];
        [[cell contentView] addSubview:cateLabel];
        [cateLabel release];
    }else{
        cateLabel.text                  =   [[jokeList objectAtIndex:indexPath.row] objectAtIndex:2];
        
    }
    
    CLog(@"%@", label.text);
    NSString * path                     =   [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"];
    UIImage * image                     =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView             =   [Utils addCoverImageViewToView:CGRectMake(280, 20, 35, 35) :image :0 :1.0];
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoverRootController_iPhone * coverRootController_iPhone =   [[CoverRootController_iPhone alloc] initWithNibName:@"CoverRootController_iPhone" bundle:nil];
    coverRootController_iPhone.jokeList                     =   jokeList;
    coverRootController_iPhone.tabBarFlag                   =   tabBarFlag;
    [self.navigationController pushViewController:coverRootController_iPhone animated:YES];        
    [coverRootController_iPhone release];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void) backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
