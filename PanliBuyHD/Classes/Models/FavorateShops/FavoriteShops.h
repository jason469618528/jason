//
//  FavoriteShop.h
//  PanliApp
//
//  Created by jason on 13-6-5.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteShops : NSObject

{
    NSString *_shopUrl;
    NSString *_shopName;
    NSString *_keeperName;
    int _credit;
    NSString *_logo;
    NSString *_instruction;
    float _positiveRatio;
    int _favoriteID;
    BOOL _isFavorite;
    NSString *_siteName;
}



/**
 *店铺链接
 */
@property (nonatomic, retain) NSString * shopUrl;

/**
 *店铺名字
 */
@property (nonatomic, retain) NSString * shopName;

/**
 *店铺掌柜
 */
@property (nonatomic, retain) NSString * keeperName;

/**
 *店铺信誉度
 */
@property (nonatomic, assign)  int credit;

/**
 *店铺介绍
 */
@property (nonatomic, retain)   NSString * instruction;

/**
 *店铺图片
 */
@property (nonatomic, retain)  NSString *logo;

/**
 *店铺图片
 */
@property (nonatomic, assign)  float positiveRatio;

/**
 *店铺ID
 */
@property (nonatomic, assign) int  favoriteID;

/**
 *商品状态(是否关注)
 */
@property (nonatomic, assign) BOOL isFavorite;

/**
 *来源
 */
@property (nonatomic, retain) NSString * siteName;
@end
