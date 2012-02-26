//
//  SettingViewController_iPhone.m
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController_iPhone.h"


@implementation SettingViewController_iPhone

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
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
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
    UIImageView *imageView = [Utils addImageViewToView:CGRectMake(50, 80, 220, 280) :0 :[UIImage imageNamed:@"set_background.png"]];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIButton *soundButton = [Utils addButtonToView:UIButtonTypeCustom:CGRectMake(65, 100, 80, 80) :0 :[UIImage imageNamed:@"musicactive.png"] :[UIImage imageNamed:@"musicactive.png"]];
    [soundButton addTarget:self action:@selector(soundButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soundButton];
    UILabel *soundLabel = [Utils addButtonLabelToView:CGRectMake(50, 180, 110, 20) :0 :@"Sound On/Off" :13.0 :[UIColor whiteColor]];
    [self.view addSubview:soundLabel];
    [soundLabel release];
    
    UIButton *mailButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(175, 115, 80, 60) :0 :[UIImage imageNamed:@"email.png"] :[UIImage imageNamed:@"emaildown.png"]];
    [mailButton addTarget:self action:@selector(mailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];
    UILabel *mailLabel = [Utils addButtonLabelToView:CGRectMake(155, 180, 110, 20) :0 :@"Email" :13.0 :[UIColor whiteColor]];
    [self.view addSubview:mailLabel];
    [mailLabel release];
    
    UIButton *passwdButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(65, 240, 80, 80) :0 :[UIImage imageNamed:@"securityactive.png"] :[UIImage imageNamed:@"securitypassove.png"]];
    [passwdButton addTarget:self action:@selector(passwdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwdButton];
    UILabel *passwdLabel = [Utils addButtonLabelToView:CGRectMake(50, 310, 110, 20) :0 :@"Security" :13.0 :[UIColor whiteColor]];
    [self.view addSubview:passwdLabel];
    [passwdLabel release];
    
    UIButton *rateButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(175, 240, 80, 80) :0 :[UIImage imageNamed:@"recent.png"] :[UIImage imageNamed:@"recentdown.png"]];
    [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
    UILabel *rateLabel = [Utils addButtonLabelToView:CGRectMake(155, 310, 110, 20) :0 :@"Rate us" :13.0 :[UIColor whiteColor]];
    [self.view addSubview:rateLabel];
    [rateLabel release];
    
}

- (void) soundButtonPressed:(id)soundButtonSender{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIButton *button = (id)soundButtonSender;
    if (appDelegate.JOY_SOUND_FLAG == 0) {
        appDelegate.JOY_SOUND_FLAG = 1;
        [button setBackgroundImage:[UIImage imageNamed:@"musicactive.png"] forState:UIControlStateNormal];
    }else{
        appDelegate.JOY_SOUND_FLAG = 0;
        [button setBackgroundImage:[UIImage imageNamed:@"musicpassive.png"] forState:UIControlStateNormal];
    }
    
}

- (void) passwdButtonPressed:(id)passwdSender{
    PasswordController_iPhone *passwordController = [[PasswordController_iPhone alloc] initWithNibName:@"PasswordController_iPhone" bundle:nil];
    passwordController.title = @"Password Setting";
    [self.navigationController pushViewController:passwordController animated:YES];
    [passwordController release];
}

- (void) mailButtonPressed:(id)mailSender{
    [self sendEMail];
}

- (void) rateButtonPressed:(id)rateSender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:RATE_STRING]];
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
/*-------these methods for mail-------*/
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
-(void)sendEMail   
{  
    NSLog(@"sendMail");
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self displayComposerSheet];  
        }   
        else   
        {  
            [self launchMailAppOnDevice];  
        }  
    }   
    else   
    {  
        [self launchMailAppOnDevice];  
    }      
}  

-(void)displayComposerSheet   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    [mailPicker setSubject: @"Advice & Suggestions"];  
    
    NSArray *toRecipients = [NSArray arrayWithObject: @"kayeMediaMobile@gmail.com"];  
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];  
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];  
    [mailPicker setToRecipients: toRecipients];  
    //[mailPicker setCcRecipients:ccRecipients];      
    //[picker setBccRecipients:bccRecipients];     
    //UIImage *addPic = [UIImage imageNamed: @"mail_board.png"];  
    //NSData *imageData = UIImagePNGRepresentation(addPic);            // png  
    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg  
    //[mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"mail_board.png"];  
    
    //NSString *emailBody = @"This position is cool.Let's give it a whirl.";  
    //[mailPicker setMessageBody:emailBody isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
}  
-(void)launchMailAppOnDevice  
{  
    NSString *recipients = @"mailto:kayeMediaMobile@gmail.com&subject=my email!";  
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";  
    NSString *body = @"&body=email body!";  
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];  
}  
- (void)mailComposeController:(MFMailComposeViewController *)controller   
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

/*-----------------------------*/
@end
