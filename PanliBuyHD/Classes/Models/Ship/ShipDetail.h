//
//  ShipDetail.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipOrder.h"
#import "UserProduct.h"

@interface ShipDetail : ShipOrder

{
    NSMutableArray * _userProducts;
    int _productsWeight;
    float _totalProductPrice;

}

/**
 *运单商品
 */
@property (nonatomic, retain) NSMutableArray * userProducts;

/**
 *商品总重量
 */
@property(nonatomic,assign)int productsWeight;

/**
 *商品总价
 */
@property(nonatomic,assign) float totalProductPrice;



@end
