//
//  DataRequestRepeater.m
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DataRepeater.h"

@implementation DataRepeater

@synthesize requestName = _requestName;
@synthesize requestParameters = _requestParameters;
@synthesize networkRequest = _networkRequest;
@synthesize isAuth = _isAuth;
@synthesize cacheKey = _cacheKey;
@synthesize saveCache = _saveCache;
@synthesize clearCache = _clearCache;
@synthesize cacheValidTime = _cacheValidTime;
@synthesize requestModal = _requestModal;
@synthesize pushedCacheOperation = _pushedCacheOperation;
@synthesize updateDataSouce = _updateDataSouce;

@synthesize isResponseSuccess = _isResponseSuccess;
@synthesize responseValue = _responseValue;
@synthesize respondModal = _respondModal;
@synthesize errorInfo = _errorInfo;
@synthesize notificationName = _notificationName;

#pragma mark - 构造函数
- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _requestName = name;
        _requestParameters = nil;
        _networkRequest = nil;
        _isAuth = NO;
        _cacheKey = nil;
        _saveCache = NO;
        _clearCache = NO;
        _cacheValidTime = 0;
        _requestModal = PushData;
        _pushedCacheOperation = Cache_None;
        _updateDataSouce = nil;
        
        _isResponseSuccess = NO;        
        _responseValue = nil;
        _respondModal = DisplayServerData;
        _errorInfo = nil;
        _notificationName = nil;
        _compleBlock = nil;
    }
    return self;
}

@end
