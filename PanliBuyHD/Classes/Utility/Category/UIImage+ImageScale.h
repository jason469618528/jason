//
//  UIImage+ImageScale.h
//  PanliApp
//
//  Created by Liubin on 14-3-28.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleWithRadioSize:(CGSize)size;
-(UIImage*)scaleToFullWidthSize;
-(UIImage*)scaleToSize:(CGSize)newSize;
- (UIImage *)imageCompressed;
@end
