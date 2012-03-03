//
//  ItemViewController_iPad.m
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController_iPad.h"


@implementation ItemViewController_iPad
@synthesize startFlag;
@synthesize itemScrollView;
@synthesize tapPlayer;
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
    for (UIView * view in [itemScrollView subviews]) {
        [view removeFromSuperview];
    }
    [Utils stopSoundPlayer:tapPlayer];
    [itemScrollView removeFromSuperview];
    [content release];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadContent) name:RATEUS_UNLOCK_COULD_UNLOCK_THIS_PRODUCT_NOW_NOTIFICATION object:nil];
    /*
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (startFlag == 10) {
        if (appDelegate.RATE_TO_UNLOCK == 1) {
            [self initDataSource];
            itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
            [self.view addSubview:itemScrollView];
            [itemScrollView release];
            itemScrollView.contentSize = CGSizeMake(768, ([content count]/5+1)*150+200); 
            [self initItemView];
            itemScrollView.delegate = self;
            if ([content count] == 0){
                iToast  *toast = [iToast makeText:@"List is empty now!"];
                [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:150];
                [toast show];
            }
        }else{
            [self initBonusModelView];
        }
    }else{  
        [self initDataSource];
        itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
        [self.view addSubview:itemScrollView];
        [itemScrollView release];
        itemScrollView.contentSize = CGSizeMake(768, ([content count]/5+1)*150+200); 
        [self initItemView];
        itemScrollView.delegate = self;
        if ([content count] == 0){
            iToast  *toast = [iToast makeText:@"List is empty now!"];
            [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:150];
            [toast show];
        }
    }
     */
    [self initDataSource];
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [self.view addSubview:itemScrollView];
    [itemScrollView release];
    itemScrollView.contentSize = CGSizeMake(768, ([content count]/5+1)*150+200); 
    [self initItemView];
    itemScrollView.delegate = self;
    if ([content count] == 0){
        iToast  *toast = [iToast makeText:@"列表为空!"];
        [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:150];
        [toast show];
    }
}

- (void) cleanAllViews{
    for (UIImageView * view in [self.view subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.image = nil;
        }
        [view removeFromSuperview];
    }
}

- (void)loadContent{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    appDelegate.RATE_TO_UNLOCK = 1;
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", 1] forKey:@"haveUserRated"];
    [self cleanAllViews];
    [self initDataSource];
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [self.view addSubview:itemScrollView];
    [itemScrollView release];
    itemScrollView.contentSize = CGSizeMake(768, ([content count]/5+1)*150+200); 
    [self initItemView];
    itemScrollView.delegate = self;
    if ([content count] == 0){
        iToast  *toast = [iToast makeText:@"列表为空!"];
        [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:150];
        [toast show];
    }
}

- (void) initBonusModelView{
    UIImageView * backImage = [Utils addImageViewToView:CGRectMake(0, 0, 768, 1024) :0 :[UIImage imageNamed:@"topposter_ipad.jpg"]];
    [self.view addSubview:backImage];
    [backImage release];
    
    
    UIButton * unlockButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(440, 700, 200, 65) :1 :nil :nil];
    [unlockButton addTarget:self action:@selector(unlockButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unlockButton];
    
    UIButton * rateButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(400, 830, 280, 85) :1 :nil :nil];
    [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
    
}

- (void)rateButtonPressed:(id)rateButtonSender{
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", 1] forKey:RATEUS_RATE_CLICK_TIMES_KEY];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:RATE_STRING]];
}

- (void)backBonusButtonPressed:(id)backBonusButtonSender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)backButtonPressed:(id)backButtonSender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)unlockButtonPressed:(id)unlockSender{
    if ([[rateus sharedRateUs] didUserReallyRatedUs]) {    
        [self initDataSource];
        itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
        [self.view addSubview:itemScrollView];
        [itemScrollView release];
        itemScrollView.contentSize = CGSizeMake(768, ([content count]/5+1)*150+200); 
        [self initItemView];
        itemScrollView.delegate = self;
        if ([content count] == 0){
            iToast  *toast = [iToast makeText:@"列表为空!"];
            [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:150];
            [toast show];
        }
    }else{
        [[rateus sharedRateUs] callMeEachTimeTheProductUnlockClickHappens];
    }    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void) initDataSource{
    if (startFlag < 10) {
        NSString *start = [[NSString alloc] initWithFormat:@"%d",startFlag];
        content = [[SQLData sharedSQLData] getSelectPoseInfoList:start];
        [start release];
    }else if(startFlag == 10){
        content = [[SQLData sharedSQLData] getSelectTopTenInfoList];
    }else if(startFlag == 11){
        content = [[SQLData sharedSQLData] getSelectFavoriteInfoList];
    }else if(startFlag == 12){
        content = [[SQLData sharedSQLData] getSelectDoneInfoList];
    }else if(startFlag == 13){
        /*
         *If custom has already purchased this product, running getSelectUnDoneInfoList Part;
         *else running getSelectUnDoneInfoListWithoutPurchase.
         */
        BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
        if(isProUpgradePurchased == NO){
            content = [[SQLData sharedSQLData] getSelectUnDoneInfoListWithoutPurchase];
        }else{
            content = [[SQLData sharedSQLData] getSelectUnDoneInfoList];
        }        
    }else if(startFlag == 14){
        content = [[SQLData sharedSQLData] getSelectTodoInfoList];
    }
}

- (void)initItemView{
    int x = 0;
    int y = 0;
    if ([content count] <= 60) {
        for (int i = 0; i < [content count]; ++i) {
            x = i % 5;
            y = i / 5;
            UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(54+140*x, 20+140*y, 100, 100) :i:[UIImage imageNamed:ITEM_BK_PHONE]:[UIImage imageNamed:ITEM_BK_PHONE]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [itemScrollView addSubview:button];
            
            UIImageView *imageView = [Utils addImageViewToView:CGRectMake(64+140*x, 30+140*y, 80, 80) :i :[UIImage imageNamed:[[content objectAtIndex:i] objectAtIndex:3]]];
            [itemScrollView addSubview:imageView];
            [imageView release];
            
            UILabel *label = [Utils addLabelToView:CGRectMake(54+140*x, 130+140*y, 80, 20) :i+1 :[[content objectAtIndex:i] objectAtIndex:2]:17.0];
            [itemScrollView addSubview:label];
            [label release]; 
        }
    }else{
        loadNum = [content count]/60;
        for (int i = 0; i < 60; ++i) {
            x = i % 5;
            y = i / 5;
            UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(54+140*x, 20+140*y, 100, 100) :i:[UIImage imageNamed:ITEM_BK_PHONE]:[UIImage imageNamed:ITEM_BK_PHONE]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [itemScrollView addSubview:button];
            
            UIImageView *imageView = [Utils addImageViewToView:CGRectMake(64+140*x, 30+140*y, 80, 80) :i :[UIImage imageNamed:[[content objectAtIndex:i] objectAtIndex:3]]];
            [itemScrollView addSubview:imageView];
            [imageView release];
            
            UILabel *label = [Utils addLabelToView:CGRectMake(54+140*x, 130+140*y, 80, 20) :i+1 :[[content objectAtIndex:i] objectAtIndex:2]:17.0];
            [itemScrollView addSubview:label];
            [label release]; 
        }
    }
    
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
    ItemShowController_iPad *itemShowController = [[ItemShowController_iPad alloc] initWithNibName:@"ItemShowController_iPad" bundle:nil];
    itemShowController.content = content;
    itemShowController.startFlag = button.tag;
    itemShowController.title = [[content objectAtIndex:button.tag] objectAtIndex:2];
    [self.navigationController pushViewController:itemShowController animated:YES];
    [itemShowController release];    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    int x = 0;
    int y = 0;
    if ([content count] > 60) {
        if (loadNum > 0) {
            for (int i = 60; i < [content count]; ++i) {
                x = i % 5;
                y = i / 5;
                UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(54+140*x, 20+140*y, 100, 100) :i:[UIImage imageNamed:ITEM_BK_PHONE]:[UIImage imageNamed:ITEM_BK_PHONE]];
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [itemScrollView addSubview:button];
                
                UIImageView *imageView = [Utils addImageViewToView:CGRectMake(64+140*x, 30+140*y, 80, 80) :i :[UIImage imageNamed:[[content objectAtIndex:i] objectAtIndex:3]]];
                [itemScrollView addSubview:imageView];
                [imageView release];
                
                UILabel *label = [Utils addLabelToView:CGRectMake(54+140*x, 130+140*y, 80, 20) :i+1 :[[content objectAtIndex:i] objectAtIndex:2]:17.0];
                [itemScrollView addSubview:label];
                [label release]; 
            }
            loadNum = 0;
        }        
    }
}
@end
