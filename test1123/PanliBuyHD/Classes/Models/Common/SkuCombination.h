//
//  SkuCombination.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkuCombination : NSObject

{
    NSString *_combinationId;
    float _price;
    float _promo_Price;
    int _quantity;
    NSMutableArray *_skuIds;
}
/**
 *SkuId
 */
@property (nonatomic, strong) NSString  *combinationId;

/**
 *价格
 */
@property (nonatomic, unsafe_unretained) float price;

/**
 *限时折扣价
 */
@property (nonatomic, unsafe_unretained) float promo_Price;

/**
 *库存数量
 */
@property (nonatomic, unsafe_unretained) int  quantity;

/**
 *对应属性ID列表
 */
@property (nonatomic, strong) NSMutableArray  *skuIds;

- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
