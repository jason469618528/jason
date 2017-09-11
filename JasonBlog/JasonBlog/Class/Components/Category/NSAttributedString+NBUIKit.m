//
//  NSAttributedString+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NSAttributedString+NBUIKit.h"

@implementation NSAttributedString (NBUIKit)

/**
 *  返回字体所占用得尺寸
 *
 *  @param maxWidth 最大宽度
 *
 *  @return 返回合适的尺寸
 */
- (CGSize)nb_sizeWithMaxWidth:(CGFloat)maxWidth {
    return [self nb_sizeWithMaxWidth:maxWidth singleLineIgnoreSpacing:NO];
}

/**
 *  返回字体所占用得尺寸
 *
 *  @param maxWidth 最大宽度
 *  @param ignore   若单行忽略其行间距
 *
 *  @return 返回合适的尺寸
 */
- (CGSize)nb_sizeWithMaxWidth:(CGFloat)maxWidth singleLineIgnoreSpacing:(BOOL)ignore {
    
    CGSize goal_size = CGSizeMake(maxWidth, 3000);
    CGRect rect = [self boundingRectWithSize:goal_size
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     context:nil];
    if (!ignore) {
        return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    }
    
    //若忽略，则需要取最大字体行高计算
    __block UIFont *font = nil;
    //去掉段落行距
    NSRange range = NSMakeRange(0, [self length]);
    [self enumerateAttribute:NSFontAttributeName inRange:range options:0 usingBlock:^(UIFont *f, NSRange range, BOOL *stop) {
        if (font && f) {
            if (font.pointSize < f.pointSize) {
                font = f;
            }
        }
        
        if (!font && f){
            font = f;
        }
    }];
    
    //简单判断单行，若行间距本身大于字高，此处有bug，暂时忽略这种情况（不符合美观设计）
    if (rect.size.height > font.lineHeight && rect.size.height < 2*font.lineHeight) {
        rect.size.height = font.lineHeight;
    }
    
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}


+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color underline:(BOOL)underline strikethrough:(BOOL)strikethrough lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] initWithCapacity:3];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:color forKey:NSForegroundColorAttributeName];
    
    if (underline) {
        [attributes setValue:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
    }
    
    if (strikethrough) {//默认就给细线，如果需要可以修改成NSUnderlineStyleThick
        [attributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    }
    
    if (lineSpacing > 0.0f) {
        //调整行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.paragraphSpacing = 0;
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    return [[[self class] alloc] initWithString:string attributes:attributes];
}

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
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing {
    return [self nb_attributedStringWithString:string font:font color:color underline:NO strikethrough:NO lineSpacing:lineSpacing];
}

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
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color underline:(BOOL)underline lineSpacing:(CGFloat)lineSpacing {
    return [self nb_attributedStringWithString:string font:font color:color underline:underline strikethrough:NO lineSpacing:lineSpacing];
}

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
+ (instancetype)nb_attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color strikethrough:(BOOL)strikethrough lineSpacing:(CGFloat)lineSpacing {
    return [self nb_attributedStringWithString:string font:font color:color underline:NO strikethrough:strikethrough lineSpacing:lineSpacing];
}

/**
 *  返回一个NSAttributedString
 *
 *  @param imageName   图片名称
 *  @param bounds      图片bounds
 *
 *  @return NSAttributedString
 */
+ (instancetype)nb_attributedStringWithImageName:(NSString*)imageName bounds:(CGRect)bounds {
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"];
    attach.image = [UIImage imageWithContentsOfFile:filePath];
    attach.bounds = bounds;
    return [NSAttributedString attributedStringWithAttachment:attach];
}

@end
