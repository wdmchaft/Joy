//
//  PasswordController_iPhone.m
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PasswordController_iPhone.h"


@implementation PasswordController_iPhone
@synthesize passwdField;
@synthesize confirmField;
@synthesize submit;
@synthesize cancel;

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
    [passwdField release];
    [confirmField release];
    [submit release];
    [cancel release];
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
    passwdField.delegate = self;
    confirmField.delegate = self;
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

- (void)sumbitPressed{
    NSString *password = passwdField.text;
    NSString *confirm = confirmField.text;
    if ([password length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail"
                                                        message:@"The password field cannot be empty"
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        if ([password isEqualToString:confirm]) {
            [[SQLData sharedSQLData] updatePasswordFlag]; 
            //NSArray *paramarray = [[NSArray alloc] initWithObjects:password, nil];
            [[SQLData sharedSQLData] updatePasswordWithString:password];    
            JoyAppDelegate *appDelegate = (JoyAppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.JOY_PASSWORD_FLAG = 0;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:nil
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail"
                                                            message:@"Password did not match!"
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)cancelPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
