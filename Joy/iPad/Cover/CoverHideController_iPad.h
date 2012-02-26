//
//  CoverHideController_iPad.h
//  Joy
//
//  Created by mac on 12-2-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoyAppDelegate.h"
#import "CoverRootController_iPad.h"
#import "CoverCateController_iPad.h"
#import "CoverFavController_iPad.h"

@interface CoverHideController_iPad : UIViewController <UINavigationControllerDelegate>{
    UINavigationController  *   navigationController;
}
@property (nonatomic, retain) UINavigationController *navigationController;
@end
