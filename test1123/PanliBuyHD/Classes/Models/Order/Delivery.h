//
//  Delivery.h
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coupon.h"

@interface Delivery : NSObject <NSCoding>

{
    int _deliveryId;
    NSMutableArray * _shipItems;
    NSString * _deliveryName;
    NSString * _deliveryDate;
    int _shipSendType;
    float _totalProductPrice;
    float _custodyPrice;
    float _servicePrice;
    float _shipPrice;
    float _originalServicePrice;
    float _originalShipPrice;
    float _enterPrice;
    
    float _weight;
    BOOL _isVWeight;
    BOOL _isLightOverweight;
    BOOL _isHeavyOverweight;
    BOOL _isForbidden;
    
    Coupon *_selectedCoupon;
   
}

/**
 *物流方式Id
 */
@property(nonatomic,assign)int deliveryId;

/**
 *配送的商品项
 */
@property (nonatomic, retain) NSMutableArray *  shipItems;

/**
 *物流公司名字
 */
@property (nonatomic, retain) NSString *  deliveryName;

/**
 *物流预估时间
 */
@property (nonatomic, retain) NSString *  deliveryDate;

/**
 *匹配运送方式的sendtype编号
 */
@property(nonatomic,assign)int shipSendType;

/**
 *商品总价
 */
@property(nonatomic,assign) float totalProductPrice;

/**
 *保管费
 */
@property(nonatomic,assign)float custodyPrice;

/**
 *服务费
 */
@property(nonatomic,assign) float servicePrice;

/**
 *运费（不包括报关费,所以在前台显示的时候需要加上报关费）
 */
@property(nonatomic,assign)float shipPrice;

/**
 *原服务费(不打折价格)
 */
@property (nonatomic, assign) float originalServicePrice;

/**
 *原运费(不包括报关费)
 */
@property (nonatomic, assign) float originalShipPrice;

/**
 *报关费
 */
@property(nonatomic,assign)float enterPrice;

/**
 *总重量
 */
@property(nonatomic,assign)float weight;

/**
 *获取或设置是否计算体积重量
 */
@property(nonatomic,assign)BOOL isVWeight;

/**
 *是否轻抛
 */
@property(nonatomic,assign)BOOL isLightOverweight;

/**
 *是否重抛
 */
@property(nonatomic,assign)BOOL isHeavyOverweight;

/**
 *是否敏感物品
 */
@property(nonatomic,assign)BOOL isForbidden;


/**
 *选中的优惠券
 */
@property(nonatomic,retain) Coupon *selectedCoupon;

@end
