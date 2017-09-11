//
//  NSMutableAttributedString+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (NBUIKit)

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)string
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color
                                               lineSpacing:(CGFloat)lineSpacing
                                                underlined:(BOOL)underlined;

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)text
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color;

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)text
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color
                                               lineSpacing:(CGFloat)lineSpacing;

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color
                                 lineSpacing: (CGFloat)lineSpacing
                                  underlined: (BOOL)underlined
                                   alignment: (NSTextAlignment)alignment;

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color;

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color
                                 lineSpacing: (CGFloat)lineSpacing
                                  underlined: (BOOL)underlined;

@end
