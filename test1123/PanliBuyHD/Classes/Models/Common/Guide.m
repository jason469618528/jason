//
//  Guide.m
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Guide.h"

@implementation Guide

@synthesize guideId = _guideId;
@synthesize guideName = _guideName;
@synthesize guideImage = _guideImage;
@synthesize type = _type;

- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super init];
    if (self && iDictionary)
    {
        self.guideId = [[iDictionary objectForKey:@"GuideId"] intValue];
        self.guideName = [iDictionary objectForKey:@"GuideName"];
        self.guideImage = [iDictionary objectForKey:@"GuideImage"];
        self.type = [[iDictionary objectForKey:@"Type"] intValue];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_guideId forKey:@"GuideId"];
    [aCoder encodeObject:_guideName forKey:@"GuideName"];
    [aCoder encodeObject:_guideImage forKey:@"GuideImage"];
    [aCoder encodeInt:_type forKey:@"Type"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.guideId   = [aDecoder decodeIntForKey:@"GuideId"];
        self.guideName = [aDecoder decodeObjectForKey:@"GuideName"];
        self.guideImage      = [aDecoder decodeObjectForKey:@"GuideImage"];
        self.type   = [aDecoder decodeIntForKey:@"Type"];
    }
    return self;
}


- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    self.guideName = nil;
    self.guideImage = nil;
    [super dealloc];
}
@end
