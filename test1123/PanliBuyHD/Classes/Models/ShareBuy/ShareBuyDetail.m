//
//  ShareBuyDetail.m
//  PanliApp
//
//  Created by jason on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareBuyDetail.h"

@implementation ShareBuyDetail
@synthesize score = _score;
@synthesize pictureArray = _pictureArray;
@synthesize dateShare = _dateShare;
@synthesize nickname = _nickname;
@synthesize message = _message;
/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super init];
    if (self && iDictionary)
    {
        self.score = [[iDictionary objectForKey:@"Score"] floatValue];
        self.pictureArray = [iDictionary objectForKey:@"PictureArray"];
        self.dateShare = [iDictionary objectForKey:@"DateShare"];
        self.nickname = [iDictionary objectForKey:@"NickName"];
        self.message = [iDictionary objectForKey:@"Message"];
        }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:_score forKey:@"Score"];
    [aCoder encodeObject:_pictureArray forKey:@"PictureArray"];
    [aCoder encodeObject:_dateShare forKey:@"DateShare"];
    [aCoder encodeObject:_nickname forKey:@"NickName"];
    [aCoder encodeObject:_message forKey:@"Message"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.score              = [aDecoder decodeFloatForKey:@"Score"];
        self.pictureArray       = [aDecoder decodeObjectForKey:@"PictureArray"];
        self.dateShare          = [aDecoder decodeObjectForKey:@"DateShare"];
        self.nickname           = [aDecoder decodeObjectForKey:@"NickName"];
        self.message            = [aDecoder decodeObjectForKey:@"Message"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_pictureArray);
    SAFE_RELEASE(_dateShare);
    SAFE_RELEASE(_nickname);
    SAFE_RELEASE(_message);
    [super dealloc];
}

@end
