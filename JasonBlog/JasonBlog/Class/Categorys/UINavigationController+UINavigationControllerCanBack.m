//
//  UINavigationController+UINavigationControllerCanBack.m
//  JasonBlog
//
//  Created by jason on 16/1/8.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "UINavigationController+UINavigationControllerCanBack.h"

@implementation UINavigationController (UINavigationControllerCanBack)

- (void)isCanBack:(BOOL)canBack
{
    CustomerNavgaionController *nav = (CustomerNavgaionController*)self;
    nav.canBack = canBack;
}

@end
