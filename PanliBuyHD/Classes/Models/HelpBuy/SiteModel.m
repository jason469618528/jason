//
//  SiteModel.m
//  PanliApp
//
//  Created by jason on 13-6-27.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SiteModel.h"

@implementation SiteModel
@synthesize siteName = _siteName;
@synthesize siteUrl = _siteUrl;
@synthesize logo = _logo;

- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    if (self = [super init])
    {
        self.siteName = [iDictionary objectForKey:@"SiteName"];
        self.logo     = [iDictionary objectForKey:@"Logo"];
        self.siteUrl  = [iDictionary objectForKey:@"SiteUrl"];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_siteName forKey:@"SiteName"];
    [aCoder encodeObject:_siteUrl forKey:@"SiteUrl"];
    [aCoder encodeObject:_logo forKey:@"Logo"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.siteName = [aDecoder decodeObjectForKey:@"SiteName"];
        self.siteUrl = [aDecoder decodeObjectForKey:@"SiteUrl"];
        self.logo = [aDecoder decodeObjectForKey:@"Logo"];
    }
    return self;
}
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
