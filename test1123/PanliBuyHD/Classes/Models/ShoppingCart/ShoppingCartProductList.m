//
//  ShoppingCartProductList.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShoppingCartProductList.h"

@implementation ShoppingCartProductList

@synthesize shopName = _shopName;
@synthesize marr_ProductList = _marr_ProductList;
@synthesize shopFreight = _shopFreight;
@synthesize isSelected = _isSelected;


- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}
@end
