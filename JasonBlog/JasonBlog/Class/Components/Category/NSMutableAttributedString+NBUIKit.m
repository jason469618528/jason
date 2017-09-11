//
//  NSMutableAttributedString+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NSMutableAttributedString+NBUIKit.h"

@implementation NSMutableAttributedString (NBUIKit)

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)string
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color
                                               lineSpacing:(CGFloat)lineSpacing
                                                underlined:(BOOL)underlined{
    NSString *text = string == nil ? @"" : string;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if (font) {
        [attributes setValue:font forKey:NSFontAttributeName];
    }
    if (color) {
        [attributes setValue:color forKey:NSForegroundColorAttributeName];
    }
    // 下划线
    [attributes setValue:underlined ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone) forKey:NSUnderlineStyleAttributeName];
    
    // 调整行间距
    if (lineSpacing > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode            = NSLineBreakByWordWrapping;
        paragraphStyle.alignment                = NSTextAlignmentLeft;
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc] initWithString:text
                                                                                            attributes:attributes];
    return newAttributedString;
}

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)text
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color {
    return [NSMutableAttributedString nb_attributedStringWithText:text font:font color:color lineSpacing:0 underlined:NO];
}

+ (NSMutableAttributedString *)nb_attributedStringWithText:(NSString *)text
                                                      font:(UIFont *)font
                                                     color:(UIColor *)color
                                               lineSpacing:(CGFloat)lineSpacing{
    return [NSMutableAttributedString nb_attributedStringWithText:text font:font color:color lineSpacing:lineSpacing underlined:NO];
}

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color{
    [self appendAttributedString:[NSMutableAttributedString nb_attributedStringWithText:string font:font color:color]];
    return self;
}

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color
                                 lineSpacing: (CGFloat)lineSpacing
                                  underlined: (BOOL)underlined
{
    
    return [self appendString:string font:font color:color lineSpacing:lineSpacing underlined:underlined alignment:NSTextAlignmentLeft];
}

- (NSMutableAttributedString *) appendString: (NSString *)string
                                        font: (UIFont *)font
                                       color: (UIColor *)color
                                 lineSpacing: (CGFloat)lineSpacing
                                  underlined: (BOOL)underlined
                                   alignment: (NSTextAlignment)alignment {
    if(string == nil) {
        return self;
    }
    
    NSMutableAttributedString *newAttributedString = [NSMutableAttributedString nb_attributedStringWithText:string font:font color:color lineSpacing:lineSpacing underlined:underlined];
    
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraphStyle.alignment                = alignment;
    paragraphStyle.paragraphSpacing         = 0;
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [newAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [newAttributedString length])];
    [self appendAttributedString:newAttributedString];
    return self;
}





@end
