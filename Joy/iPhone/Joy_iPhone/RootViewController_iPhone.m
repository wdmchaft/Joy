//
//  RootViewController_iPhone.m
//  Joy
//
//  Created by mac on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController_iPhone.h"


@implementation RootViewController_iPhone
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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"评分" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];          
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
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

- (void)rightButtonPressed:(id)rightSender{
    JoyAppDelegate * appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.RATE_TO_UNLOCK = 1;
    [UserDefaultKeySet saveToUserDefaults:[NSString stringWithFormat:@"%d", 1] forKey:@"haveUserRated"];
    [[UIApplication sharedApplication] 
     openURL:[NSURL URLWithString:RATE_STRING]];
}

- (void) initItems{
    //NSArray *upButtonImageArray = [[NSArray alloc] initWithObjects:@"categories_p.png",@"favorite_p.png",@"hints_p.png",@"tried_p.png",@"untried_p.png",@"todoicon_p.png",@"random_p.png",@"search_p.png",@"securityactive_p.png",nil];
    NSArray *upButtonImageArray = [[NSArray alloc] initWithObjects:@"home.png",@"favorite.png",@"hints.png",@"tried.png",@"untried.png",@"todoicon.png",@"random.png",@"search.png",@"securityactive.png",nil];
    NSArray *downButtonImageArray = [[NSArray alloc] initWithObjects:@"categories_p.png",@"favorite_p.png",@"hints_p.png",@"tried_p.png",@"untried_p.png",@"todoicon_p.png",@"random_p.png",@"search_p.png",@"securityactive_p.png",nil];
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.DATABASE_NAME isEqualToString:DATABASE_CH]) {
        labelTitle = [[NSArray alloc] initWithObjects:@"目录",@"喜欢",@"最受欢迎",@"已尝试",@"未尝试",@"即将尝试",@"随机",@"搜索",@"安全",nil];
    }else{
        labelTitle = [[NSArray alloc] initWithObjects:@"Category",@"Favorite",@"Top",@"Tried",@"Untried",@"Todo",@"Random",@"Search",@"Security",nil];
    }
    
    
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j <3; ++j) {
            UIButton *button = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(30+98*j, 50+98*i, 64, 64) :j+i*3+1 :[UIImage imageNamed:[upButtonImageArray objectAtIndex:j+i*3]]:[UIImage imageNamed:[downButtonImageArray objectAtIndex:j+i*3]]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            UILabel *label = [Utils addLabelToView:CGRectMake(30+98*j, 114+98*i, 64, 20) :j+i*3+1 :[labelTitle objectAtIndex:j+i*3]:13.0];
            [self.view addSubview:label];
            [label release];
        }        
    }
    [upButtonImageArray release];
    [downButtonImageArray release];
    //Remove Ad here in this version
    //[self addAdWhirlAds];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)buttonPressed:(id)buttonSender{
    UIButton *button = (UIButton *)(buttonSender);
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3" :1];
        [tapPlayer play];
    }
    if (button.tag == 1) {
        CategoryViewController_iPhone *categoryViewController = [[CategoryViewController_iPhone alloc] initWithNibName:@"CategoryViewController_iPhone" bundle:nil];    
        //categoryViewController.startFlag = resultButton.tag;
        categoryViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:categoryViewController animated:YES];
        [categoryViewController release];
    }else if(button.tag == 2){
        ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
        itemViewController.startFlag = 11;
        itemViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 3){
        ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
        itemViewController.startFlag = 10;
        itemViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 4){
        ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
        itemViewController.startFlag = 12;
        itemViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 5){
        ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
        itemViewController.startFlag = 13;
        itemViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 6){
        ItemViewController_iPhone *itemViewController = [[ItemViewController_iPhone alloc] initWithNibName:@"ItemViewController_iPhone" bundle:nil];
        itemViewController.startFlag = 14;
        itemViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemViewController animated:YES];
        [itemViewController release];
    }else if(button.tag == 7){
        ItemShowController_iPhone *itemShowController = [[ItemShowController_iPhone alloc] initWithNibName:@"ItemShowController_iPhone" bundle:nil];
        itemShowController.startFlag = 1000;
        itemShowController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:itemShowController animated:YES];
        [itemShowController release];
    }else if(button.tag == 8){
        SliderViewController_iPhone * sliderViewController = [[SliderViewController_iPhone alloc]initWithNibName:@"SliderViewController_iPhone" bundle:nil];
        sliderViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:sliderViewController animated:YES];
        [sliderViewController release];
    }else if(button.tag == 9){
        PasswordController_iPhone *settingViewController = [[PasswordController_iPhone alloc] initWithNibName:@"PasswordController_iPhone" bundle:nil];
        settingViewController.title = [labelTitle objectAtIndex:button.tag - 1];
        [self.navigationController pushViewController:settingViewController animated:YES];
        [settingViewController release];
    }  
}


- (void) ifPassWord{
	password = [[SQLData sharedSQLData] getJoyPasswordFlagList];
    if ([[[password objectAtIndex:0] objectAtIndex:0] isEqualToString:@"1"]) {
        view = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 220, 130)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
        [self.view addSubview:view];
        [view release];
        
        UILabel *label = [Utils addLabelToView:CGRectMake(10, 10, 200, 20) :0 :@"输入密码:" :14.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentLeft;
        [view addSubview:label];
        [label release];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, 200, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.tag = 100;
        textField.delegate = self;
        [view addSubview:textField];
        [textField release];
        
        UIButton *okbuttom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [okbuttom addTarget:self action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [okbuttom setTitle:@"确定" forState:UIControlStateNormal];
        okbuttom.titleLabel.textColor = [UIColor blueColor];
        okbuttom.frame = CGRectMake(30, 80, 60, 30);
        [view addSubview:okbuttom];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.textColor = [UIColor blueColor];
        cancelButton.frame = CGRectMake(130, 80, 60, 30);
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码错误"
                                                        message:nil
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
