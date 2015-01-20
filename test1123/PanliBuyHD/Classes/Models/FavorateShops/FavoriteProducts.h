//
//  Favorite.h
//  PanliApp
//
//  Created by jason on 13-6-5.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteProducts : NSObject
{
    NSString *_productUrl;
    NSString *_productName;
    NSString *_thumbnail;
    float _price;
    NSString *_shopName;
    NSString *_siteName;
    int _favoriteID;
    BOOL _isFavorite;
}


/**
 *商品链接
 */
@property (nonatomic, retain) NSString * productUrl;

/**
 *商品名称
 */
@property (nonatomic, retain) NSString * productName;

/**
 *商品图片
 */
@property (nonatomic, retain) NSString * thumbnail;

/**
 *价格
 */
@property (nonatomic, assign) float  price;

/**
 *商品所在店铺
 */
@property (nonatomic, retain) NSString * shopName;

/**
 *来源
 */
@property (nonatomic, retain)  NSString * siteName;

/**
 *商品ID
 */
@property (nonatomic, assign) int  favoriteID;

/**
 *商品关注状态
 */
@property (nonatomic, assign) BOOL isFavorite;

@end
