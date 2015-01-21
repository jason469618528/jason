//
//  UserAccount.m
//  PanliApp
//
//  Created by jason on 14-5-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount
@synthesize flowNo = _flowNo;
@synthesize type = _type;
@synthesize amount = _amount;
@synthesize balance = _balance;
@synthesize description = _description;
@synthesize tradeTime = _tradeTime;
- (id)initWithDictionary:(NSDictionary *)iDictionary;
{
    self = [super init];
    
    if(self && iDictionary)
    {
        self.flowNo = [iDictionary objectForKey:@"FlowNo"];
        self.type = [[iDictionary objectForKey:@"Type"] intValue];
        self.amount = [[iDictionary objectForKey:@"Amount"] floatValue];
        self.balance = [[iDictionary objectForKey:@"Balance"] floatValue];
        self.description = [iDictionary objectForKey:@"Description"];
        self.tradeTime = [iDictionary objectForKey:@"TradeTime"];
    }
    return self;
}
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_flowNo forKey:@"FlowNo"];
    [aCoder encodeInt:_type forKey:@"Type"];
    [aCoder encodeFloat:_amount forKey:@"Amount"];
    [aCoder encodeFloat:_balance forKey:@"Balance"];
    [aCoder encodeObject:_description forKey:@"Description"];
    [aCoder encodeObject:_tradeTime forKey:@"TradeTime"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.flowNo = [aDecoder decodeObjectForKey:@"FlowNo"];
        self.type = [aDecoder decodeIntForKey:@"Type"];
        self.amount = [aDecoder decodeFloatForKey:@"Amount"];
        self.balance = [aDecoder decodeFloatForKey:@"Balance"];
        self.description = [aDecoder decodeObjectForKey:@"Description"];
        self.tradeTime = [aDecoder decodeObjectForKey:@"TradeTime"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_flowNo);
    SAFE_RELEASE(_description);
    SAFE_RELEASE(_tradeTime);
    [super dealloc];
}
@end
