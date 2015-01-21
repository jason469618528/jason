//
//  FavoriteProductsOrShopsRequest.h
//  PanliBuyHD
//
//  Created by guo on 14-10-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface FavoriteProductsOrShopsRequest : BaseHttpRequest
{
    //区分是那种请求
    NSString *type;
}

@end
