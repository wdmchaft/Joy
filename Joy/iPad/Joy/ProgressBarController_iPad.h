//
//  ProgressBarController_iPad.h
//  Joy
//
//  Created by mac on 12-3-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SQLData.h"
#import "CustomProgressView_iPad.h"

@interface ProgressBarController_iPad : UIViewController {
    NSArray                 *   category;
}
- (void)initLabelAndProgressBar;
- (NSString *)levelOfSexLife:(NSInteger)levelNum;
@end
