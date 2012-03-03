//
//  ItemShowController_iPhone.m
//  Sex
//
//  Created by mac on 11-11-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ItemShowController_iPhone.h"


@implementation ItemShowController_iPhone
@synthesize itemScrollView;
@synthesize startFlag;
@synthesize content;
@synthesize imageArray;
@synthesize sexImages;
@synthesize timer;
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
    for (UIView * view in [itemScrollView subviews]) {
        [view removeFromSuperview];
    }
    for (UIView * view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    [Utils stopSoundPlayer:tapPlayer];
    [imageArray release];
    [itemScrollView release];
    [sexImages release];
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPhone]]];
    UILabel * leftLabel     = nil;
    UILabel * rightLabel    = nil;
    JoyAppDelegate * appDelegate    = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.DATABASE_NAME isEqualToString:DATABASE_CH]) {
        leftLabel = [Utils addLabelToView:CGRectMake(20, 10, 100, 20) :0 :@"挑战性" :12.0];
        rightLabel = [Utils addLabelToView:CGRectMake(200, 10, 100, 20) :0 :@"趣味性" :12.0];
    }else{
        leftLabel = [Utils addLabelToView:CGRectMake(20, 10, 100, 20) :0 :@"Pleasure" :12.0];
        rightLabel = [Utils addLabelToView:CGRectMake(200, 10, 100, 20) :0 :@"Challenge" :12.0];
    }
    didReceivedIdFlag = NO;
    [self.view addSubview:leftLabel];
    [leftLabel release];
    [self.view addSubview:rightLabel];
    [rightLabel release];
    iFlag = 0;
    sexImages = [[NSMutableArray alloc] initWithCapacity:1000];
    imageArray = [[NSMutableArray alloc] initWithCapacity:4];    
    
    if (startFlag == 1000 ) {
        content = [[NSMutableArray alloc] initWithCapacity:10];
        NSArray * randomContent = nil;
        /*
         *If custom has already purchased this product, running getSelectUnDoneInfoList Part;
         *else running getSelectUnDoneInfoListWithoutPurchase.
         */
        BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
        if(isProUpgradePurchased == NO){
            randomContent = [[SQLData sharedSQLData] getSelectUnDoneInfoListWithoutPurchase];
        }else{
            randomContent = [[SQLData sharedSQLData] getSelectAllInfoListWithoutPurchase];
        }
        for (int i = 0; i < 30; i++) {
            [content addObject:[randomContent objectAtIndex:arc4random()%[randomContent count]]];
        }
        startFlag = 0;
    }
    [self initSexImages];
    [self initLittleStartImageViewWithoutImage];
    [self initScrollView];
    [self initTextViewAndButton];
    
    UIImageView *initImageView = (UIImageView *)[self.itemScrollView viewWithTag:100+startFlag];    
    initImageView.image = [self findImage:startFlag];    
    [itemScrollView setContentOffset:CGPointMake(320*startFlag, 0) animated:NO];
    [self starShow];
    [self textViewTextShow];
    [self startPlayAnimation];
    [self buttonImageShow];
    BOOL isProUpgradePurchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"];
    if(isProUpgradePurchased == NO){
        [self addAdWhirlAds];
        NSTimer * shouldSelfBoardShow = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                                         target: self
                                                                       selector: @selector(shouldSelfBoardShowTimer:)
                                                                       userInfo: nil
                                                                        repeats: NO];
    }    
}

/*
 *Last three method is used for adwhirl
 */

- (void)addAdWhirlAds{
    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    adWhirlView.frame = CGRectMake(0, 385, 320, 50);
    adWhirlView.delegate = self;  
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
- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView { 
    didReceivedIdFlag = YES;
} 

- (void) shouldSelfBoardShowTimer: (NSTimer *) adTimer{
    if (didReceivedIdFlag == NO) {
        UIButton * boardButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(0, 385, 320, 50) :0 :[UIImage imageNamed:@"showboard_iphone_ch"] :[UIImage imageNamed:@"showboard_iphone_ch"]];
        [boardButton addTarget:self action:@selector(boardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:boardButton];
    }
}

- (void)boardButtonPressed{
    [[UIApplication sharedApplication] 
     openURL:[NSURL URLWithString:SELF_AD_URL]];
}
/*
 *
 */

- (void) initSexImages{
    sexImages = [[[SQLData sharedSQLData] getSelectImageInfoList] retain]; 
}

- (void) initLittleStartImageViewWithoutImage{
    for (int i = 0; i < 5; ++i) {
        UIImageView *starImageView = [Utils addImageViewToViewWithoutImage:CGRectMake(20+20*i, 30, 20, 20) :10 + i];
        [self.view addSubview:starImageView];
        [starImageView release];
    }
    for (int j = 0;j < 5; ++j) {
        UIImageView *starImageView = [Utils addImageViewToViewWithoutImage:CGRectMake(200+20*j, 30, 20, 20) :15 + j];
        [self.view addSubview:starImageView];
        [starImageView release];
    }
}

- (void) initScrollView{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, appDelegate.SCROLLVIEW_HEIGHT, 320, appDelegate.SCROLLVIEW_HEIGHT_F)];
    for (int i = 0; i < [content count]; ++i) {
        UIImageView *imageView = [Utils addImageViewToViewWithoutImage:CGRectMake(40+320*i, 0, 240, 240) :100+i];
        [itemScrollView addSubview:imageView];
        [imageView release];
    }        
    itemScrollView.contentSize = CGSizeMake(320*[content count], appDelegate.SCROLLVIEW_HEIGHT_F); 
    itemScrollView.showsVerticalScrollIndicator = NO;  
    itemScrollView.showsHorizontalScrollIndicator = NO;  
    itemScrollView.userInteractionEnabled = YES;  
    itemScrollView.pagingEnabled = YES;
    itemScrollView.delegate = self;
    [self.view addSubview:itemScrollView];
}

- (void) initTextViewAndButton{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImageView *backImage = [Utils addImageViewToView:CGRectMake(0, appDelegate.IMAGEVIEW_HEIGHT, 320, 150) :50 :[UIImage imageNamed:@"scrolldetail.png"]];
    [self.view addSubview:backImage];
    [backImage release];
    textView = [Utils addTextViewToView:CGRectMake(20, appDelegate.TEXTVIEW_HEIGHT, 280, 90) :0 :13.0 :[UIColor clearColor] :[UIColor blackColor]];
    [self.view addSubview:textView];
    [textView release];
    triedButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(0, appDelegate.BUTTONVIEW_HEIGHT, 100, 40) :0 :[UIImage imageNamed:@"check.png"]:[UIImage imageNamed:@"check.png"]];
    [triedButton addTarget:self action:@selector(triedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:triedButton];
    starButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(110, appDelegate.BUTTONVIEW_HEIGHT, 100, 40) :0 :[UIImage imageNamed:@"star.png"]:[UIImage imageNamed:@"star.png"]];
    [starButton addTarget:self action:@selector(starButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starButton];
    todoButton = [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(220, appDelegate.BUTTONVIEW_HEIGHT, 100, 40) :0 :[UIImage imageNamed:@"todo.png"]:[UIImage imageNamed:@"todo.png"]];
    [todoButton addTarget:self action:@selector(todoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todoButton];
    
    UILabel *triedLabel = [Utils addButtonLabelToView:CGRectMake(0,appDelegate.BUTTONVIEW_HEIGHT,60,40) :0 :@"已尝试" :15.0 :[UIColor yellowColor]];
    [self.view addSubview:triedLabel];
    [triedLabel release];
    
    UILabel *starLabel = [Utils addButtonLabelToView:CGRectMake(110, appDelegate.BUTTONVIEW_HEIGHT, 60, 40) :0 :@"喜欢" :15.0 :[UIColor yellowColor]];
    [self.view addSubview:starLabel];
    [starLabel release];
    
    UILabel *todoLabel = [Utils addButtonLabelToView:CGRectMake(220, appDelegate.BUTTONVIEW_HEIGHT, 60, 40) :0 :@"待尝试" :15.0 :[UIColor yellowColor]];
    [self.view addSubview:todoLabel];
    [todoLabel release];
}

- (void)triedButtonPressed:(id)triedSender{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3" :1];
        [tapPlayer play];
    }
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    if (triedButton.tag == 0) {
        [self updateParamarray:UpdateDoneOne];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:8 withObject:@"1"];
        [triedButton setBackgroundImage:[UIImage imageNamed:ButtonChecked] forState:UIControlStateNormal];
        triedButton.tag = 1;
    }else{
        [self updateParamarray:UpdateDoneZero];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:8 withObject:@"0"];
        [triedButton setBackgroundImage:[UIImage imageNamed:ButtonCheck] forState:UIControlStateNormal];
        triedButton.tag = 0;
        
    }
    //[self buttonImageShow];
}

- (void)starButtonPressed:(id)starSender{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3" :1];
        [tapPlayer play];
    }
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    if (starButton.tag == 0) {
        [self updateParamarray:UpdateFavOne];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:7 withObject:@"1"];
        [starButton setBackgroundImage:[UIImage imageNamed:ButtonStared] forState:UIControlStateNormal];
        starButton.tag = 1;
    }else{
        [self updateParamarray:UpdateFavZero];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:7 withObject:@"0"];
        [starButton setBackgroundImage:[UIImage imageNamed:ButtonStar] forState:UIControlStateNormal];
        starButton.tag = 0;
    }
    //[self buttonImageShow];
}

- (void)todoButtonPressed:(id)todoSender{
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger soundFlag = appDelegate.JOY_SOUND_FLAG;
    if (soundFlag == 1) {
        [Utils stopSoundPlayer:tapPlayer];
        tapPlayer = [Utils initSoundPlayer:@"tap.mp3" :1];
        [tapPlayer play];
    }
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    if (todoButton.tag == 0) {
        [self updateParamarray:UpdateTodoOne];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:9 withObject:@"1"];
        [todoButton setBackgroundImage:[UIImage imageNamed:ButtonTodoed] forState:UIControlStateNormal];
        todoButton.tag = 1;
    }else{
        [self updateParamarray:UpdateTodoZero];
        [[content objectAtIndex:currentpage] replaceObjectAtIndex:9 withObject:@"0"];
        [todoButton setBackgroundImage:[UIImage imageNamed:ButtonTodo] forState:UIControlStateNormal];
        todoButton.tag = 0;
    }
    //[self buttonImageShow];
}

- (void)updateParamarray:(NSString *)sqlString{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    NSString *indexnum = [[content objectAtIndex:currentpage] objectAtIndex:0];    
    [[SQLData sharedSQLData] updateParamarrayWithSqlString:sqlString withIndex:indexnum];
    //[paramarray release];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    self.title = [[content objectAtIndex:currentPage] objectAtIndex:2];
    for (NSInteger i = 0; i < [content count]; i++) {
        if (i != currentPage) {
            UIImageView *otherImageView = (UIImageView *)[self.itemScrollView viewWithTag:100+i];
            otherImageView.image = nil;
        }
    }
    UIImageView *currentView = (UIImageView *)[self.itemScrollView viewWithTag:100+currentPage];
    if (currentView.image == nil) {        
        currentView.image = [self findImage:currentPage];
    }
    if ([timer isValid]) {
        [timer invalidate];
    }
    [self starShow];
    [self textViewTextShow];
    [self buttonImageShow];
    [self startPlayAnimation];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    if (currentPage <= 0) {
        UIImageView *nextImageView = (UIImageView *)[self.itemScrollView viewWithTag:101];        
        nextImageView.image = [self findImage:currentPage+1];        
    } else if (currentPage >= [content count]-1) {
        UIImageView *lastImageView = (UIImageView *)[self.itemScrollView viewWithTag:(98+[content count])];
        lastImageView.image = [self findImage:currentPage-1];
    } else {
        UIImageView *lastImageView = (UIImageView *)[self.itemScrollView viewWithTag:100+currentPage-1];
        lastImageView.image = [self findImage:currentPage-1];
        UIImageView *nextImageView = (UIImageView *)[self.itemScrollView viewWithTag:100+currentPage+1];
        nextImageView.image = [self findImage:currentPage+1];
    }
}

- (void) starShow{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    for (int i = 0; i < 10; i++) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i+10];        
        imageView.image = nil;        
    }    
    for (int i = 0; i < [[[content objectAtIndex:currentpage] objectAtIndex:5] intValue]; ++i) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i+10];
        imageView.image = [UIImage imageNamed:LevelStar];
    }
    for (int i = 0; i < [[[content objectAtIndex:currentpage] objectAtIndex:6] intValue]; ++i) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i+15];
        imageView.image = [UIImage imageNamed:LevelStar];
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
- (UIImage *)findImage:(NSInteger)index{
    NSInteger pose_id = [[[content objectAtIndex:index] objectAtIndex:0] intValue];

    NSString *idInfo = [[NSString alloc] initWithFormat:@"%d",pose_id];
    NSString *sql = [SelectImageInfo stringByAppendingString:idInfo]; 
	imageArray = [[sqliteOperation selectData:sql resultColumns:3] retain];    
    [idInfo release]; 
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[[imageArray objectAtIndex:0] objectAtIndex:2] ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}*/

- (UIImage *)findImage:(NSInteger)index{
    [imageArray removeAllObjects];
    NSInteger pose_id = [[[content objectAtIndex:index] objectAtIndex:0] intValue];    
    for (int i = 0; i < 3; ++i) {
        [imageArray addObject:[sexImages objectAtIndex:(pose_id-1)*3+i]];        
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:[[imageArray objectAtIndex:0] objectAtIndex:2] ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

- (void) textViewTextShow{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    textView.text = [[content objectAtIndex:currentpage] objectAtIndex:4];
}

- (void) buttonImageShow{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    NSInteger FavButtonNum = [[[content objectAtIndex:currentpage] objectAtIndex:7] intValue];
    if (FavButtonNum == 0) {
        [starButton setBackgroundImage:[UIImage imageNamed:ButtonStar] forState:UIControlStateNormal];
        starButton.tag = 0;
    }else{
        [starButton setBackgroundImage:[UIImage imageNamed:ButtonStared] forState:UIControlStateNormal];
        starButton.tag = 1;
    }
    NSInteger triedButtonNum =  [[[content objectAtIndex:currentpage] objectAtIndex:8] intValue];
    if (triedButtonNum == 0) {
        [triedButton setBackgroundImage:[UIImage imageNamed:ButtonCheck] forState:UIControlStateNormal];
        triedButton.tag = 0;
    }else{
        [triedButton setBackgroundImage:[UIImage imageNamed:ButtonChecked] forState:UIControlStateNormal];
        triedButton.tag = 1;
    }

    NSInteger todoButtonNum = [[[content objectAtIndex:currentpage] objectAtIndex:9] intValue];
    if (todoButtonNum == 0) {
        [todoButton setBackgroundImage:[UIImage imageNamed:ButtonTodo] forState:UIControlStateNormal];
        todoButton.tag = 0;
    }else{
        [todoButton setBackgroundImage:[UIImage imageNamed:ButtonTodoed] forState:UIControlStateNormal];
        todoButton.tag = 1;
    }
}

- (void) startPlayAnimation{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    [self findImage:currentpage];
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.4
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
}

- (void) handleTimer: (NSTimer *) timer{
    NSInteger currentpage = (NSInteger)(self.itemScrollView.contentOffset.x/320);
    UIImageView *imageView = (UIImageView *)[self.itemScrollView viewWithTag:100+currentpage];
    imageView.image = nil;  
    
    NSString *PicFilePath = [[NSBundle mainBundle] pathForResource:[[imageArray objectAtIndex:iFlag] objectAtIndex:2] ofType:nil];
    if (iFlag < 2) {
        iFlag++;
    }else{
        iFlag = 0;
    }
    imageView.image = [UIImage imageWithContentsOfFile:PicFilePath]; 
    if ([self retainCount] == 2) {
        [self.timer invalidate];
    }
}

@end
