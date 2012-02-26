//
//  CategoryViewController_iPad.m
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController_iPad.h"


@implementation CategoryViewController_iPad
@synthesize tapPlayer;
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
    for (UIView * view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    [Utils stopSoundPlayer:tapPlayer];
    [category release];
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
    category = [[SQLData sharedSQLData] getCategoryFlagList];
    [self initCategoryItem];
}

- (void) initCategoryItem{
    int x = 0;
    int y = 0;
    for (int i = 0; i < [category count]; ++i) {
        x = i % 3;
        y = i / 3;
        UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(100+x*204, 80+y*210, 160, 160) :i+1 :[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:2]]:[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:3]]];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel *label = [Utils addLabelToView:CGRectMake(100+x*204, 245+y*210, 160, 20) :i+1 :[[category objectAtIndex:i] objectAtIndex:1]:22.0];
        [self.view addSubview:label];
        [label release];        
    }
    [self addAdWhirlAds];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)addAdWhirlAds{
    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    adWhirlView.frame = CGRectMake(110, 905, 768, 90);
    adWhirlView.delegate = self;
    CGAffineTransform transform = CGAffineTransformMakeRotation(0.0);
    [adWhirlView setTransform:CGAffineTransformScale(transform, 0.7, 0.7)];
    
    [[adWhirlView layer] setMasksToBounds:YES];
    [[adWhirlView layer] setCornerRadius:25.0];
    [[adWhirlView layer] setBorderWidth:0.0];
    [adWhirlView rotateToOrientation:UIInterfaceOrientationPortrait];
    [self.view addSubview:adWhirlView];
}

- (NSString *)adWhirlApplicationKey {
    return @"8e7b41e030c94401a42fcae5412b4c57";
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)buttonPressed:(id)buttonSender{
    UIButton *button = (UIButton *)buttonSender;
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:TapPlayFileName :1];
        [tapPlayer play];
    }
    ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];    
    itemViewController.startFlag = button.tag;
    itemViewController.title = [[category objectAtIndex:button.tag-1] objectAtIndex:1];
    [self.navigationController pushViewController:itemViewController animated:YES];
    [itemViewController release];
}
 
@end
