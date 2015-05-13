//
//  UIImage+UIImageScale.h
//  JasonBlog
//
//  Created by jason on 15-5-13.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
@end
