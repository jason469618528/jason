//
//  UserScore.m
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "UserScore.h"

@implementation UserScore
@synthesize type = _type;
@synthesize score = _score;
@synthesize description = _description;
@synthesize tradeTime = _tradeTime;

- (id)initWithDictionary:(NSDictionary *)iDictionary;
{
    self = [super init];
    
    if(self && iDictionary)
    {
        self.type = [[iDictionary objectForKey:@"Type"] intValue];
        self.score = [[iDictionary objectForKey:@"Score"] intValue];
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
    [aCoder encodeInt:_type forKey:@"Type"];
    [aCoder encodeFloat:_score forKey:@"Score"];
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
        self.type = [aDecoder decodeIntForKey:@"Type"];
        self.score = [aDecoder decodeIntForKey:@"Score"];
        self.description = [aDecoder decodeObjectForKey:@"Description"];
        self.tradeTime = [aDecoder decodeObjectForKey:@"TradeTime"];
    }
    return self;
}

@end
