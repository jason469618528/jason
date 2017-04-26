//
//  UIAlertView+EasyUIKit.h
//  JasonBlog
//
//  Created by huangjian on 16/12/12.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewComplete)(UIAlertView *alertView, NSInteger buttonTag);

@interface UIAlertView (EasyUIKit)

+ (void)showConfirmWithTitle:(NSString*)title message:(NSString*)messate clickComplete:(UIAlertViewComplete)clickComplete;

@end
