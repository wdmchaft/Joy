//
//  SliderViewController_iPad.m
//  Sex
//
//  Created by mac on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SliderViewController_iPad.h"


@implementation SliderViewController_iPad
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPad]];
    UILabel * pleasureLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 300, 65)];
    pleasureLabel.font = [UIFont systemFontOfSize:28.0];
    pleasureLabel.text = @"Pleasure";
    pleasureLabel.textColor = [UIColor whiteColor];
    pleasureLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pleasureLabel];
    [pleasureLabel release];
    
    pleasureSlider = [[UISlider alloc] initWithFrame:CGRectMake(150, 220, 480, 30)];
    pleasureSlider.minimumValue = 1;
    pleasureSlider.maximumValue = 5;
    [self.view addSubview:pleasureSlider];
    [pleasureSlider release];
    
    UILabel * challengeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 300, 300, 65)];
    challengeLabel.text = @"Challenge";
    challengeLabel.font = [UIFont systemFontOfSize:28.0];;
    challengeLabel.textColor = [UIColor whiteColor];
    challengeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:challengeLabel];
    [challengeLabel release];
    
    challengeSlider = [[UISlider alloc] initWithFrame:CGRectMake(150, 370, 480, 20)];
    challengeSlider.minimumValue = 1;
    challengeSlider.maximumValue = 5;
    [self.view addSubview:challengeSlider];
    [challengeSlider release];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 520, 168, 60)];
    imageView.image = [UIImage imageNamed:@"report_mid.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(300, 520, 168, 60);
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [button setTitle:@"View Positions" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)buttonPressed:(id)buttonSender{
    NSString * sql =[[NSString alloc] initWithFormat:@"select id,categoryId,name,thumbnail,instruction,challenge,pleasure,isMarkFavorite,isMarkDone,isMarkCheck from pose where challenge = %d and pleasure = %d",(int)challengeSlider.value,(int)pleasureSlider.value];
    content = [[[SQLData sharedSQLData] getSelectInfoBySliderWithSqlString:sql] retain];
    ItemViewController_iPad * itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
    itemViewController.startFlag = 20;
    itemViewController.content = content;
    itemViewController.title = @"Search";
    [self.navigationController pushViewController:itemViewController animated:YES];
    [itemViewController release];
    
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
