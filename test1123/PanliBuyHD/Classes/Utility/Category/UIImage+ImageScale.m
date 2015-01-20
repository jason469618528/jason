//
//  UIImage+ImageScale.m
//  PanliApp
//
//  Created by Liubin on 14-3-28.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "UIImage+ImageScale.h"

@implementation UIImage (ImageScale)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

//等比例缩放
-(UIImage*)scaleWithRadioSize:(CGSize)size
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    float verticalRadio = size.height/height;
    float horizontalRadio = size.width/width;
    float radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
    
    width = width*radio;
    height = height*radio;
    
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0.0f, 0.0f, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//将图片等比缩放到屏幕宽度
-(UIImage*)scaleToFullWidthSize
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    float radio = 1.0f;
    if (width > 640)
    {
        radio = 640/width;
    }
    else
    {
        radio = width/640;
    }
    width = width*radio;
    height = height*radio;
    CGSize size = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0.0f, 0.0f, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;

}

//按固定尺寸缩放
-(UIImage*)scaleToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

//压缩一半
- (UIImage *)imageCompressed
{
    CGFloat width = self.size.width/2;
    CGFloat height = self.size.height/2;
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0.0f, 0.0f, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
