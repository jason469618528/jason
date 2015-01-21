//
//  SkuObject.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SkuObject.h"

@implementation SkuObject

@synthesize skuId = _skuId;
@synthesize propertyName = _propertyName;
@synthesize typeName = _typeName;
@synthesize picUrl = _picUrl;
@synthesize thumbnailUrl =_thumbnailUrl;

- (id) initWithDictionary:(NSDictionary *)iDictionary
{
    if (self = [super init])
    {
        self.skuId        = [iDictionary objectForKey:@"SkuId"];
        self.propertyName = [iDictionary objectForKey:@"PropertyName"];
        self.typeName     = [iDictionary objectForKey:@"TypeName"];
        self.picUrl       = [iDictionary objectForKey:@"PicUrl"];
        self.thumbnailUrl = [iDictionary objectForKey:@"ThumbnailUrl"];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_skuId forKey:@"SkuId"];
    [aCoder encodeObject:_propertyName forKey:@"PropertyName"];
    [aCoder encodeObject:_typeName forKey:@"TypeName"];
    [aCoder encodeObject:_picUrl forKey:@"PicUrl"];
    [aCoder encodeObject:_thumbnailUrl forKey:@"ThumbnailUrl"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.skuId = [aDecoder decodeObjectForKey:@"SkuId"];
        self.propertyName = [aDecoder decodeObjectForKey:@"PropertyName"];
        self.typeName = [aDecoder decodeObjectForKey:@"TypeName"];
        self.picUrl = [aDecoder decodeObjectForKey:@"PicUrl"];
        self.thumbnailUrl = [aDecoder decodeObjectForKey:@"ThumbnailUrl"];
    }
    return self;
}

- (void) dealloc
{    
    DLOG(@"%@ dealloc",[self class]);
}
@end
