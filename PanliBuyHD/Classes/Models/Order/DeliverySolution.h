//
//  DeliverySolution.h
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliverySolution : NSObject <NSCoding>

{
    NSString * _deliveryGourpId;
    NSMutableArray * _shipItems;
    BOOL _isHidden;
    float _totalShipPrice;
    float _totalServicePrice;
    float _totalCustodyPrice;
    BOOL _hasForbidden;
    BOOL _hasOverWeight;
    int _orderValue;
    NSMutableArray * _deliveryInfo;
}

/**
 *deliverygourpid
 */
@property (nonatomic, retain) NSString * deliveryGourpId;

/**
 *运送商品集合
 */
@property (nonatomic, retain) NSMutableArray * shipItems;

/**
 *是否隐藏
 */
@property(nonatomic,assign)BOOL isHidden;

/**
 *总运输费(含报关费)
 */
@property(nonatomic,assign)float totalShipPrice;

/**
 *总服务费
 */
@property(nonatomic,assign)float totalServicePrice;

/**
 *总保管费
 */
@property(nonatomic,assign) float totalCustodyPrice;

/**
 *含违禁品
 */
@property(nonatomic,assign) BOOL hasForbidden;

/**
 *含重抛物品
 */
@property(nonatomic,assign) BOOL hasOverWeight;

/**
 *获取排序值 DHL＞Panli专线＞EMS＞AIR小包
 */
@property(nonatomic,assign) int orderValue;

/**
 *国际物流信息集合
 */
@property (nonatomic, retain) NSMutableArray * deliveryInfo;

@end
