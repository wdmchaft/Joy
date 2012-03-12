//
//  ShareViewController_iPhone.m
//  Joy
//
//  Created by mac on 12-3-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController_iPhone.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"

@implementation ShareViewController_iPhone
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
        
  
        
		self.toolbarItems = [NSArray arrayWithObjects:
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)] autorelease],
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							 nil
							 ];
	}
    self.navigationController.delegate = self;
	return self;
}



- (void)loadView 
{
	[super loadView];
	
	//self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sanFran.jpg"]];
	
	imageView.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-40);
	
	[self.view addSubview:imageView];
	
	[imageView release];
    
    if ([UserDefaultKeySet judgeNetworkReachability] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"当前网络未连接，无法初始化分享，请检查你的网络连接。" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)share
{
	SHKItem *item = [SHKItem image:imageView.image title:@"我觉得这个姿势不错，今天尝试下。更多姿势，尽在性趣。"];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
}

- (void)dealloc
{

    [imageView release];
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

@end
