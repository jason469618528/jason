//
//  IYBDebugView.h
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/11.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IYBDebugView : UIView

@property (nonatomic, assign, getter=isDisplay) BOOL display;

- (void)show;
- (void)dimss;

@end
