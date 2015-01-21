//
//  ShipReview.h
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipReview : NSObject <NSCoding>

{
    NSString * _userId;
    NSString * _generalRate;
    NSString * _receiveRate;
    NSString * _deliveryRate;
    NSString * _customerRate;
    NSString * _content;
    NSString * _shipID;
}

/**
 *用户ID
 */
@property (nonatomic, retain) NSString * userId;

/**
 *整体情况
 */
@property (nonatomic, retain) NSString * generalRate;

/**
 *收货情况
 */
@property (nonatomic, retain) NSString * receiveRate;

/**
 *配送速度
 */
@property (nonatomic, retain) NSString * deliveryRate;

/**
 *客户效率
 */
@property (nonatomic, retain) NSString * customerRate;

/**
 *内容
 */
@property (nonatomic, retain) NSString * content;

/**
 *运单ID
 */
@property (nonatomic, retain) NSString * shipID;

@end
