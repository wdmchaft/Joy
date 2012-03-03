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
    inapp = [[InAppPurchaseManager alloc] init];
    
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 320, 60) :0 :[UIColor clearColor] :@"Categories" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    tbView              =   [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 380) style:UITableViewStylePlain];
    tbView.dataSource   =   self;
    tbView.delegate     =   self;
    [self.view addSubview:tbView];
    [tbView release];
}

- (void)viewWillAppear:(BOOL)animated{
    
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row % 2 == 0) {
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GreyBar.png"]]];
    }else{
        [[cell contentView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBar.png"]]];
    }
    cell.backgroundColor                =   [UIColor clearColor];
    cell.textLabel.backgroundColor      =   [UIColor clearColor];
    cell.textLabel.font                 =   [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];     
    cell.textLabel.textColor            =   [UIColor blackColor];
    cell.textLabel.textAlignment        =   UITextAlignmentCenter;
    cell.textLabel.text                 =   [[[SQLData sharedSQLData] cateArray] objectAtIndex:indexPath.row];
    NSString * path                     =   [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"];
    UIImage * image                     =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView             =   [Utils addCoverImageViewToView:CGRectMake(280, 10, 35, 35) :image :0 :1.0];
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 5) {
        [self manageIndappWithIndex:indexPath.row];
    }else{
        [self changeToItemViewControllerWithIndex:indexPath.row];
    }
}

- (void)manageIndappWithIndex:(NSInteger)indexNum{
    NSLog(@"inapp");
    [inapp requestProUpgradeProductData];
    BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
    if(isProUpgradePurchased == NO){
        BOOL Reachable = NO;
        Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
        NetworkStatus status = [reach currentReachabilityStatus];            
        switch (status) {
            case NotReachable:{
                Reachable = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                                message:@"Network not available. Please check your settings or verify data service with your provider." 
                                                               delegate:self 
                                                      cancelButtonTitle:@"OK" 
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
                break;
            default:
                Reachable = YES;
                break;
        }
        if (Reachable == YES) {
            if([inapp canMakePurchases])
            {
                [inapp loadStore];
                [inapp purchaseProUpgrade];
            }
        }
    }else{
        [self changeToItemViewControllerWithIndex:indexNum];
    }
}

- (void)changeToItemViewControllerWithIndex:(NSInteger)indexNum{
    CoverFavController_iPhone * coverFavController  =   [[CoverFavController_iPhone alloc] initWithNibName:@"CoverFavController_iPhone" bundle:nil];
    coverFavController.tabBarFlag                   =   tabBarFlag;
    coverFavController.cateFlag                     =   indexNum;
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
