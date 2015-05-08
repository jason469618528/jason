//
//  RequestManager.h
//  JasonBlog
//
//  Created by jason on 15-5-5.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^requestSuccess)(id response);
typedef void(^requestError)(NSError *responseError);


@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

- (void)sendRequestSuccess:(requestSuccess)requestSuccess error : (requestError)requestError;

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
