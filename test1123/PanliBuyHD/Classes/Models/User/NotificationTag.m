//
//  NotificationTag.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "NotificationTag.h"

@implementation NotificationTag

@synthesize type = _type;
@synthesize enable = _enable;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_type forKey:@"Type"];
    [aCoder encodeBool:_enable forKey:@"Enable"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.type = [aDecoder decodeIntForKey:@"Type"];
        self.enable = [aDecoder decodeBoolForKey:@"Enable"];
    }
    return self;
}

@end
