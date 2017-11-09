//
//  UIViewController+IYBSharkDebug.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/11.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "UIViewController+IYBSharkDebug.h"
#import "IYBDebugView.h"
#import <objc/runtime.h>

static NSString *kIYBDebugViewFlag = @"kIYBDebugViewFlag";

@interface UIViewController ()
@property (nonatomic, strong) IYBDebugView *iybDebugView;
@end

@implementation UIViewController (IYBSharkDebug)



- (BOOL)canBecomeFirstResponder {
    return YES;// default is NO
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    return;
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    return;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        NSLog(@"摇动结束");
        if(self.iybDebugView.isDisplay) {
            [self.iybDebugView show];
        } else {
            [self.iybDebugView dimss];
        }
    }
    return;
}

#pragma mark - getter && setter
- (IYBDebugView*)iybDebugView {
    IYBDebugView *iybDebugView = objc_getAssociatedObject(self, &kIYBDebugViewFlag);
    if(!iybDebugView) {
        iybDebugView = [[IYBDebugView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 150.f)];
        iybDebugView.backgroundColor = J_COLOR_RED;
        objc_setAssociatedObject(self, &kIYBDebugViewFlag, iybDebugView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return iybDebugView;
}

@end
