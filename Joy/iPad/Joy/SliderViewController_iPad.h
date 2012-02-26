//
//  SliderViewController_iPad.h
//  Sex
//
//  Created by mac on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
#import "SQLiteOperation.h"
#import "ItemViewController_iPad.h"

@interface SliderViewController_iPad : UIViewController {
    UISlider * pleasureSlider;
    UISlider * challengeSlider;
    NSMutableArray * content;
}
@property (nonatomic, retain) UISlider * pleasureSlider;
@property (nonatomic, retain) UISlider * challengeSlider;
@property (nonatomic, retain) NSArray * content;
@end
