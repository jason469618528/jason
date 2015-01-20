//
//  SkuCombination.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SkuCombination.h"

@implementation SkuCombination

@synthesize combinationId = _combinationId;
@synthesize price = _price;
@synthesize promo_Price = _promo_Price;
@synthesize quantity = _quantity;
@synthesize skuIds = _skuIds;

- (id) initWithDictionary:(NSDictionary *)iDictionary
{
    if (self = [super init])
    {
        self.combinationId = [iDictionary objectForKey:@"CombinationId"];
        self.price         = [[iDictionary objectForKey:@"Price"] floatValue];
        self.promo_Price   = [[iDictionary objectForKey:@"Promo_Price"] floatValue];
        self.quantity      = [[iDictionary objectForKey:@"Quantity"] intValue];
        self.skuIds        = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:iDictionary propertyName:@"SkuIds"];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_combinationId forKey:@"CombinationId"];
    [aCoder encodeFloat:_price forKey:@"Price"];
    [aCoder encodeFloat:_promo_Price forKey:@"Promo_Price"];
    [aCoder encodeInt:_quantity forKey:@"Quantity"];
    [aCoder encodeObject:_skuIds forKey:@"SkuIds"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.combinationId = [aDecoder decodeObjectForKey:@"CombinationId"];
        self.price = [aDecoder decodeFloatForKey:@"Price"];
        self.promo_Price = [aDecoder decodeFloatForKey:@"Promo_Price"];
        self.quantity = [aDecoder decodeIntForKey:@"Quantity"];
        self.skuIds = [aDecoder decodeObjectForKey:@"SkuIds"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}
@end
