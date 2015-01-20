//
//  MySelectGroupBuyProduct.m
//  PanliApp
//
//  Created by jason on 13-8-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MyJoinGroupBuyProduct.h"

@implementation MyJoinGroupBuyProduct
@synthesize productName = _productName;
@synthesize productUrl = _productUrl;
@synthesize thumbnail = _thumbnail;
@synthesize price = _price;
@synthesize remark = _remark;
@synthesize skuRemark = _skuRemark;
@synthesize buyNum = _buyNum;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_productName forKey:@"ProductName"];
    [aCoder encodeObject:_productUrl forKey:@"ProductUrl"];
    [aCoder encodeObject:_thumbnail forKey:@"Thumbnail"];
    [aCoder encodeFloat:_price forKey:@"Price"];
    [aCoder encodeObject:_remark forKey:@"Remark"];
    [aCoder encodeObject:_skuRemark forKey:@"SkuRemark"];
    [aCoder encodeInt:_buyNum forKey:@"BuyNum"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.productName = [aDecoder decodeObjectForKey:@"ProductName"];
        self.productUrl = [aDecoder decodeObjectForKey:@"ProductUrl"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"Thumbnail"];
        self.price = [aDecoder decodeFloatForKey:@"Price"];
        self.remark = [aDecoder decodeObjectForKey:@"Remark"];
        self.skuRemark = [aDecoder decodeObjectForKey:@"SkuRemark"];
        self.buyNum = [[aDecoder decodeObjectForKey:@"BuyNum"] intValue];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_productName);
    SAFE_RELEASE(_productUrl);
    SAFE_RELEASE(_thumbnail);
    SAFE_RELEASE(_remark);
    SAFE_RELEASE(_skuRemark);
    [super dealloc];
}
@end
