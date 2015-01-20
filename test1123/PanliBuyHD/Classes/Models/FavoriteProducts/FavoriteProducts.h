//
//  FavoriteProducts.h
//  PanliBuyHD
//
//  Created by guo on 14-10-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteProducts : NSObject
{
    NSString *_productURL;
    NSString *_productName;
    NSString *_thumbnail;
    float _price;
    NSString *_shopName;
    NSString *_siteName;
    int _favoriteID;
    BOOL _isFavorite;
}

/**
 *  商品链接
 */
@property (nonatomic, retain) NSString *productURL;

/**
 *  商品名称
 */
@property (nonatomic, retain) NSString *productName;

/**
 *  商品缩略图
 */
@property (nonatomic, retain) NSString *thumbnail;

/**
 *  商品价格
 */
@property (nonatomic, assign) float price;

/**
 *  商品所在店铺
 */
@property (nonatomic, retain) NSString *shopName;

/**
 *  商品来源
 */
@property (nonatomic, retain) NSString *siteName;

/**
 *  商品ID
 */
@property (nonatomic, assign) int favoriteID;

/**
 *  商品关注状态
 */
@property (nonatomic, assign) BOOL isFavorite;


@end
