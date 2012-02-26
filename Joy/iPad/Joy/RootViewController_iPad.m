//
//  RootViewController_iPad.m
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController_iPad.h"


@implementation RootViewController_iPad
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
    [Utils stopSoundPlayer:tapPlayer];
    [labelTitle release];
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPad]];
}

- (void)viewWillAppear:(BOOL)animated{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self cleanItemsView];
    if (appDelegate.JOY_PASSWORD_FLAG == 0) {
        [self ifPassWord];
    }else{
        [self initItems];
    }
}

- (void)cleanItemsView{
    for (UIView * v in [self.view subviews]) {
        [v removeFromSuperview];
    }
}

- (void) initItems{
    NSArray *upButtonImageArray = [[NSArray alloc] initWithObjects:@"categories.png",@"favorite.png",@"hints.png",@"tried.png",@"untried.png",@"todoicon.png",@"random.png",@"places.png",@"securityactive.png",nil];
    NSArray *downButtonImageArray = [[NSArray alloc] initWithObjects:@"categoriesdown.png",@"favoritedown.png",@"hintsdown.png",@"trieddown.png",@"untrieddown.png",@"todoicondown.png",@"randomdown.png",@"placesdown.png",@"securityactive.png",nil];
    labelTitle = [[NSArray alloc] initWithObjects:@"Category",@"Favorite",@"Top",@"Tried",@"Untried",@"Todo",@"Random",@"Search",@"Security",nil];
    
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j <3; ++j) {
            UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(100+j*204, 80+i*210, 160, 160) :j+i*3+1 :[UIImage imageNamed:[upButtonImageArray objectAtIndex:j+i*3]]:[UIImage imageNamed:[downButtonImageArray objectAtIndex:j+i*3]]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            UILabel *label = [Utils addLabelToView:CGRectMake(100+j*204, 245+i*210, 160, 20) :j+i*3+1 :[labelTitle objectAtIndex:j+i*3]:22.0];
            [self.view addSubview:label];
            [label release];
        }        
    }
    [upButtonImageArray release];
    [downButtonImageArray release];
    [self addAdWhirlAds];
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
	return YES;
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

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
}

- (void)buttonPressed:(id)buttonSender{
    UIButton *button = (UIButton *)(buttonSender);
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:TapPlayFileName :1];
        [tapPlayer play];
    }
    if (button.tag == 1) {
        CategoryViewController_iPad *categoryViewController = [[CategoryViewController_iPad alloc] initWithNibName:@"CategoryViewController_iPad" bundle:nil];    
        categoryViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:categoryViewController animated:YES];
        [categoryViewController release];
    }else if(button.tag == 2){
        ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
        itemViewController.startFlag = 11;
        itemViewController.title = @"Favorite";
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 3){
        ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
        itemViewController.startFlag = 10;
        itemViewController.title = @"Top 10";
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 4){
        ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
        itemViewController.startFlag = 12;
        itemViewController.title = @"Tried";
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 5){
        ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
        itemViewController.startFlag = 13;
        itemViewController.title = @"Untried";
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 6){
        ItemViewController_iPad *itemViewController = [[ItemViewController_iPad alloc] initWithNibName:@"ItemViewController_iPad" bundle:nil];
        itemViewController.startFlag = 14;
        itemViewController.title = @"To do";
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 7){
        ItemShowController_iPad *itemShowController = [[ItemShowController_iPad alloc] initWithNibName:@"ItemShowController_iPad" bundle:nil];
        itemShowController.startFlag = 1000;
        itemShowController.title = @"Random";
        [self.navigationController pushViewController:itemShowController animated:YES];
        [itemShowController release];
    }else if(button.tag == 8){
        SliderViewController_iPad * sliderViewController = [[SliderViewController_iPad alloc] initWithNibName:@"SliderViewController_iPad" bundle:nil];
        sliderViewController.title = @"Search";
        [self.navigationController pushViewController:sliderViewController animated:YES];
        [sliderViewController release];
    }else if(button.tag == 9){
        PasswordController_iPad *settingViewController = [[PasswordController_iPad alloc] initWithNibName:@"PasswordController_iPad" bundle:nil];
        settingViewController.title = @"Security";
        [self.navigationController pushViewController:settingViewController animated:YES];
        [settingViewController release];
    }  
}

- (void) ifPassWord{
    password = [[SQLData sharedSQLData] getJoyPasswordFlagList];
    if ([[[password objectAtIndex:0] objectAtIndex:0] isEqualToString:@"1"]) {
        view = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 368, 240)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
        [self.view addSubview:view];
        [view release];
        
        UILabel *label = [Utils addLabelToView:CGRectMake(20, 30, 300, 30) :0 :@"Enter Password:" :14.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentLeft;
        [view addSubview:label];
        [label release];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 320, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.tag = 100;
        textField.delegate = self;
        [view addSubview:textField];
        [textField release];
        
        UIButton *okbuttom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [okbuttom addTarget:self action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [okbuttom setTitle:@"OK" forState:UIControlStateNormal];
        okbuttom.titleLabel.textColor = [UIColor blueColor];
        okbuttom.frame = CGRectMake(40, 150, 100, 40);
        [view addSubview:okbuttom];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        cancelButton.titleLabel.textColor = [UIColor blueColor];
        cancelButton.frame = CGRectMake(220, 150, 100, 40);
        [view addSubview:cancelButton];
        
        
    }else{
        [self initItems];
    }
}

- (void) okButtonPressed:(id)okbuttonSender{
    UITextField *textField = (UITextField *)[view viewWithTag:100];
    if ([[[password objectAtIndex:0] objectAtIndex:1] isEqualToString:textField.text]) {
        JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.JOY_PASSWORD_FLAG = 1;
        [self cleanPasswordView];
        [self initItems];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password!"
                                                        message:nil
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (void)cancelButtonPressed:(id)cancelSender{
    [self cleanPasswordView];
}

- (void) cleanPasswordView{
    for (UIView *v in [view subviews]) {
        [v removeFromSuperview];
    }
    [view removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
