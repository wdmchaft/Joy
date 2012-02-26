//
//  PasswordController_iPad.h
//  Sex
//
//  Created by mac on 11-11-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLData.h"
#import "Utils.h"


@interface PasswordController_iPad : UIViewController <UITextFieldDelegate>{
    UITextField *passwdField;
    UITextField *confirmField;
    UIButton *submit;
    UIButton *cancel;
}
@property (nonatomic, retain) IBOutlet UITextField *passwdField;
@property (nonatomic, retain) IBOutlet UITextField *confirmField;
@property (nonatomic, retain) IBOutlet UIButton *submit;
@property (nonatomic, retain) IBOutlet UIButton *cancel;

- (IBAction) sumbitPressed;
- (IBAction) cancelPressed;
@end
