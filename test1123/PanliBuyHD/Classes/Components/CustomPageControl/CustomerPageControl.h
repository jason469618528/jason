//
//  CustomerPageControl.h
//  GuideDemo
//
//  Created by liubin on 13-4-17.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

/**************************************************
 * 内容描述: 自定义页码图片的PageControl
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-17
 **************************************************/
@interface CustomerPageControl : UIPageControl
{
    //选中状态图片
    NSString *_selectedImage;
    
    //未选中状态图片
    NSString *_unSelectedImage;
    
    //选中状态颜色
    UIColor *_selectColor;
    
    //未选中状态颜色
    UIColor *_unSelectColor;
    
}

@property (nonatomic, retain) UIColor * selectColor;

@property (nonatomic, retain) UIColor * unSelectColor;

@property (nonatomic, retain) NSString *selectedImage;

@property (nonatomic, retain) NSString *unSelectedImage;

- (id)initWithFrame:(CGRect)frame selectImage:(NSString *)selectImage unSelectImage:(NSString *) unSelectImage selectColor:(UIColor*)selectColor unSelectColor:(UIColor*)unSelectColor;

@end
