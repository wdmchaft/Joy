//
//  SliderViewController_iPhone.m
//  Sex
//
//  Created by mac on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SliderViewController_iPhone.h"


@implementation SliderViewController_iPhone
@synthesize pleasureSlider;
@synthesize challengeSlider;
@synthesize content;
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
    for (UIView * v in [self.view subviews]) {
        [v removeFromSuperview];
    }
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPhone]];
    UILabel * pleasureLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 150, 45)];
    pleasureLabel.text = @"趣味性";
    pleasureLabel.textColor = [UIColor whiteColor];
    pleasureLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pleasureLabel];
    [pleasureLabel release];
    
    pleasureSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 100, 280, 20)];
    pleasureSlider.minimumValue = 1;
    pleasureSlider.maximumValue = 5;
    [self.view addSubview:pleasureSlider];
    [pleasureSlider release];
    
    UILabel * challengeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 150, 45)];
    challengeLabel.text = @"挑战性";
    challengeLabel.textColor = [UIColor whiteColor];
    challengeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:challengeLabel];
    [challengeLabel release];
    
    challengeSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 200, 280, 20)];
    challengeSlider.minimumValue = 1;
    challengeSlider.maximumValue = 5;
    [self.view addSubview:challengeSlider];
    [challengeSlider release];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 280, 100, 40)];
    imageView.image = [UIImage imageNamed:@"report_mid.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(110, 280, 100, 40);
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button setTitle:@"查找体位" forState:UIControlStateNormal];
    [self.view addSubview:button];
    /*
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110, 280, 100, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"View Positions";
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
     */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)buttonPressed:(id)buttonSender{
    NSString * sql =[[NSString alloc] initWithFormat:@"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where challenge = %d and pleasure = %d",(int)challengeSlider.value,(int)pleasureSlider.value];
    NSString * sql_part = [[NSString alloc] initWithFormat:@"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where challenge = %d and pleasure = %d and (categoryId = 1 or categoryId = 2 or categoryId = 4)",(int)challengeSlider.value,(int)pleasureSlider.value];
    
    BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
    if(isProUpgradePurchased == NO){
        content = [[[SQLData sharedSQLData] getSelectInfoBySliderWithSqlString:sql_part] retain];
    }else{
        content = [[[SQLData sharedSQLData] getSelectInfoBySliderWithSqlString:sql] retain];
    }
    
    ItemViewController_iPhone * itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
    itemViewController.startFlag = 20;
    itemViewController.content = content;
    itemViewController.title = @"搜索";
    [self.navigationController pushViewController:itemViewController animated:YES];
    [itemViewController release];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
