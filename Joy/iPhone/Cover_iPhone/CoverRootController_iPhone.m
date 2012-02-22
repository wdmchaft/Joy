//
//  CoverRootController_iPhone.m
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverRootController_iPhone.h"


@implementation CoverRootController_iPhone
@synthesize jokeList;
@synthesize catesFlag;
@synthesize scrollView;
@synthesize tabBarFlag;

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
    [jokeList release];
    [scrollView release];
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    UIImageView * topbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    topbarView.image = [UIImage imageNamed:@"topbar.png"];
    [self.view addSubview:topbarView];
    [topbarView release];
    
    //Init buttons on topBarView
    UIButton * moreButton = [Utils addButtonToView: UIButtonTypeCustom:CGRectMake(10, -5, 60, 60) :1 :[UIImage imageNamed:@"3ight_pressed"] :nil];
    [moreButton addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreButton];
    UIButton * setButton  = [Utils addButtonToView: UIButtonTypeCustom:CGRectMake(90, -5, 60, 60) :1 :[UIImage imageNamed:@"settings_pressed"] :nil];
    [setButton addTarget:self action:@selector(setButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    UIButton * mailButton = [Utils addButtonToView: UIButtonTypeCustom:CGRectMake(170, -5, 60, 60) :1 :[UIImage imageNamed:@"mail_pressed"] :nil];
    [mailButton addTarget:self action:@selector(mailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];
    UIButton * favButton = [Utils addButtonToView: UIButtonTypeCustom:CGRectMake(250, -5, 60, 60) :1 :[UIImage imageNamed:@"favorite_pressed"] :nil];
    [favButton addTarget:self action:@selector(favButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:favButton];

    /*
     *when tabBarItem.tag == 2 && tabBarItem.tag == 3, the content of jokeList was given by father controller
     *when tabBarItem.tag == 1, the jokeList need to init
     *
    switch (self.tabBarItem.tag) {
        case 1:   
            jokeList = [[SQLData sharedSQLData] getCoverAllContentList];
            CLog(@"the count of this part is %d", [jokeList count]);
            break;
        case 2:
            jokeList = [[SQLData sharedSQLData] getCoverPartContentList:[[SQLData sharedSQLData] getCoverCateStringFromArray:cateFlag]];
            break;
        case 3:
            jokeList = [[SQLData sharedSQLData] getCoverFavoriteContentList];
            break;
        default:
            break;
    }*/
    if (tabBarFlag == 1) {
        jokeList    =   [[SQLData sharedSQLData] getCoverAllContentList];
    }
        
    [self initScrollView];
    [self addImageViewToScrllView:COVER_SHOW_INTERVAL];
    [self addTextViewToScrollView:0];
    [self addLabelToScrollView:COVER_SHOW_INTERVAL*3];
    
    //if tabBarItem.tag == 2 && tabBarItem.tag == 3, init a backButton
    if (tabBarFlag == 2 || tabBarFlag == 3) {
        UIButton * button   =   [Utils addButtonToView:UIButtonTypeCustom :CGRectMake(130, 360, 60, 60) :0 :[UIImage imageNamed:@"back_button_pressed.png"] :nil];
        [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    CLog(@"%d", self.tabBarItem.tag);
}


- (void) initScrollView{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 360)];
    scrollView.contentSize                      =   CGSizeMake(320*[jokeList count],300);     
    scrollView.showsVerticalScrollIndicator     =   NO;  
    scrollView.showsHorizontalScrollIndicator   =   NO;  
    scrollView.userInteractionEnabled           =   YES;  
    scrollView.pagingEnabled                    =   YES;
    scrollView.delegate                         =   self;
    //[self addTextView:startFlag];
    [self.view addSubview:scrollView];
}
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    /* judge which favorite button image should appear
     if ([[[jokeContent objectAtIndex:currentPage] objectAtIndex:2] intValue] == 0) {
     [favButton setBackgroundImage:[UIImage imageNamed:@"jokestar.png"] forState:UIControlStateNormal];
     }else{
     [favButton setBackgroundImage:[UIImage imageNamed:@"jokestaryel.png"] forState:UIControlStateNormal];
     }*/
    [self changeImageViewContent];
    [self changeTextViewContent];  
    [self changeLabelContent];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    
      
}

- (void) changeTextViewContent{
    NSInteger currentPage = (NSInteger)(self.scrollView.contentOffset.x/320);
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
    NSInteger currentPage   = (NSInteger)(self.scrollView.contentOffset.x/320);
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
    NSInteger currentPage   = (NSInteger)(self.scrollView.contentOffset.x/320);
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)moreButtonPressed{
    
}

- (void)setButtonPressed{

}

- (void)mailButtonPressed{

}

- (void)favButtonPressed{

}

- (void)backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) addImageViewToScrllView : (NSInteger)index{
    NSString * path         =   [[NSBundle mainBundle] pathForResource:@"whiteBox" ofType:@"png"];
    UIImage * image         =   [UIImage imageWithContentsOfFile:path];
    UIImageView * imageView =   [Utils addImageViewToView:CGRectMake(20+320*(index - COVER_SHOW_INTERVAL), 30, 280, 300) :image :index :0.6];
    [scrollView addSubview:imageView];
    [imageView release]; 
    
    NSString * path_tab         =   [[NSBundle mainBundle] pathForResource:@"categorytab" ofType:@"png"];
    UIImage * image_tab         =   [UIImage imageWithContentsOfFile:path_tab];
    UIImageView * imageView_tab =   [Utils addImageViewToView:CGRectMake(40+320*(index - COVER_SHOW_INTERVAL), 30, 240, 50) :image_tab :index + COVER_SHOW_INTERVAL :1.0];
    [scrollView addSubview:imageView_tab];
    [imageView_tab release]; 
    CLog(@"imageView retaincount is %d",[imageView retainCount]);
}

- (void) addTextViewToScrollView : (NSInteger)index{
    UITextView * textView = [Utils addTextViewToView:CGRectMake(40+320*index, 80, 240, 200):index :[UIColor clearColor] :[[jokeList objectAtIndex:index] objectAtIndex:1] :NO :YES :YES :[UIFont boldSystemFontOfSize:15] :[UIColor blackColor]];
    [scrollView addSubview:textView];
    [textView release];
    CLog(@"textview retaincount is %d",[textView retainCount]);
}

- (void) addLabelToScrollView : (NSInteger)index{
    UILabel * label = [Utils addLabelToView:CGRectMake(40+320*(index - COVER_SHOW_INTERVAL*3), 25, 240, 50) :index :[UIColor clearColor] :[[jokeList objectAtIndex:(index - COVER_SHOW_INTERVAL*3)] objectAtIndex:2] :UITextAlignmentCenter :[UIColor whiteColor]:nil];
    [scrollView addSubview:label];
    [label release];
    CLog(@"label retaincount is %d",[label retainCount]);
}
@end
