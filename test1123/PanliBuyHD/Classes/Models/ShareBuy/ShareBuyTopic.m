//
//  ShareBuyTopic.m
//  PanliApp
//
//  Created by jason on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareBuyTopic.h"
#import "ShareBuyTopicTheme.h"
@implementation ShareBuyTopic
@synthesize name = _name;
@synthesize content = _content;
@synthesize shareBuyTopicId = _shareBuyTopicId;
@synthesize outerImage = _outerImage;
@synthesize innerImage = _innerImage;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super init];
    if (self && iDictionary)
    {
        self.name            = [iDictionary objectForKey:@"Name"];
        self.content         = [iDictionary objectForKey:@"Content"];
        self.shareBuyTopicId = [[iDictionary objectForKey:@"Id"] intValue];
        self.outerImage      = [iDictionary objectForKey:@"OuterImage"];
        self.innerImage      = [iDictionary objectForKey:@"InnerImage"];
    }
    return self;
}
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"Name"];
    [aCoder encodeObject:_content forKey:@"Content"];
    [aCoder encodeInt:_shareBuyTopicId forKey:@"Id"];
    [aCoder encodeObject:_outerImage forKey:@"OuterImage"];
    [aCoder encodeObject:_innerImage forKey:@"InnerImage"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name       = [aDecoder decodeObjectForKey:@"Name"];
        self.content    = [aDecoder decodeObjectForKey:@"Content"];
        self.shareBuyTopicId      = [aDecoder decodeIntForKey:@"Id"];
        self.outerImage = [aDecoder decodeObjectForKey:@"OuterImage"];
        self.innerImage = [aDecoder decodeObjectForKey:@"InnerImage"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_name);
    SAFE_RELEASE(_content);
    SAFE_RELEASE(_outerImage);
    SAFE_RELEASE(_innerImage);
    [super dealloc];
}

@end
