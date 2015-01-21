//
//  UserInfo.m
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userId = _userId;
@synthesize nickName = _nickName;
@synthesize balance = _balance;
@synthesize integration = _integration;
@synthesize userGroup = _userGroup;
@synthesize avatarUrl = _avatarUrl;
@synthesize isApproved = _isApproved;
@synthesize emailSite = _emailSite;
@synthesize couponNumber = _couponNumber;
@synthesize order_ProductAcceptedNumber = _order_ProductAcceptedNumber;
@synthesize order_IssueProductNumber = _order_IssueProductNumber;
@synthesize order_ProcessingNumber = _order_ProcessingNumber;
@synthesize ship_DeliveredpNumber = _ship_DeliveredpNumber;
@synthesize ship_ForConfirmNumber = _ship_ForConfirmNumber;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userId forKey:@"UserId"];
    [aCoder encodeObject:_nickName forKey:@"NickName"];
    [aCoder encodeFloat:_balance forKey:@"Balance"];
    [aCoder encodeInt:_integration forKey:@"Integration"];
    [aCoder encodeInt:_userGroup forKey:@"UserGroup"];
    [aCoder encodeObject:_avatarUrl forKey:@"AvatarUrl"];
    [aCoder encodeBool:_isApproved forKey:@"IsApproved"];
    [aCoder encodeObject:_emailSite forKey:@"EmailSite"];
    
    [aCoder encodeInt:_couponNumber forKey:@"couponNumber"];
    [aCoder encodeInt:_order_ProductAcceptedNumber forKey:@"order_ProductAcceptedNumber"];
    [aCoder encodeInt:_order_IssueProductNumber forKey:@"order_IssueProductNumber"];
    [aCoder encodeInt:_order_ProcessingNumber forKey:@"order_ProcessingNumber"];
    [aCoder encodeInt:_ship_DeliveredpNumber forKey:@"ship_DeliveredpNumber"];
    [aCoder encodeInt:_ship_ForConfirmNumber forKey:@"ship_ForConfirmNumber"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userId      = [aDecoder decodeObjectForKey:@"UserId"];
        self.nickName    = [aDecoder decodeObjectForKey:@"NickName"];
        self.balance     = [aDecoder decodeFloatForKey:@"Balance"];
        self.integration = [aDecoder decodeIntForKey:@"Integration"];
        self.userGroup   = [aDecoder decodeIntForKey:@"UserGroup"];
        self.avatarUrl   = [aDecoder decodeObjectForKey:@"AvatarUrl"];
        self.isApproved  = [aDecoder decodeBoolForKey:@"IsApproved"];
        self.emailSite   = [aDecoder decodeObjectForKey:@"EmailSite"];

        self.couponNumber                  = [aDecoder decodeIntForKey:@"couponNumber"];
        self.order_ProductAcceptedNumber   = [aDecoder decodeIntForKey:@"order_ProductAcceptedNumber"];
        self.order_IssueProductNumber      = [aDecoder decodeIntForKey:@"order_IssueProductNumber"];
        self.order_ProcessingNumber        = [aDecoder decodeIntForKey:@"order_ProcessingNumber"];
        self.ship_DeliveredpNumber         = [aDecoder decodeIntForKey:@"ship_DeliveredpNumber"];
        self.ship_ForConfirmNumber         = [aDecoder decodeIntForKey:@"ship_ForConfirmNumber"];
    }
    return self;
}
@end
