//
//  SnatchProducts.h
//  PanliApp
//
//  Created by jason on 13-6-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopDetail.h"
#import "SiteModel.h"
@interface SnatchProducts : NSObject
{
    NSString *_productName;
    NSString *_productUrl;
    NSString *_thumbnail;
    ShopDetail *_shopInfo;
    SiteModel *_site;
    NSMutableArray *_skus;
    NSMutableArray *_skuCombinations;    
    NSMutableArray *_pictureArray;
    float  _price;
    float _freight;
    float _vipDiscount;
    NSString *_mark;
    float _promotionPrice;
    NSString *_promotionExpried;
}

/**
 *商品名称
 */
@property (nonatomic, strong)  NSString *productName;

/**
 *商品url
 */
@property (nonatomic, strong)  NSString *productUrl;


/**
 *缩略图
 */
@property (nonatomic, strong)  NSString *thumbnail;


/**
 *店铺信息
 */
@property (nonatomic, strong)  ShopDetail *shopInfo;


/**
 *站点信息
 */
@property (nonatomic, strong)  SiteModel *site;

/**
 *商品sku
 */
@property (nonatomic, strong)  NSMutableArray *skus;

/**
 *sku组合
 */
@property (nonatomic, strong)  NSMutableArray *skuCombinations;



/**
 *商品图片
 */
@property (nonatomic, strong)  NSMutableArray *pictureArray;

/**
 *商品价格
 */
@property (nonatomic, unsafe_unretained)  float price;


/**
 *国内邮费
 */
@property (nonatomic, unsafe_unretained)  float freight;

/**
 *用户折扣
 */
@property (nonatomic, unsafe_unretained)  float vipDiscount;



/**
 *用于标记缓存
 */
@property (nonatomic, strong)  NSString *mark;


/**
 *促销价
 */
@property (nonatomic, unsafe_unretained) float  promotionPrice;

/**
 *促销价过期时间
 */
@property (nonatomic, strong) NSString * promotionExpried;

- (id)initWithDictionary:(NSDictionary *)iDictionary;
@end
