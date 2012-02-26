//
//  SettingController_iPhone.m
//  Joy
//
//  Created by mac on 12-2-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingController_iPhone.h"


@implementation SettingController_iPhone
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
    UILabel * topLabel = [Utils addCoverLabelToView:CGRectMake(0, 0, 320, 60) :0 :[UIColor clearColor] :@"Settings" :UITextAlignmentCenter :[UIColor blackColor]:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    UIButton * backButton   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(20, 15, 25, 25) :0 :[UIImage imageNamed:@"backButton@2x.png"] :nil];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self initImageViews];    
    [self initButtons];
    [self initLabels];
    [self initSlider];
    [self initSwitch];
}

- (void) initImageViews{
    UIImageView * F_ImageView           =   [Utils addCoverImageViewToView:CGRectMake(20, 90, 260, 70) :[UIImage imageNamed:@"topbar.png"] :0 :1.0];
    UIImageView * S_ImageView           =   [Utils addCoverImageViewToView:CGRectMake(20, 180, 260, 70) :[UIImage imageNamed:@"topbar.png"] :0 :1.0];
    UIImageView * imageView_Font        =   [Utils addCoverImageViewToView:CGRectMake(20, 60, 75, 30) :[UIImage imageNamed:@"FontSizeTitle.png"] :0 :1.0];
    UIImageView * imageView_Sound       =   [Utils addCoverImageViewToView:CGRectMake(20, 150, 64, 26) :[UIImage imageNamed:@"SoundsLabel.png"] :0 :1.0];
    UIImageView * imageView_Submission  =   [Utils addCoverImageViewToView:CGRectMake(20, 240, 90, 25) :[UIImage imageNamed:@"SubmissionTitle.png"] :0 :1.0];
    
    [self.view addSubview:F_ImageView];     
    [self.view addSubview:S_ImageView];
    [self.view addSubview:imageView_Font];
    [self.view addSubview:imageView_Sound];
    [self.view addSubview:imageView_Submission];
    [F_ImageView release];
    [S_ImageView release];
    [imageView_Font release];
    [imageView_Sound release];
    [imageView_Submission release];
}

- (void) initLabels{
    UILabel * label_Sound       =   [Utils addCoverLabelToView:CGRectMake(30, 190, 150, 40) :0 :[UIColor clearColor] :@"Interface Sounds" :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    UILabel * label_Feedback    =   [Utils addCoverLabelToView:CGRectMake(30, 280, 150, 40) :0 :[UIColor clearColor] :@"Submit Feedback" :UITextAlignmentLeft :[UIColor blackColor]:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    UILabel * label_NewJoke     =   [Utils addCoverLabelToView:CGRectMake(30, 360, 150, 40):0 :[UIColor clearColor] :@"Submit New Joke" :UITextAlignmentLeft :[UIColor blackColor] :[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    
    [self.view addSubview:label_Sound];
    [self.view addSubview:label_Feedback];
    [self.view addSubview:label_NewJoke];
    
    [label_Sound release];
    [label_NewJoke release];
    [label_Feedback release];
}

- (void) initButtons{
    UIButton * button_Feedback  =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(10, 260, 280, 80) :0 :[UIImage imageNamed:@"BlankSubmitButton.png"] :nil];
    UIButton * button_NewJoke   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(10, 340, 280, 80):0 :[UIImage imageNamed:@"BlankSubmitButton.png"] :nil];
    
    [button_Feedback addTarget:self action:@selector(button_FeedbackPressed) forControlEvents:UIControlEventTouchUpInside];
    [button_NewJoke addTarget:self action:@selector(button_NewJokePressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button_Feedback];
    [self.view addSubview:button_NewJoke];
}

- (void) initSlider{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    UISlider *slider        =   [[UISlider alloc] initWithFrame:CGRectMake(30,107,240,7)];                                                          
    slider.backgroundColor  =   [UIColor clearColor];      
    slider.minimumValue     =   8.0;
    slider.maximumValue     =   26.0;
    slider.value            =   appDelegate.COVER_SLIDER_VALUE ; 
    [slider addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];    
    [self.view addSubview:slider];
}

- (void) initSwitch{
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(180, 195, 80, 50)];
    switchView.on = YES;
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchView];
    [switchView release];
}

- (void) backButtonPressed{
    [self audioPlayerPlay];
    CATransition *animation         =   [CATransition animation ];  
    animation.delegate              =   self;   
    animation.duration              =   0.5f;   
    animation.timingFunction        =   UIViewAnimationCurveEaseInOut;  
    animation.fillMode              =   kCAFillModeForwards;  
    animation.removedOnCompletion   =   NO;  
    animation.type                  =   @"oglFlip";
    animation.subtype               =   @"fromLeft";
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)button_FeedbackPressed{
    [self sendEMail:@"Feed Back" :@"mailto:kayeMediaMobile@gmail.com&subject=Advices & Suggestions!"];
}

- (void)button_NewJokePressed{
    [self sendEMail:@"New Jokes" :@"mailto:kayeMediaMobile@gmail.com&subject=New Jokes"];
}

- (void)sliderDragUp:(id)sliderSender{
    UISlider * slider = (UISlider *)sliderSender;
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.COVER_SLIDER_VALUE = slider.value;
}

- (void)switchAction:(id)switchSender{
    UISwitch * switchView = (UISwitch *)switchSender;    
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.COVER_SOUND_FLAG = switchView.on;
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

- (void) audioPlayerPlay{
    if ([Utils ifSoundPlayerCouldPlay] == YES) {
        audioPlayer = [Utils addCoverAVAudioPlayer:audioPlayer];
        [audioPlayer play];
    }
}

/****
 *this method is used for email
 *
 */
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg   
{  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_   
                                                    message:msg   
                                                   delegate:nil   
                                          cancelButtonTitle:@"YES"   
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
}
- (void) sendEMail:(NSString *)emailTitle:(NSString *)emailAddress   
{  
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self displayComposerSheet:(NSString *)emailTitle];  
        }   
        else   
        {  
            [self launchMailAppOnDevice:(NSString *)emailAddress];  
        }  
    }   
    else   
    {  
        [self launchMailAppOnDevice:(NSString *)emailAddress];  
    }      
}  

- (void) displayComposerSheet:(NSString *)emailTitle   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    [mailPicker setSubject:emailTitle];  
    NSArray *toRecipients = [NSArray arrayWithObject: @"kayeMediaMobile@gmail.com"];  

    [mailPicker setToRecipients: toRecipients]; 
    
    [mailPicker setMessageBody:@"" isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
}  
- (void) launchMailAppOnDevice:(NSString *)emailAddress
{  
    NSString *recipients = emailAddress;  
    
    NSString *body = @"&body=email body!";  
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];  
}  
- (void) mailComposeController:(MFMailComposeViewController *)controller   
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   
{  
    NSString *msg;  
    
    switch (result)   
    {  
        case MFMailComposeResultCancelled:  
            msg = @"Canceled";  
            break;  
        case MFMailComposeResultSaved:  
            msg = @"Saved";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultSent:  
            msg = @"Succeed";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultFailed:  
            msg = @"Failed";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        default:  
            break;  
    }  
    
    [self dismissModalViewControllerAnimated:YES];  
}


@end
