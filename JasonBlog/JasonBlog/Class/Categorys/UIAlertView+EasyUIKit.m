//
//  UIAlertView+EasyUIKit.m
//  JasonBlog
//
//  Created by huangjian on 16/12/12.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "UIAlertView+EasyUIKit.h"
#import <objc/runtime.h>

static char kHandlerKey;

@interface UIAlertView ()

@end

@implementation UIAlertView (EasyUIKit)

+ (void)showConfirmWithTitle:(NSString*)title message:(NSString*)messate clickComplete:(UIAlertViewComplete)clickComplete{
    UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:title message:messate delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [_alertView showAlertWithComplete:clickComplete];
}


- (void)showAlertWithComplete:(UIAlertViewComplete)clickComplete{
    objc_setAssociatedObject(self, &kHandlerKey, clickComplete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:self];
    [self show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIAlertViewComplete completionHandler = nil;
    completionHandler = objc_getAssociatedObject(self, &kHandlerKey);
    if (completionHandler != nil) {
        completionHandler(alertView, buttonIndex);
    }
}
@end

