//
//  MoreJokeController_iPhone.h
//  Joy
//
//  Created by mac on 12-2-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>
#import "Utils.h"


@interface MoreJokeController_iPhone : UIViewController {
    AVAudioPlayer   *   audioPlayer;
}

@property (nonatomic, retain)   AVAudioPlayer   *   audioPlayer;
- (void) initThreeButtons;
- (void) initThreeImages;
- (void) initThreLabels;
- (void) audioPlayerPlay;
@end
