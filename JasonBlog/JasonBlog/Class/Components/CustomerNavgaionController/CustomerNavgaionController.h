//
//  CustomerViewController.h
//  JasonBlog
//
//  Created by jason on 15-5-13.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerNavgaionController : UINavigationController<UINavigationControllerDelegate>
/**
 *是否启动侧滑
 */
@property(nonatomic, assign) BOOL canBack;

@end
