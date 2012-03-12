//
//  ProgressBarController_iPhone.m
//  Joy
//
//  Created by mac on 12-3-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProgressBarController_iPhone.h"


@implementation ProgressBarController_iPhone

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
    [category release];
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPhone]];    
    category = [[SQLData sharedSQLData] getCategoryFlagList];
    [self initLabelAndProgressBar];
    
    UILabel * leftLabel     = [Utils addLabelToView:CGRectMake(10, 15, 80, 30) :10 :@"性爱学徒" :15.0];
    [leftLabel setTextColor:[UIColor yellowColor]];
    [self.view addSubview:leftLabel];
    [leftLabel release];
    
    UILabel * rightLabel    = [Utils addLabelToView:CGRectMake(220, 15, 80, 30) :11 :@"性爱大师" :15.0];
    [rightLabel setTextColor:[UIColor yellowColor]];
    [self.view addSubview:rightLabel];
    [rightLabel release];
    
    NSString *aStr          = @"%";
    NSString * strNum       = [NSString stringWithFormat:@"%d",[[SQLData sharedSQLData] getSelectTriedSumNum]*100/291];
    UILabel * midLabel      = [Utils addLabelToView:CGRectMake(130, 10, 60, 30) :12 : [strNum stringByAppendingString:aStr]:18.0];
    [midLabel setTextColor:[UIColor yellowColor]];
    [self.view addSubview:midLabel];
    [midLabel release];
    
    CustomProgressView_iPhone * customProgress = [[CustomProgressView_iPhone alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [customProgress setProgress:[[SQLData sharedSQLData] getSelectTriedSumNum]/291.0];
    [self.view addSubview:customProgress];
    [customProgress release];
    
    
    UILabel * bottomLabel_f = [Utils addLabelToView:CGRectMake(30, 395, 100, 35) :0 :@"您的性爱等级为" :13.0];
    bottomLabel_f.textColor = [UIColor yellowColor];
    [self.view addSubview:bottomLabel_f];
    [bottomLabel_f  release];
    
    UILabel * bottomLabel_s = [Utils addLabelToView:CGRectMake(120, 385, 100, 50) :0 :[self levelOfSexLife:[strNum intValue]] :20.0];
    bottomLabel_s.textColor = [UIColor redColor];
    [self.view addSubview:bottomLabel_s];
    [bottomLabel_s release];
}

- (void)initLabelAndProgressBar{
    for (int i = 0; i < [category count]; ++i) {
        UILabel * label = [Utils addLabelToView:CGRectMake(10, 80+35*i, 60, 30) : i:[[category objectAtIndex:i] objectAtIndex:1] :12.0];
        [label setTextColor:[UIColor yellowColor]];
        [self.view addSubview:label];
        [label release];
        CustomProgressView_iPhone * customProgress = [[CustomProgressView_iPhone alloc] initWithFrame:CGRectMake(75, 85+35*i, 240, 20)];
        [self.view addSubview:customProgress];
        [customProgress setProgress:[[SQLData sharedSQLData] getSelectTriedNumOfParts:[[category objectAtIndex:i]objectAtIndex:0]]/[[[category objectAtIndex:i] objectAtIndex:4] floatValue]];
        [customProgress release];
        /*
        for (int j = 0; j < 12; ++j) {
            UIImageView * imageView     = [Utils addImageViewToViewWithoutImage:CGRectMake(75+20*j,85+35*i , 20, 20) :i];
            imageView.backgroundColor   = [UIColor redColor];
            [self.view addSubview:imageView];
            [imageView release];
        } 
         */
    }
}

- (NSString *)levelOfSexLife:(NSInteger)levelNum{
    NSString * string = nil;
    switch (levelNum/10) {
        case 0:
            string = @"新手";
            break;
        case 1:
            string = @"学徒";
            break;
        case 2:
            string = @"见习生";
            break;
        case 3:
            string = @"见习生";
            break;
        case 4:
            string = @"熟手";
            break;
        case 5:
            string = @"熟手";
            break;
        case 6:
            string = @"专家";
            break;
        case 7:
            string = @"专家";
            break;
        case 8:
            string = @"大师";
            break;
        case 9:
            string = @"大师";
            break;
        case 10:
            string = @"一代宗师";
            break;
        default:
            break;
    }
    return string;
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
