//
//  ShareProduct.h
//  PanliApp
//
//  Created by jason on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProduct.h"
@interface ShareProduct : BaseProduct
{
    int _shareProductId;
    NSString *_skuRemark;
    int _numberOfPraise;
}
/**
 *商品id
 */
@property (nonatomic, assign) int  shareProductId;
/**
 *sku备注
 */
@property (nonatomic, retain) NSString * skuRemark;

/**
 *好评数
 */
@property (nonatomic, assign) int  numberOfPraise;


/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;
@end
