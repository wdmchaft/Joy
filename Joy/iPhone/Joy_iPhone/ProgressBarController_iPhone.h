//
//  ProgressBarController_iPhone.h
//  Joy
//
//  Created by mac on 12-3-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SQLData.h"
#import "CustomProgressView_iPhone.h"


@interface ProgressBarController_iPhone : UIViewController {
    NSArray                 *   category;
}
- (void)initLabelAndProgressBar;
- (NSString *)levelOfSexLife:(NSInteger)levelNum;
@end
