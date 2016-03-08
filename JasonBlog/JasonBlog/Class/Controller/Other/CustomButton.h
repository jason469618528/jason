//
//  CustomButton.h
//  JasonBlog
//
//  Created by jason on 16/1/18.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EventBlock)();

@interface CustomButton : UIButton

- (void)btnClickEventBlock:(void(^)())buttonClick;

@property(nonatomic, copy) EventBlock clickBlock;

@end
