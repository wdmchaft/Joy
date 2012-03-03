//
//  CoverFavController_iPad.m
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverFavController_iPad.h"


@implementation CoverFavController_iPad
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
    UIImageView * topbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 120)];
    topbarView.image = [UIImage imageNamed:@"topbar_ipad.png"];
    [self.view addSubview:topbarView];
    [topbarView release];
    
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 768, 80) :0 :[UIColor clearColor] :@"Favorites" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:30.0]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    tbView              =   [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 768, 870) style:UITableViewStylePlain];
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
        UIButton * button   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(30, 20, 40, 40) :0 :[UIImage imageNamed:@"backButton@2x.png"] :nil];
        [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    if (tabBarFlag == 3) {
        self.navigationController.delegate = self;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{
    
    if (tabBarFlag == 3) {
        jokeList = nil;
        jokeList = [[SQLData sharedSQLData] getCoverFavoriteContentList];
    }
    [tbView reloadData];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (tabBarFlag == 3) {
        jokeList = nil;
        jokeList = [[SQLData sharedSQLData] getCoverFavoriteContentList];
    }
    [tbView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GreyBar_Large@2x.png"]]];
    }else{
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBar_Large@2x.png"]]];
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
    UILabel * label                     =   (UILabel *)[cell viewWithTag:10];
    if (label == nil) {
        UILabel * label                 =   [Utils addCoverLabelToView:CGRectMake(20, 5, 650, 100):10 :[UIColor clearColor] :[[jokeList objectAtIndex:indexPath.row] objectAtIndex:1] :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
        label.numberOfLines             =   3;
        [[cell contentView] addSubview:label];
        [label release];
    }else{
        label.text                      =   [[jokeList objectAtIndex:indexPath.row] objectAtIndex:1];
    }
    
    UILabel * cateLabel                 =   (UILabel *)[cell viewWithTag:11];
    if (cateLabel ==nil) {
        UILabel * cateLabel             =   [Utils addCoverLabelToView:CGRectMake(620, 100, 100, 20):11 :[UIColor clearColor] :[[jokeList objectAtIndex:indexPath.row] objectAtIndex:2] :UITextAlignmentCenter:[UIColor blueColor] :[UIFont fontWithName:@"Courier-BoldOblique" size:13]];
        [[cell contentView] addSubview:cateLabel];
        [cateLabel release];
    }else{
        cateLabel.text                  =   [[jokeList objectAtIndex:indexPath.row] objectAtIndex:2];
        
    }
    
    CLog(@"%@", label.text);
    NSString * path                     =   [[NSBundle mainBundle] pathForResource:@"arrow@2x" ofType:@"png"];
    UIImage * image                     =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView             =   [Utils addCoverImageViewToView:CGRectMake(700, 20, 50, 50) :image :0 :1.0];
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoverRootController_iPad * coverRootController =   [[CoverRootController_iPad alloc] initWithNibName:@"CoverRootController_iPad" bundle:nil];
    coverRootController.jokeList                     =   jokeList;
    coverRootController.tabBarFlag                   =   tabBarFlag;
    [self.navigationController pushViewController:coverRootController animated:YES];        
    [coverRootController release];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0;
}

- (void) backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
