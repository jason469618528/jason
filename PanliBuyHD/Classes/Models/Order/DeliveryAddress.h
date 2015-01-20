//
//  DeliveryAddress.h
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliveryAddress : NSObject <NSCoding>

{
    int _deliveryAddressId;
    NSString *  _userId;
    NSString *  _consignee;
    NSString *  _zip;
    NSString *  _telephone;
    NSString *  _country;
    NSString *  _city;
    NSString *  _address;
    NSString *  _dAddtime;
    int _nCountryID;
    
    NSString * _keepPacking;
    NSString * _remark;
}

/**
 *运送地址Id
 */
@property(nonatomic,assign)int deliveryAddressId;

/**
 *用户id
 */
@property (nonatomic, retain) NSString *  userId;

/**
 *收货人
 */
@property (nonatomic, retain) NSString *  consignee;

/**
 *邮编
 */
@property (nonatomic, retain) NSString *  zip;

/**
 *电话
 */
@property (nonatomic, retain) NSString *  telephone;

/**
 * 国家
 */
@property (nonatomic, retain) NSString *  country;

/**
 *城市
 */
@property (nonatomic, retain) NSString *  city;

/**
 * 地址
 */
@property (nonatomic, retain) NSString *  address;

/**
 * 生成时间
 */
@property(nonatomic,retain)NSString *  dAddtime;

/**
 *国家ID
 */
@property(nonatomic,assign)int nCountryID;

/**
 *保留所有包装
 */
@property (nonatomic, retain) NSString * keepPacking;

/**
 *备注
 */
@property (nonatomic, retain) NSString * remark;


@end
