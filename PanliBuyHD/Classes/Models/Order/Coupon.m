//
//  Coupon.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon

@synthesize userCouponId = _userCouponId;
@synthesize code = _code;
@synthesize name = _name;
@synthesize denomination = _denomination;
@synthesize isActivated = _isActivated;
@synthesize givable = _givable;
@synthesize tradable = _tradable;
@synthesize dateCreated = _dateCreated;
@synthesize deadlineForActivation = _deadlineForActivation;
@synthesize userId = _userId;
@synthesize status = _status;
@synthesize isSelect = _isSelect;
@synthesize couponSource = _couponSource;
/**
 *序列化
 */

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_userCouponId forKey:@"UserCouponId"];
    [aCoder encodeObject:_code forKey:@"Code"];
    [aCoder encodeObject:_name forKey:@"Name"];
    [aCoder encodeFloat:_denomination forKey:@"Denomination"];
    [aCoder encodeBool:_isActivated forKey:@"IsActivated"];
    [aCoder encodeBool:_givable forKey:@"Givable"];
    [aCoder encodeBool:_tradable forKey:@"Tradable"];
    [aCoder encodeObject:_dateCreated forKey:@"DateCreated"];
    [aCoder encodeObject:_deadlineForActivation forKey:@"DeadlineForActivation"];
    [aCoder encodeObject:_userId forKey:@"UserId"];
    
    [aCoder encodeInt:_status forKey:@"Status"];
    [aCoder encodeBool:_isSelect forKey:@"IsSelect"];
    [aCoder encodeInt:_couponSource forKey:@"Source"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userCouponId          = [aDecoder decodeIntForKey:@"UserCouponId"];
        self.code                  = [aDecoder decodeObjectForKey:@"Code"];
        self.name                  = [aDecoder decodeObjectForKey:@"Name"];
        self.denomination          = [aDecoder decodeFloatForKey:@"Denomination"];
        self.isActivated           = [aDecoder decodeBoolForKey:@"IsActivated"];
        self.givable               = [aDecoder decodeBoolForKey:@"Givable"];
        self.tradable              = [aDecoder decodeBoolForKey:@"Tradable"];
        self.dateCreated           = [aDecoder decodeObjectForKey:@"DateCreated"];
        self.deadlineForActivation = [aDecoder decodeObjectForKey:@"DeadlineForActivation"];
        self.userId                = [aDecoder decodeObjectForKey:@"UserId"];        
        self.status                = [aDecoder decodeIntForKey:@"Status"];
        self.isSelect              = [aDecoder decodeBoolForKey:@"IsSelect"];
        self.couponSource           = [aDecoder decodeIntForKey:@"Source"];
    }
    return self;
}


- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);    
    SAFE_RELEASE(_code);
    SAFE_RELEASE(_name);
    SAFE_RELEASE(_dateCreated);
    SAFE_RELEASE(_deadlineForActivation);
    [super dealloc];
}

@end
