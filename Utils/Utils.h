//
//  Utils.h
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//COVER_SHOW_INTERVAL define the tag gap of the control target in scrollView 
#define COVER_SHOW_INTERVAL 20000

@interface Utils : NSObject {
    
}
//public method to init a Button
+ (UIButton *)      addButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage;
//public method to init a label
+ (UILabel *)       addLabelToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(UITextAlignment)alignment:(UIColor *)textColor:(UIFont *)font;
//public method to init a textView
+ (UITextView *)    addTextViewToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(BOOL)editable:(BOOL)scrollEnable:(BOOL)endEditing:(UIFont *)font:(UIColor *)textColor;
//public method to init a imageView
+ (UIImageView *)   addImageViewToView:(CGRect)frameSize:(UIImage *)image:(NSInteger)tag:(CGFloat)alpha;
@end
