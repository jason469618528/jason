//
//  BaseProduct.h
//  PanliApp
//
//  Created by Liubin on 13-8-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseProduct : NSObject<NSCoding>
{
    NSString *_productName;
    NSString *_productUrl;
    NSString *_thumbnail;
    float _price;
    float _pictureHeight;
    float _pictureWHRatio;
    
    
}

/**
 *商品名称
 */
@property (nonatomic, retain) NSString *productName;

/**
 *商品原链接
 */
@property (nonatomic, retain) NSString *productUrl;

/**
 *商品缩略图
 */
@property (nonatomic, retain) NSString *thumbnail;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;

/**
 *商品价格
 */
@property (nonatomic, assign) float price;

/**
 *商品图片显示高度
 */
@property (nonatomic, assign) float pictureHeight;

/**
 *图片宽高比例
 */
@property (nonatomic, assign) float pictureWHRatio;

@end
