//
//  CoverHideController_iPhone.h
//  Joy
//
//  Created by mac on 12-2-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverRootController_iPhone.h"
#import "CoverCateController_iPhone.h"
#import "CoverFavController_iPhone.h"


@interface CoverHideController_iPhone : UIViewController <UINavigationControllerDelegate>{
    UINavigationController  *   navigationController;
}
@property (nonatomic, retain) UINavigationController *navigationController;
@end
