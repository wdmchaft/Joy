//
//  CustomProgressView_iPhone.m
//  Joy
//
//  Created by mac on 12-3-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomProgressView_iPhone.h"


@implementation CustomProgressView_iPhone

- (void)drawRect:(CGRect)rect{
    CGSize backgroundStretchPoints = {4, 9}, fillStretchPoints = {3, 8};
    // Initialize the stretchable images.
    UIImage *background = [[UIImage imageNamed:@"progressbar_small.png"] stretchableImageWithLeftCapWidth:backgroundStretchPoints.width topCapHeight:backgroundStretchPoints.height];
    UIImage *fill = [[UIImage imageNamed:@"progressbar_fill_small.png"] stretchableImageWithLeftCapWidth:fillStretchPoints.width topCapHeight:fillStretchPoints.height];
    
    // Draw the background in the current rect
    [background drawInRect:rect];
    
    // Compute the max width in pixels for the fill.  Max width being how
    // wide the fill should be at 100% progress.
    NSInteger maxWidth = rect.size.width - (2 * kCustomProgressViewFillOffsetX);
    
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding 
    // to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    
    // Create the rectangle for our fill image accounting for the position offsets,
        // 1 in the X direction and 1, 3 on the top and bottom for the Y.
    CGRect fillRect = CGRectMake(rect.origin.x + kCustomProgressViewFillOffsetX,
                                 rect.origin.y + kCustomProgressViewFillOffsetTopY,
                                 curWidth,
                                 rect.size.height - kCustomProgressViewFillOffsetBottomY);
    // Draw the fill
    [fill drawInRect:fillRect];
}

@end
