//
//  Product.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 商品信息
 * 创 建 人: Jason
 * 创建日期: 2013-04-15
 **************************************************/

@interface Product : NSObject
{
    NSString *_productName;
    NSString *_productUrl;
    float  _freight;
    NSString *_image;
    NSString *_thumbnail;
    float _price;
    NSString *_description;
    int _proId;
}


/**
 *商品名称
 */
@property (nonatomic, strong) NSString *productName;

/**
 *商品原链接
 */
@property (nonatomic, strong) NSString *productUrl;

/**
 *国内运费
 */
@property(nonatomic,unsafe_unretained) float  freight;

/**
 *商品大图
 */
@property (nonatomic, strong) NSString *image;

/**
 *商品缩略图
 */
@property (nonatomic, strong) NSString *thumbnail;

/**
 *商品价格
 */
@property (nonatomic,unsafe_unretained) float  price;

/**
 *商品描述
 */
@property (nonatomic, strong) NSString *description;

/**
 *商品id
 */
@property (nonatomic, unsafe_unretained) int proId;



@end
