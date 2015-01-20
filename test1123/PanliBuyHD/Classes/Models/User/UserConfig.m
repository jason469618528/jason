//
//  UserConfig.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserConfig.h"

@implementation UserConfig


@synthesize dateCreatedUtc = _dateCreatedUtc;
@synthesize notifications = _notifications;
@synthesize noDisturbBeginHour = _noDisturbBeginHour;
@synthesize noDisturbEndHour = _noDisturbEndHour;
@synthesize lastUpdateDateUtc = _lastUpdateDateUtc;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_dateCreatedUtc forKey:@"DateCreatedUtc"];
    [aCoder encodeObject:_notifications forKey:@"Notifications"];
    [aCoder encodeInteger:_noDisturbBeginHour forKey:@"NoDisturbBeginHour"];
    [aCoder encodeInteger:_noDisturbEndHour forKey:@"NoDisturbEndHour"];
    [aCoder encodeObject:_lastUpdateDateUtc forKey:@"LastUpdaDateUtc"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.dateCreatedUtc = [aDecoder decodeObjectForKey:@"DateCreatedUtc"];
        self.notifications = [aDecoder decodeObjectForKey:@"Notifications"];
        self.noDisturbBeginHour = [aDecoder decodeIntegerForKey:@"NoDisturbBeginHour"];
        self.noDisturbEndHour = [aDecoder decodeIntegerForKey:@"NoDisturbEndHour"];
        self.lastUpdateDateUtc = [aDecoder decodeObjectForKey:@"LastUpdaDateUtc"];
    }
    return self;
}


- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_dateCreatedUtc);
    SAFE_RELEASE(_notifications);
    SAFE_RELEASE(_lastUpdateDateUtc);
    [super dealloc];
}

@end
