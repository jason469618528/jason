//
//  CustomButton.m
//  JasonBlog
//
//  Created by jason on 16/1/18.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void) dealloc
{
    NSLog(@"%@ dealloc",[self class]);
    self.clickBlock = nil;
}

/**
 *?????????
 */
- (void)drawRect:(CGRect)rect
{
    [self addTarget:self action:@selector(publicClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClickEventBlock:(void(^)())buttonClick
{
    self.clickBlock = buttonClick;
}

- (void)publicClick:(UIButton*)btn
{
    if(self.clickBlock)
    {
        self.clickBlock();
    }
}

@end
