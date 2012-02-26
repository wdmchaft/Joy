//
//  MoreJokeController_iPhone.m
//  Joy
//
//  Created by mac on 12-2-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreJokeController_iPhone.h"


@implementation MoreJokeController_iPhone
@synthesize audioPlayer;
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
    [audioPlayer release];
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LINEbackground.png"]];
    UIImageView * topbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    topbarView.image = [UIImage imageNamed:@"topbar.png"];
    [self.view addSubview:topbarView];
    [topbarView release];
    
    //init topLabel of view
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 320, 60) :0 :[UIColor clearColor] :@"What More...?" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    //init backButton
    UIButton * backButton   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 15, 25, 25) :0 :[UIImage imageNamed:@"backButton@2x.png"] :nil];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //init three more buttons
    [self initThreeButtons];      
    //init image on buttons
    [self initThreeImages];
    //init label on buttons
    [self initThreLabels];
}
- (void) initThreeButtons{
    UIButton * F_Button = [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 100, 280, 80) :0 :[UIImage imageNamed:@"BlankSubmitButton.png"] :nil];
    UIButton * S_Button = [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 200, 280, 80) :0 :[UIImage imageNamed:@"BlankSubmitButton.png"] :nil];
    UIButton * T_Button = [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 300, 280, 80) :0 :[UIImage imageNamed:@"BlankSubmitButton.png"] :nil];
    
    [F_Button addTarget:self action:@selector(F_ButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:F_Button];
    [S_Button addTarget:self action:@selector(S_ButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:S_Button];
    [T_Button addTarget:self action:@selector(T_ButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:T_Button]; 
}

- (void) initThreeImages{
    UIImageView * F_ImageView = [Utils addCoverImageViewToView:CGRectMake(30, 110, 60, 60) :[UIImage imageNamed:@"facts_icon@2x.png"] :0 :1.0];
    [self.view addSubview:F_ImageView];
    [F_ImageView release];
    
    UIImageView * S_ImageView = [Utils addCoverImageViewToView:CGRectMake(30, 210, 60, 60) :[UIImage imageNamed:@"quotes_icon@2x.png"] :0 :1.0];
    [self.view addSubview:S_ImageView];
    [S_ImageView release];
    
    UIImageView * T_ImageView = [Utils addCoverImageViewToView:CGRectMake(30, 310, 60, 60) :[UIImage imageNamed:@"iphone_icon@2x.png"] :0 :1.0];
    [self.view addSubview:T_ImageView];
    [T_ImageView release];
}

- (void) initThreLabels{
    UILabel * F_Label       =   [Utils addCoverLabelToView:CGRectMake(100, 110, 150, 60) :0 :[UIColor clearColor] :@"The Largest Collection of Fun Facts avaliable for the iPhone" :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"GeezaPro" size:12]];
    F_Label.numberOfLines   =   2;
    [self.view addSubview:F_Label];
    [F_Label release];
    UILabel * S_Label       =   [Utils addCoverLabelToView:CGRectMake(100, 210, 150, 60) :0 :[UIColor clearColor] :@"The Ultimate Collection of Quotes avaliable for the iPhone" :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"GeezaPro" size:12]];
    S_Label.numberOfLines   =   2;
    [self.view addSubview:S_Label];
    [S_Label release];
    UILabel * T_Label       =   [Utils addCoverLabelToView:CGRectMake(100, 310, 150, 60) :0 :[UIColor clearColor] :@"Unlock the Power of your iPhone/iTouch" :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"GeezaPro" size:12]];
    [self.view addSubview:T_Label];
    [T_Label release];
}

- (void)backButtonPressed{   
    [self audioPlayerPlay];
    CATransition *tran = [CATransition animation];
    tran.duration = .4f;
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromBottom; //Bottom for the opposite direction
    tran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tran.removedOnCompletion  = YES;
    [self.navigationController.view.layer addAnimation:tran forKey:@"TransitionDownUp"]; 
    [self.navigationController popViewControllerAnimated:NO];
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

- (void)F_ButtonPressed{

}

- (void)S_ButtonPressed{

}

- (void)T_ButtonPressed{

}

- (void) audioPlayerPlay{
    if ([Utils ifSoundPlayerCouldPlay] == YES) {
        audioPlayer = [Utils addCoverAVAudioPlayer:audioPlayer];
        [audioPlayer play];
    }
}

@end
