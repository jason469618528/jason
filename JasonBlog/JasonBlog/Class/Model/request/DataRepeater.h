//
//  DataRepeater.h
//  JasonBlog
//
//  Created by jason on 15-5-5.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    post,
    get,
}RequestState;

@interface DataRepeater : NSObject
{
    //请求参数
    NSString *_requestName;
    NSString *_requestUrl;
    NSMutableDictionary *mdic_params;
    RequestState state;
}
@end
