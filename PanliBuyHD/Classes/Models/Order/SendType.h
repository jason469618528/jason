//
//  SendType.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendType : NSObject

{
    int _deliveryId;
    NSString *_time;
    NSString *_deliveryName;
    float _entryPrice;
    float _productPrice;
    float _shipPrice;
    float _sumPrice;
}
/**
 *运送方式id
 */
@property (nonatomic, assign) int  deliveryId;

/**
 *花费时间
 */
@property (nonatomic, retain) NSString *  time;

/**
 *运送方式名称
 */
@property (nonatomic, retain) NSString *  deliveryName;

/**
 *报关费
 */
@property (nonatomic, assign) float  entryPrice;

/**
 *商品费
 */
@property (nonatomic, assign) float  productPrice;

/**
 *运费
 */
@property (nonatomic, assign) float  shipPrice;

/**
 *总费用 
 */
@property (nonatomic, assign) float  sumPrice;


@end
