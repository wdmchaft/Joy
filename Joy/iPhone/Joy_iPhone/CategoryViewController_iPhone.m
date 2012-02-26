//
//  CategoryViewController_iPhone.m
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController_iPhone.h"


@implementation CategoryViewController_iPhone
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Item_background.jpg"]];
	category = [[SQLData sharedSQLData] getCategoryFlagList];
    [self initCategoryItem];
}

- (void) initCategoryItem{
    int x = 0;
    int y = 0;
    for (int i = 0; i < [category count]; ++i) {
        x = i % 3;
        y = i / 3;
        UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(30+98*x, 50+98*y, 64, 64) :i+1 :[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:2]]:[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:3]]];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel *label = [Utils addLabelToView:CGRectMake(20+100*x, 114+98*y, 80, 20) :i+1 :[[category objectAtIndex:i] objectAtIndex:1]:13.0];
        [self.view addSubview:label];
        [label release];        
    }
    [self addAdWhirlAds];
}

- (void)addAdWhirlAds{
    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    adWhirlView.frame = CGRectMake(46, 390, 320, 50);
    adWhirlView.delegate = self;
    CGAffineTransform transform = CGAffineTransformMakeRotation(0.0);
    [adWhirlView setTransform:CGAffineTransformScale(transform, 0.7, 0.7)];
    
    [[adWhirlView layer] setMasksToBounds:YES];
    [[adWhirlView layer] setCornerRadius:15.0];
    [[adWhirlView layer] setBorderWidth:0.0];
    [adWhirlView rotateToOrientation:UIInterfaceOrientationPortrait];
    [self.view addSubview:adWhirlView];
}

- (NSString *)adWhirlApplicationKey {
    return @"07b04fd1170d493fba092369b3acc960";
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)buttonPressed:(id)buttonSender{
    UIButton *button = (UIButton *)buttonSender;
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3":1];
        [tapPlayer play];
    }
    ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];    
    itemViewController.startFlag = button.tag;
    itemViewController.title = [[category objectAtIndex:button.tag-1] objectAtIndex:1];
    [self.navigationController pushViewController:itemViewController animated:YES];
    [itemViewController release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
