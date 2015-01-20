//
//  GetUserInfoRequest.h
//  PanliBuyHD
//
//  Created by guo on 14-10-20.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseHttpRequest.h"
typedef void(^getUserInfoData)(DataRepeater *);

@interface GetUserInfoRequest : BaseHttpRequest

@property (nonatomic, copy) getUserInfoData getUserInfoData;

@end
