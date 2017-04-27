//
//  UIView+HJDrawCornet.m
//  JSPatch_demo
//
//  Created by huangjian on 17/2/23.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIView+HJDrawCornet.h"

@implementation UIView (HJDrawCornet)

/**
 *addCornet
 */
- (void)hj_AddCornet:(CGFloat)radius {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self hj_drawRectWithRoundedCornet:radius]];
    [self insertSubview:imageView atIndex:0];
}



- (UIImage*)hj_drawRectWithRoundedCornet:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 40,40);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, 10, 10, -10, -10, radius);  // 这种类型的代码重复四次
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end
