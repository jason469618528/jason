//
//  Coupon.h
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject <NSCoding>

{
    int _userCouponId;
    NSString * _code;
    NSString * _name;
    float _denomination;
    BOOL _isActivated;
    BOOL _givable;
    BOOL _tradable;
    NSString * _dateCreated;
    NSString * _deadlineForActivation;
    
    NSString *  _userId;
    CouponStatus _status;
    
    BOOL _isSelect;
    
    MyCouponSourceState _couponSource;
}

/**
 *UserCouponI用户优惠券ID
 */
@property(nonatomic,assign)int userCouponId;

/**
 *优惠券编号
 */
@property (nonatomic, retain)  NSString * code;

/**
 *优惠券名称
 */
@property (nonatomic, retain) NSString * name;

/**
 *面额
 */
@property(nonatomic,assign)float denomination;

/**
 *是否已激活
 */
@property(nonatomic,assign) BOOL isActivated;

/**
 *可否送人
 */
@property(nonatomic,assign) BOOL givable;

/**
 *可否买卖
 */
@property(nonatomic,assign)BOOL tradable;

/**
 *生成时间
 */
@property (nonatomic, retain)  NSString * dateCreated;

/**
 *过期时间
 */
@property (nonatomic, retain) NSString * deadlineForActivation;

/**
 *用户ID
 */
@property (nonatomic, retain) NSString *  userId;

/**
 *状态 0-未激活 1-待使用 2-已使用 4-过期的，5-失效的 6-一个月内即将过期的
 */
@property(nonatomic,assign)CouponStatus status;

/**
 *判断是否已经选中
 */
@property (nonatomic, assign) BOOL isSelect;

/**
 *来源
 */
@property (nonatomic, assign) MyCouponSourceState couponSource;
@end
