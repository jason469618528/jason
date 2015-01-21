//
//  MySelectGroupBuyProduct.h
//  PanliApp
//
//  Created by jason on 13-8-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyJoinGroupBuyProduct : NSObject <NSCoding>
{
    NSString *_productName;
    NSString *_productUrl;
    NSString *_thumbnail;
    float   _price;
    NSString *_remark;
    NSString *_skuRemark;
    int _buyNum;
}

/**
 *商品名称
 */
@property (nonatomic, retain) NSString *productName;

/**
 *商品url
 */
@property (nonatomic, retain) NSString *productUrl;

/**
 *缩略图
 */
@property (nonatomic, retain) NSString *thumbnail;

/**
 *价格
 */
@property (nonatomic, assign) float   price;

/**
 *备注
 */
@property (nonatomic, retain) NSString *remark;

/**
 *备注
 */
@property (nonatomic, retain) NSString *skuRemark;

/**
 *备注
 */
@property (nonatomic, assign) int buyNum;

@end
