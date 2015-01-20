//
//  ShareBuyTopicTheme.m
//  PanliApp
//
//  Created by jason on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareBuyTopicTheme.h"

@implementation ShareBuyTopicTheme
@synthesize themeId = _themeId;
@synthesize theme = _theme;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super init];
    if (self && iDictionary)
    {
        self.themeId    = [[iDictionary objectForKey:@"Id"] intValue];
        self.theme      = [iDictionary objectForKey:@"Theme"];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_themeId forKey:@"Id"];
    [aCoder encodeObject:_theme forKey:@"Theme"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.themeId = [aDecoder decodeIntForKey:@"Id"];
        self.theme = [aDecoder decodeObjectForKey:@"Theme"];
    }
    return self;
}
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_theme);
    [super dealloc];
}

@end
