//
//  UserUnReadMessages.m
//  PanliApp
//
//  Created by Liubin on 14-6-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "UserUnReadMessages.h"

@implementation UserUnReadMessages
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeInt:_customerMsgCount forKey:@"customerMsgCount"];
    [aCoder encodeInt:_sysmessMsgCount forKey:@"sysmessMsgCount"];
    [aCoder encodeObject:_productObjIds forKey:@"productObjIds"];
    [aCoder encodeObject:_shipObjIds forKey:@"shipObjIds"];
    [aCoder encodeObject:_parcelObjIds forKey:@"parcelObjIds"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userId           = [aDecoder decodeObjectForKey:@"userId"];
        self.customerMsgCount = [aDecoder decodeIntForKey:@"customerMsgCount"];
        self.sysmessMsgCount  = [aDecoder decodeIntForKey:@"sysmessMsgCount"];
        self.productObjIds    = [aDecoder decodeObjectForKey:@"productObjIds"];
        self.shipObjIds       = [aDecoder decodeObjectForKey:@"shipObjIds"];
        self.parcelObjIds     = [aDecoder decodeObjectForKey:@"parcelObjIds"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_userId);
    SAFE_RELEASE(_productObjIds);
    SAFE_RELEASE(_shipObjIds);
    SAFE_RELEASE(_parcelObjIds);
    [super dealloc];
}
@end
