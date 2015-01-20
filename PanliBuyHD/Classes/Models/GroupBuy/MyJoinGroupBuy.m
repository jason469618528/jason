//
//  MySelectGroupBuy.m
//  PanliApp
//
//  Created by jason on 13-8-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MyJoinGroupBuy.h"

@implementation MyJoinGroupBuy
@synthesize tuanId = _tuanId;
@synthesize groupName = _groupName;
@synthesize groupType = _groupType;
@synthesize products = _products;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_tuanId forKey:@"TuanId"];
    [aCoder encodeObject:_groupName forKey:@"GroupName"];
    [aCoder encodeInt:_groupType forKey:@"GroupType"];
    [aCoder encodeObject:_products forKey:@"Products"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.tuanId = [aDecoder decodeIntForKey:@"TuanId"];
        self.groupName = [aDecoder decodeObjectForKey:@"GroupName"];
        self.groupType = [aDecoder decodeIntForKey:@"GroupType"];
        self.products = [aDecoder decodeObjectForKey:@"Products"];
    }
    return self;
}
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_groupName);
    SAFE_RELEASE(_products);
    [super dealloc];
}
@end
