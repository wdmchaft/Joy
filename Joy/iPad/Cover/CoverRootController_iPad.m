//
//  CoverRootController_iPad.m
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverRootController_iPad.h"


@implementation CoverRootController_iPad
@synthesize jokeList;
@synthesize catesFlag;
@synthesize scrollView;
@synthesize tabBarFlag;
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
    for (UIView * view in [scrollView subviews]) {
        [view removeFromSuperview];
    }
    for (UIView * view in [self.view subviews]) {
        [view removeFromSuperview];
    }
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
    self.view.backgroundColor   = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_ipad.jpg"]];
    UIImageView * topbarView    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 120)];
    topbarView.image            = [UIImage imageNamed:@"topbar_ipad.png"];
    [self.view addSubview:topbarView];
    [topbarView release];
    
    if (tabBarFlag == 1) {
        self.navigationController.delegate = self;
    }
    
    
    //Init buttons on topBarView
    UIButton * moreButton = [Utils addCoverButtonToView: UIButtonTypeCustom:CGRectMake(79, -5, 100, 100) :COVER_SHOW_INTERVAL-1 :[UIImage imageNamed:@"3ight_pressed_ipad"] :nil];
    [moreButton addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreButton];
    /*
     *if tabBarItem.tag == 2 || tabBarItem.tag == 3, init a backButton
     *if tabBarItem.tag == 1 init a setButton
     *when tabBarItem == 2  || tabBarItem.tag == 3, we can not init a setButton because the delegate set 
     *make controller crash
     */
    if (tabBarFlag == 1) {
        UIButton * setButton  = [Utils addCoverButtonToView: UIButtonTypeCustom:CGRectMake(249, -5, 100, 100) :COVER_SHOW_INTERVAL-1 :[UIImage imageNamed:@"settings_pressed_ipad"] :nil];
        [setButton addTarget:self action:@selector(setButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:setButton];
    }else{
        UIButton * button   =   [Utils addCoverButtonToView:UIButtonTypeCustom :CGRectMake(419, -5, 100, 100) :COVER_SHOW_INTERVAL-1 :[UIImage imageNamed:@"back_button_pressed@2x.png"] :nil];
        [button addTarget:self action:@selector(rootBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIButton * mailButton = [Utils addCoverButtonToView: UIButtonTypeCustom:CGRectMake(419, -5, 100, 100) :COVER_SHOW_INTERVAL-1 :[UIImage imageNamed:@"mail_pressed@2x"] :nil];
    [mailButton addTarget:self action:@selector(mailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];
    favButton = [Utils addCoverButtonToView: UIButtonTypeCustom:CGRectMake(589, -5, 100, 100) :COVER_SHOW_INTERVAL-1 :[UIImage imageNamed:@"no_favorite_pressed@2x"] :nil];
    if ([[[jokeList objectAtIndex:0] objectAtIndex:3] intValue] == 0) {
        [favButton setBackgroundImage:[UIImage imageNamed:@"no_favorite_pressed@2x"] forState:UIControlStateNormal];
    }else{
        [favButton setBackgroundImage:[UIImage imageNamed:@"favorite_pressed@2x"] forState:UIControlStateNormal];
    } 
    [favButton addTarget:self action:@selector(favButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:favButton];
    
    /*
     *when tabBarItem.tag == 2 && tabBarItem.tag == 3, the content of jokeList was given by father controller
     *when tabBarItem.tag == 1, the jokeList need to init
     *
     */
    if (tabBarFlag == 1) {
        jokeList    =   [[SQLData sharedSQLData] getCoverAllContentList];
    }
    
    [self initScrollView];
    [self addImageViewToScrllView:COVER_SHOW_INTERVAL];
    [self addTextViewToScrollView:0];
    [self addLabelToScrollView:COVER_SHOW_INTERVAL*3];
}

- (void)viewWillAppear:(BOOL)animated{
    JoyAppDelegate * appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSInteger i = 0; i < [jokeList count]; i++) {
        UITextView * textView = (UITextView *)[self.scrollView viewWithTag:i];
        if (textView != nil && [textView isKindOfClass:[UITextView class]]) {
            textView.font = [UIFont boldSystemFontOfSize:appDelegate.COVER_SLIDER_VALUE];
        }        
    }
}

- (void)navigationController:(UINavigationController *)navigationController   
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated   
{  
    [viewController viewWillAppear:animated];  
}

- (void) initScrollView{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 768, 700)];
    scrollView.contentSize                      =   CGSizeMake(760*[jokeList count],700);     
    scrollView.showsVerticalScrollIndicator     =   NO;  
    scrollView.showsHorizontalScrollIndicator   =   NO;  
    scrollView.userInteractionEnabled           =   YES;  
    scrollView.pagingEnabled                    =   YES;
    scrollView.delegate                         =   self;
    scrollView.tag                              =   (COVER_SHOW_INTERVAL-1);
    //[self addTextView:startFlag];
    [self.view addSubview:scrollView];
    [scrollView release];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{    
    [self changeImageViewContent];
    [self changeTextViewContent];  
    [self changeLabelContent];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //judge which favorite button image should appear
    NSInteger currentPage = (NSInteger)(self.scrollView.contentOffset.x/768);
    if ([[[jokeList objectAtIndex:currentPage] objectAtIndex:3] intValue] == 0) {
        [favButton setBackgroundImage:[UIImage imageNamed:@"no_favorite_pressed.png"] forState:UIControlStateNormal];
    }else{
        [favButton setBackgroundImage:[UIImage imageNamed:@"favorite_pressed.png"] forState:UIControlStateNormal];
    } 
}

- (void) changeTextViewContent{
    NSInteger currentPage = (NSInteger)(self.scrollView.contentOffset.x/768);
    UITextView * textView = (UITextView *)[self.scrollView viewWithTag:currentPage];
    if (textView == nil) {
        [self addTextViewToScrollView:currentPage];
    }
    if (currentPage <= 0) {
        UITextView *textView = (UITextView *)[self.scrollView viewWithTag:1];
        if (textView == nil) {
            [self addTextViewToScrollView:1];
        }
    }else if (currentPage >= [jokeList count]-1){
        UITextView *textView = (UITextView *)[self.scrollView viewWithTag:[jokeList count]-2];
        if (textView == nil) {
            [self addTextViewToScrollView:[jokeList count]-2];
        }
    }else{
        UITextView *nexttextView = (UITextView *)[self.scrollView viewWithTag:currentPage+1];
        if (nexttextView == nil) {
            [self addTextViewToScrollView:currentPage+1];
        }
        UITextView *lasttextView = (UITextView *)[self.scrollView viewWithTag:currentPage-1];
        if (lasttextView == nil) {
            [self addTextViewToScrollView:currentPage+1];
        }
    }
}

- (void) changeImageViewContent{
    NSInteger currentPage   = (NSInteger)(self.scrollView.contentOffset.x/768);
    UIImageView * imageView = (UIImageView *)[self.scrollView viewWithTag:currentPage + COVER_SHOW_INTERVAL];
    CLog(@"currentpage %d", currentPage);
    if (imageView == nil) {
        [self addImageViewToScrllView:currentPage + COVER_SHOW_INTERVAL];
    }
    if (currentPage <= 0) {
        UIImageView * imageView = (UIImageView *)[self.scrollView viewWithTag:1 + COVER_SHOW_INTERVAL];
        if (imageView == nil) {
            [self addImageViewToScrllView:1 + COVER_SHOW_INTERVAL];
        }
    }else if(currentPage >= [jokeList count] - 1 ){
        UIImageView * imageView = (UIImageView *)[self.scrollView viewWithTag:[jokeList count]-2 + COVER_SHOW_INTERVAL];
        if (imageView == nil) {
            [self addImageViewToScrllView:[jokeList count]-2 + COVER_SHOW_INTERVAL];
        }
    }else{
        UIImageView * nextImageView = (UIImageView *)[self.scrollView viewWithTag:currentPage+1 + COVER_SHOW_INTERVAL];
        if (nextImageView == nil) {
            [self addImageViewToScrllView:currentPage+1 + COVER_SHOW_INTERVAL];
        }
        UIImageView * lastImageView = (UIImageView *)[self.scrollView viewWithTag:currentPage-1 + COVER_SHOW_INTERVAL];
        if (lastImageView == nil) {
            [self addImageViewToScrllView:currentPage-1 + COVER_SHOW_INTERVAL];
        }
    }
}

- (void) changeLabelContent{
    NSInteger currentPage   = (NSInteger)(self.scrollView.contentOffset.x/768);
    UILabel * label         = (UILabel *)[self.scrollView viewWithTag:currentPage + COVER_SHOW_INTERVAL*3];
    CLog(@"currentpage %d", currentPage);
    if (label == nil) {
        [self addLabelToScrollView:currentPage + COVER_SHOW_INTERVAL*3];
    }
    if (currentPage <= 0) {
        UILabel * label = (UILabel *)[self.scrollView viewWithTag:1 + COVER_SHOW_INTERVAL*3];
        if (label == nil) {
            [self addLabelToScrollView:1 + COVER_SHOW_INTERVAL*3];
        }
    }else if(currentPage >= [jokeList count] - 1 ){
        UILabel * label = (UILabel *)[self.scrollView viewWithTag:[jokeList count]-2 + COVER_SHOW_INTERVAL*3];
        if (label == nil) {
            [self addLabelToScrollView:[jokeList count]-2 + COVER_SHOW_INTERVAL*3];
        }
    }else{
        UILabel * nextLabel = (UILabel *)[self.scrollView viewWithTag:currentPage+1 + COVER_SHOW_INTERVAL*3];
        if (nextLabel == nil) {
            [self addLabelToScrollView:currentPage+1 + COVER_SHOW_INTERVAL*3];
        }
        UILabel * lastLabel = (UILabel *)[self.scrollView viewWithTag:currentPage-1 + COVER_SHOW_INTERVAL*3];
        if (lastLabel == nil) {
            [self addLabelToScrollView:currentPage-1 + COVER_SHOW_INTERVAL*3];
        }
    }
}

- (void)moreButtonPressed{
    [self audioPlayerPlay];
    MoreJokeController_iPhone * moreJokeController = [[MoreJokeController_iPhone alloc] initWithNibName:@"MoreJokeController_iPhone" bundle:nil];
    CATransition * tran = [CATransition animation];
    tran.duration = .4f;
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromTop; //Bottom for the opposite direction
    tran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    tran.removedOnCompletion  = YES;
    [self.navigationController.view.layer addAnimation:tran forKey:@"TransitionDownUp"];    
    [self.navigationController pushViewController:moreJokeController animated:NO];
    [moreJokeController release];
}

- (void)setButtonPressed{
    [self audioPlayerPlay];
    SettingController_iPhone * settingController = [[SettingController_iPhone alloc] initWithNibName:@"SettingController_iPhone" bundle:nil];
    CATransition *animation = [CATransition animation];  
    animation.delegate = self;   
    animation.duration = 0.5f;   
    animation.timingFunction = UIViewAnimationCurveEaseInOut;  
    animation.fillMode = kCAFillModeForwards;  
    animation.removedOnCompletion = NO;  
    animation.type = @"oglFlip";
    animation.subtype = @"fromRight";
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:settingController animated:NO];
    [settingController release];
}

- (void)mailButtonPressed{
    [self audioPlayerPlay];
    [self sendEMail];
}

- (void)favButtonPressed:(id)favSender{
    [self audioPlayerPlay];
    NSInteger currentpage = (NSInteger)(self.scrollView.contentOffset.x/768);
    if ([[[jokeList objectAtIndex:currentpage] objectAtIndex:3] intValue] == 0) {
        if ([[SQLData sharedSQLData] setCoverFavoriteFlag:[[jokeList objectAtIndex:currentpage] objectAtIndex:0] :@"1"]) {
            [[jokeList objectAtIndex:currentpage] replaceObjectAtIndex:3 withObject:@"1"];
            [favButton setBackgroundImage:[UIImage imageNamed:@"favorite_pressed@2x"] forState:UIControlStateNormal];
        }       
    }else{
        if ([[SQLData sharedSQLData] setCoverFavoriteFlag:[[jokeList objectAtIndex:currentpage] objectAtIndex:0] :@"0"]) {
            [[jokeList objectAtIndex:currentpage] replaceObjectAtIndex:3 withObject:@"0"];
            [favButton setBackgroundImage:[UIImage imageNamed:@"no_favorite_pressed@2x"] forState:UIControlStateNormal];
        }       
    }
}

- (void)rootBackButtonPressed{
    [self audioPlayerPlay];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addImageViewToScrllView : (NSInteger)index{
    NSString * path         =   [[NSBundle mainBundle] pathForResource:@"whitebox_ipad" ofType:@"png"];
    UIImage * image         =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView =   [Utils addCoverImageViewToView:CGRectMake(54+768*(index - COVER_SHOW_INTERVAL), 50, 660, 800) :image :index :0.6];
    [scrollView addSubview:imageView];
    [imageView release]; 
    
    NSString * path_tab         =   [[NSBundle mainBundle] pathForResource:@"categorybar_ipad" ofType:@"png"];
    UIImage * image_tab         =   [UIImage imageWithContentsOfFile:path_tab];
    UIImageView * imageView_tab =   [Utils addCoverImageViewToView:CGRectMake(134+768*(index - COVER_SHOW_INTERVAL), 60, 500, 80) :image_tab :index + COVER_SHOW_INTERVAL :1.0];
    [scrollView addSubview:imageView_tab];
    [imageView_tab release]; 
    CLog(@"imageView retaincount is %d",[imageView retainCount]);
}

- (void) addTextViewToScrollView : (NSInteger)index{
    JoyAppDelegate * appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    UITextView * textView = [Utils addCoverTextViewToView:CGRectMake(84+768*index, 130, 600, 600):index :[UIColor clearColor] :[[jokeList objectAtIndex:index] objectAtIndex:1] :NO :YES :YES :[UIFont boldSystemFontOfSize:appDelegate.COVER_SLIDER_VALUE] :[UIColor blackColor]];
    [scrollView addSubview:textView];
    [textView release];
    CLog(@"textview retaincount is %d",textView.tag);
}

- (void) addLabelToScrollView : (NSInteger)index{
    UILabel * label = [Utils addCoverLabelToView:CGRectMake(184+768*(index - COVER_SHOW_INTERVAL*3), 50, 400, 80) :index :[UIColor clearColor] :[[jokeList objectAtIndex:(index - COVER_SHOW_INTERVAL*3)] objectAtIndex:2] :UITextAlignmentCenter :[UIColor whiteColor]:nil];
    label.font = [UIFont boldSystemFontOfSize:24.0];
    [scrollView addSubview:label];
    [label release];
    CLog(@"label retaincount is %d",[label retainCount]);
}

- (void) audioPlayerPlay{
    if ([Utils ifSoundPlayerCouldPlay] == YES) {
        audioPlayer = [Utils addCoverAVAudioPlayer:audioPlayer];
        [audioPlayer play];
    }
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

/*
 *The last four method is for email
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
- (void) sendEMail   
{  
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

- (void) displayComposerSheet   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    [mailPicker setSubject: @"Have Fun"];  
    NSInteger currentpage = (NSInteger)(self.scrollView.contentOffset.x/768);
    
    NSString *emailBody = [[jokeList objectAtIndex:currentpage] objectAtIndex:1];  
    [mailPicker setMessageBody:emailBody isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
}  
- (void) launchMailAppOnDevice  
{  
    NSString *recipients = @"mailto:&subject=my email!";  
    
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
