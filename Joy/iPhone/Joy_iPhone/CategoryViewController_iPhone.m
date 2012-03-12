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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPhone]];
	inapp = [[InAppPurchaseManager alloc] init];
    category = [[SQLData sharedSQLData] getCategoryFlagList];
    [self initCategoryItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseSuccess) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
}

- (void)purchaseSuccess{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.SCROLLVIEW_HEIGHT   =   50;
    appDelegate.IMAGEVIEW_HEIGHT    =   270;
    appDelegate.TEXTVIEW_HEIGHT     =   300;
    appDelegate.BUTTONVIEW_HEIGHT   =   390;
    appDelegate.SCROLLVIEW_HEIGHT_F =   260;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"购买成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) initCategoryItem{
    int x = 0;
    int y = 0;
    for (int i = 0; i < [category count]; ++i) {
        x = i % 3;
        y = i / 3;
        UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(30+98*x, 50+98*y, 64, 64) :i+1 :[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:2]]:[UIImage imageNamed:[[category objectAtIndex:i] objectAtIndex:3]]];
        if (i == 2) {
            //change its position to location where i = 3
            button.frame = CGRectMake(30, 50+98, 64, 64);
        }
        if (i == 3) {
            //change its position to location where i = 2
            button.frame = CGRectMake(30+100*2, 50, 64, 64);
        }
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel *label = [Utils addLabelToView:CGRectMake(20+100*x, 114+98*y, 80, 20) :i+1 :[[category objectAtIndex:i] objectAtIndex:1]:13.0];
        if (i == 2) {
            //change its position to location where i = 3
            label.frame = CGRectMake(20, 114+98, 80, 20);
        }
        if (i == 3) {
            //change its position to location where i = 2
            label.frame = CGRectMake(20+100*2, 114, 80, 20);
        }
        [self.view addSubview:label];
        [label release];        
    }
    //[self addAdWhirlAds];
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
    return ADWHIRL_ID_IPHONE;
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
    if (button.tag == 3 || button.tag > 4) {
        [self manageIndappWithIndex:button.tag];
    }else{
        [self changeToItemViewControllerWithIndex:button.tag];
    }
}

- (void)manageIndappWithIndex:(NSInteger)indexNum{
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
                                                                message:@"网络未连接.请检查你的网络连接." 
                                                               delegate:self 
                                                      cancelButtonTitle:@"确定" 
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
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3":1];
        [tapPlayer play];
    }
    ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];    
    itemViewController.startFlag = indexNum;
    itemViewController.title = [[category objectAtIndex:indexNum-1] objectAtIndex:1];
    [self.navigationController pushViewController:itemViewController animated:YES];
    [itemViewController release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
