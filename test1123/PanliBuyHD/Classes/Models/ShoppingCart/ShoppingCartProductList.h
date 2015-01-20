//
//  ShoppingCartProductList.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartProductList : NSObject

{
    NSString *_shopName;
    NSMutableArray *_marr_ProductList;
    float _shopFreight;
    BOOL _isSelected;
}

/**
 *店铺名
 */
@property (nonatomic, strong) NSString * shopName;

/**
 *商品列表
 */
@property (nonatomic, strong) NSMutableArray * marr_ProductList;

/**
 *运费
 */
@property (nonatomic, unsafe_unretained) float shopFreight;
/**
 *是否被选中（画面用）
 */
@property (nonatomic, unsafe_unretained) BOOL isSelected;
@end
