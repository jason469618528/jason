//
//  NSAttributedString+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (NBUIKit)

/**
 *  返回字体所占用得尺寸
 *
 *  @param maxWidth 最大宽度
 *
 *  @return 返回合适的尺寸
 */
- (CGSize)nb_sizeWithMaxWidth:(CGFloat)maxWidth;

/**
 *  返回字体所占用得尺寸
 *
 *  @param maxWidth 最大宽度
 *  @param ignore   是否忽略单行的行间距
 *
 *  @return 返回合适的尺寸
 */
- (CGSize)nb_sizeWithMaxWidth:(CGFloat)maxWidth singleLineIgnoreSpacing:(BOOL)ignore;

/**
 *  返回一个NSAttributedString
 *
 *  @param string      字符内容
 *  @param font        字体
 *  @param color       颜色
 *  @param lineSpacing 行距，输入0时忽略
 *
 *  @return NSAttributedString
 */
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;

/**
 *  返回一个NSAttributedString
 *
 *  @param string      字符内容
 *  @param font        字体
 *  @param color       颜色
 *  @param underline   是否有下划线
 *  @param lineSpacing 行距，输入0时忽略
 *
 *  @return NSAttributedString
 */
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color underline:(BOOL)underline lineSpacing:(CGFloat)lineSpacing;

/**
 *  返回一个NSAttributedString
 *
 *  @param string      字符内容
 *  @param font        字体
 *  @param color       颜色
 *  @param strikethrough 是否有删除线
 *  @param lineSpacing 行距，输入0时忽略
 *
 *  @return NSAttributedString
 */
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color strikethrough:(BOOL)strikethrough lineSpacing:(CGFloat)lineSpacing;


/**
 *  返回一个NSAttributedString
 *
 *  @param imageName   图片名称
 *  @param bounds      图片bounds
 *
 *  @return NSAttributedString
 */
+ (instancetype)nb_attributedStringWithImageName:(NSString*)imageName bounds:(CGRect)bounds;

@end


