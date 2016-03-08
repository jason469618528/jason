//
//  CustomViewTest.m
//  JasonBlog
//
//  Created by jason on 16/3/4.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "CustomViewTest.h"

@implementation CustomViewTest


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(60.56, 38.78)];
    [bezierPath addCurveToPoint: CGPointMake(60.56, 38.78) controlPoint1: CGPointMake(49.28, 37.5) controlPoint2: CGPointMake(58.09, 38.26)];
    [bezierPath addCurveToPoint: CGPointMake(75.08, 44.43) controlPoint1: CGPointMake(66.18, 39.97) controlPoint2: CGPointMake(70.99, 41.93)];
    [bezierPath addCurveToPoint: CGPointMake(98.52, 100.5) controlPoint1: CGPointMake(101.9, 60.79) controlPoint2: CGPointMake(98.52, 100.5)];
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}


@end
