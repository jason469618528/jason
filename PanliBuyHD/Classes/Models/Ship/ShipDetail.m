//
//  ShipDetail.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipDetail.h"

@implementation ShipDetail

@synthesize userProducts = _userProducts;
@synthesize productsWeight = _productsWeight;
@synthesize totalProductPrice = _totalProductPrice;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
     [aCoder encodeObject:_userProducts forKey:@"UserProducts"];
     [aCoder encodeInt:   _productsWeight forKey:@"ProductsWeight"];
     [aCoder encodeFloat: _totalProductPrice forKey:@"TotalProductPrice"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userProducts      = [aDecoder decodeObjectForKey:@"UserProducts"];
        self.productsWeight    = [aDecoder decodeIntForKey:@"ProductsWeight"];
        self.totalProductPrice = [aDecoder decodeFloatForKey:@"TotalProductPrice"];
    }
    return self;
}


-(void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_userProducts);
    [super dealloc];
}


@end
