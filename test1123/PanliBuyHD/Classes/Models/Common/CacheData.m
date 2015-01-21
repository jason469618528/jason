//
//  CacheData.m
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CacheData.h"

@implementation CacheData

@synthesize cacheKey = _cacheKey;
@synthesize cacheContent = _cacheContent;
@synthesize savedTime = _savedTime;

- (void) dealloc
{
    DLOG(@"%@ %@ dealloc",_cacheKey,[self class]);
}

@end
