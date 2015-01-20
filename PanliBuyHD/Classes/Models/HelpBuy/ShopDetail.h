//
//  ShopDetail.h
//  PanliApp
//
//  Created by jason on 13-6-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetail : NSObject

{
    NSString *_shopName;
    NSString *_shopUrl;
    NSString *_logo;
    int _credit;
    float _deliverySpeed;
    NSString *_instruction;
    NSString *_keeperName;
    float _positiveRatio;
    float _serviceAttitude;
}

/**
 *店铺名称
 */
@property (nonatomic, strong) NSString *shopName;

/**
 *店铺url
 */
@property (nonatomic, strong)  NSString * shopUrl;

/**
 *店铺图片
 */
@property (nonatomic, strong) NSString * logo;




/**
 *卖家信誉
 */
@property (nonatomic, unsafe_unretained)  int   credit;

/**
 *发货速度 
 */
@property (nonatomic, unsafe_unretained)  float deliverySpeed;

/**
 *店铺介绍
 */
@property (nonatomic, strong) NSString * instruction;


/**
 *掌拒
 */
@property (nonatomic, strong) NSString * keeperName;

/**
 *好评
 */
@property (nonatomic, unsafe_unretained) float  positiveRatio;

/**
 *服务态度
 */
@property (nonatomic, unsafe_unretained) float  serviceAttitude;


- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
