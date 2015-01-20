//
//  ProductStatusRecord.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "FlowStatusRecord.h"

@interface ProductStatusRecord : FlowStatusRecord

{
    int _productId;
    UserProductStatus _status;
}

/**
 *商品id
 */
@property(nonatomic,unsafe_unretained) int productId;

/**
 *商品状态
 */
@property(nonatomic,unsafe_unretained) UserProductStatus status;

@end
