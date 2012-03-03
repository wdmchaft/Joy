//
//  CoverHideController_iPad.m
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverHideController_iPad.h"


@implementation CoverHideController_iPad
@synthesize navigationController;
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
    [navigationController release];
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
    JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.COVER_SLIDER_VALUE  = 22.0;
    appDelegate.COVER_SOUND_FLAG    = YES;
    if (self.tabBarItem.tag == 1) {
        CoverRootController_iPad * coverRootController =  [[CoverRootController_iPad alloc] initWithNibName:@"CoverRootController_iPad" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverRootController];
        coverRootController.tabBarFlag = 1;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverRootController release];
    }else if(self.tabBarItem.tag == 2){
        CoverCateController_iPad * coverCateController =  [[CoverCateController_iPad alloc] initWithNibName:@"CoverCateController_iPad" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverCateController];
        coverCateController.tabBarFlag = 2;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverCateController release];
    }else if(self.tabBarItem.tag == 3){
        CoverFavController_iPad * coverFavController =  [[CoverFavController_iPad alloc] initWithNibName:@"CoverFavController_iPad" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverFavController];
        coverFavController.tabBarFlag = 3;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverFavController release];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    for (UIViewController * controller in [self.navigationController viewControllers]) {
        [controller viewWillAppear:YES];
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
	return YES;
}

@end
