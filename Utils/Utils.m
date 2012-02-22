//
//  Utils.m
//  Joy
//
//  Created by wordsworth on 12-2-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils
+ (UIButton *) addButtonToView:(id)buttonType:(CGRect)frameSize:(NSInteger)tag:(UIImage *)upImage:(UIImage *)downImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = frameSize;
    button.tag       = tag;
    [button setBackgroundImage:upImage forState:UIControlStateNormal];
    [button setBackgroundImage:downImage forState:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)  addLabelToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(UITextAlignment)alignment:(UIColor *)textColor:(UIFont *)font{
    UILabel * label         =   [[UILabel alloc] initWithFrame:frameSize];
    label.backgroundColor   =   bgcolor;
    label.text              =   text;
    label.tag               =   tag;
    label.textAlignment     =   alignment;
    label.textColor         =   textColor;
    label.font              =   font;
    return label;
}

+ (UITextView *)    addTextViewToView:(CGRect)frameSize:(NSInteger)tag:(UIColor *)bgcolor:(NSString *)text:(BOOL)editable:(BOOL)scrollEnable:(BOOL)endEditing:(UIFont *)font:(UIColor *)textColor{
    UITextView * textView       =   [[UITextView alloc] initWithFrame:frameSize];
    textView.text               =   text;
    textView.editable           =   editable;
    textView.scrollEnabled      =   scrollEnable;
    textView.tag                =   tag;
    textView.font               =   font;
    textView.backgroundColor    =   bgcolor;
    textView.textColor          =   textColor;
    [textView endEditing:endEditing];
    return textView;
}

+ (UIImageView *)   addImageViewToView:(CGRect)frameSize:(UIImage *)image:(NSInteger)tag:(CGFloat)alpha{
    UIImageView * imageView     =   [[UIImageView alloc] initWithFrame:frameSize];
    imageView.image             =   image;
    imageView.tag               =   tag;
    imageView.alpha             =   alpha;
    return imageView;
}

@end
