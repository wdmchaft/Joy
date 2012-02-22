//
//  CoverCateController_iPhone.m
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverCateController_iPhone.h"


@implementation CoverCateController_iPhone
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
    [tbView release];
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
    
    UILabel * topLabel = [Utils addLabelToView:CGRectMake(0, 0, 320, 60) :0 :[UIColor clearColor] :@"Categories" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    tbView              =   [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 380) style:UITableViewStylePlain];
    tbView.dataSource   =   self;
    tbView.delegate     =   self;
    [self.view addSubview:tbView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    CLog(@"%d", self.tabBarController.tabBarItem.tag);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[SQLData sharedSQLData] cateArray] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row % 2 == 0) {
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GreyBar.png"]]];
    }else{
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBar.png"]]];
    }
    
    cell.textLabel.backgroundColor      =   [UIColor clearColor];
    cell.textLabel.font                 =   [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];     
    cell.textLabel.textColor            =   [UIColor blackColor];
    cell.textLabel.textAlignment        =   UITextAlignmentCenter;
    cell.textLabel.text                 =   [[[SQLData sharedSQLData] cateArray] objectAtIndex:indexPath.row];
    NSString * path                     =   [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"];
    UIImage * image                     =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView             =   [Utils addImageViewToView:CGRectMake(280, 10, 35, 35) :image :0 :1.0];
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoverFavController_iPhone * coverFavController  =   [[CoverFavController_iPhone alloc] initWithNibName:@"CoverFavController_iPhone" bundle:nil];
    coverFavController.tabBarFlag                   =   tabBarFlag;
    coverFavController.cateFlag                     =   indexPath.row;
    [self.navigationController pushViewController:coverFavController animated:YES];
    [coverFavController release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
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

@end
