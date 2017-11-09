//
//  UIViewController+CoolUIKit.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/8/30.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "UIViewController+CoolUIKit.h"

@implementation UIViewController (CoolUIKit)

- (void)easyPushWithClass:(Class)controller {
    if([self.parentViewController isKindOfClass:[UINavigationController class]] && self.navigationController && [controller isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:[[controller alloc] init] animated:YES];
    }
}
@end
