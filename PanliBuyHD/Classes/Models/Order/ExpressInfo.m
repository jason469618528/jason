//
//  ExpressInfo.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ExpressInfo.h"

@implementation ExpressInfo

@synthesize content = _content;
@synthesize time = _time;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_content forKey:@"Content"];
    [aCoder encodeObject:_time forKey:@"Time"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.content = [aDecoder decodeObjectForKey:@"Content"];
        self.time    = [aDecoder decodeObjectForKey:@"Time"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}
@end
