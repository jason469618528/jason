//
//  ShareProduct.m
//  PanliApp
//
//  Created by jason on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareProduct.h"

@implementation ShareProduct
@synthesize shareProductId = _shareProductId;
@synthesize skuRemark = _skuRemark;
@synthesize numberOfPraise = _numberOfPraise;
/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super initWithDictionary:iDictionary];
    if (self && iDictionary)
    {
        self.shareProductId = [[iDictionary objectForKey:@"ProductId"] intValue];
        self.skuRemark      = [iDictionary objectForKey:@"SkuRemark"];
        self.numberOfPraise = [[iDictionary objectForKey:@"NumberOfPraise"] intValue];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    //super
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt:_shareProductId forKey:@"ProductId"];
    [aCoder encodeObject:_skuRemark forKey:@"SkuRemark"];
    [aCoder encodeInt:_numberOfPraise forKey:@"NumberOfPraise"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.shareProductId          = [aDecoder decodeIntForKey:@"ProductId"];
        self.skuRemark          = [aDecoder decodeObjectForKey:@"SkuRemark"];
        self.numberOfPraise     = [aDecoder decodeIntForKey:@"NumberOfPraise"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_skuRemark);
    [super dealloc];
}

@end
