//
//  CoverCateController_iPad.m
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverCateController_iPad.h"


@implementation CoverCateController_iPad
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
    
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 768, 80) :0 :[UIColor clearColor] :@"Categories" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:30.0]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    tbView              =   [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 768, 870) style:UITableViewStylePlain];
    tbView.dataSource   =   self;
    tbView.delegate     =   self;
    [self.view addSubview:tbView];
    [tbView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GreyBar@2x.png"]]];
    }else{
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBar@2x.png"]]];
    }
    
    cell.textLabel.backgroundColor      =   [UIColor clearColor];
    cell.textLabel.font                 =   [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];     
    cell.textLabel.textColor            =   [UIColor blackColor];
    cell.textLabel.textAlignment        =   UITextAlignmentCenter;
    cell.textLabel.text                 =   [[[SQLData sharedSQLData] cateArray] objectAtIndex:indexPath.row];
    NSString * path                     =   [[NSBundle mainBundle] pathForResource:@"arrow@2x" ofType:@"png"];
    UIImage * image                     =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView             =   [Utils addCoverImageViewToView:CGRectMake(700, 15, 50, 50) :image :0 :1.0];
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoverFavController_iPad * coverFavController  =   [[CoverFavController_iPad alloc] initWithNibName:@"CoverFavController_iPad" bundle:nil];
    coverFavController.tabBarFlag                   =   tabBarFlag;
    coverFavController.cateFlag                     =   indexPath.row;
    [self.navigationController pushViewController:coverFavController animated:YES];
    [coverFavController release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}  

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
