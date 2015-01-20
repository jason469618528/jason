//
//  ProductStatusRecord.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ProductStatusRecord.h"

@implementation ProductStatusRecord

@synthesize productId = _productId;
@synthesize status = _status;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_productId forKey:@"ProductId"];
    [aCoder encodeInt:_status forKey:@"Status"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.productId = [aDecoder decodeIntForKey:@"ProductId"];
        self.status    = [aDecoder decodeIntForKey:@"Status"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}
@end
