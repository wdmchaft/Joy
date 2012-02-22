//
//  CoverHideController_iPhone.m
//  Joy
//
//  Created by mac on 12-2-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverHideController_iPhone.h"


@implementation CoverHideController_iPhone
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
    // Do any additional setup after loading the view from its nib.
    if (self.tabBarItem.tag == 1) {
        CoverRootController_iPhone * coverRootController_iphone =  [[CoverRootController_iPhone alloc] initWithNibName:@"CoverRootController_iPhone" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverRootController_iphone];
        coverRootController_iphone.tabBarFlag = 1;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverRootController_iphone release];
    }else if(self.tabBarItem.tag == 2){
        CoverCateController_iPhone * coverCateController_iphone =  [[CoverCateController_iPhone alloc] initWithNibName:@"CoverCateController_iPhone" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverCateController_iphone];
        coverCateController_iphone.tabBarFlag = 2;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverCateController_iphone release];
    }else if(self.tabBarItem.tag == 3){
        CoverFavController_iPhone * coverFavController_iphone =  [[CoverFavController_iPhone alloc] initWithNibName:@"CoverFavController_iPhone" bundle:nil];
        navigationController    =   [[UINavigationController alloc] initWithRootViewController:coverFavController_iphone];
        coverFavController_iphone.tabBarFlag = 3;
        [navigationController.view setFrame:[self.view bounds]];
        navigationController.navigationBarHidden = YES;
        [self.view addSubview:navigationController.view];
        navigationController.delegate = self;
        [coverFavController_iphone release];
    }

    /*
    switch (self.tabBarItem.tag) {
        case 1:   
            CoverRootController_iPhone * coverRootController_iphone =  [[CoverRootController_iPhone alloc] initWithNibName:@"CoverRootController_iPhone" bundle:nil];
            //navigationController = [[UINavigationController alloc] initWithRootViewController:coverRootController];
            break;
        case 2:
            CoverRootController_iPhone * coverRootController_iphone =  [[CoverRootController_iPhone alloc] initWithNibName:@"CoverRootController_iPhone" bundle:nil];
            break;
        case 3:
            CoverRootController_iPhone * coverRootController_iphone =  [[CoverRootController_iPhone alloc] initWithNibName:@"CoverRootController_iPhone" bundle:nil];
            break;
        default:
            break;
    }*/
    
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
