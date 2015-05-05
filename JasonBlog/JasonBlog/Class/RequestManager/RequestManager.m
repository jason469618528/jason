//
//  RequestManager.m
//  JasonBlog
//
//  Created by jason on 15-5-5.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

- (void) dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

+ (RequestManager *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)sendRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //你的接口地址
    NSString *url=@"http://www.weather.com.cn/data/cityinfo/101010100";
    
    __weak typeof(id) temp = self;
    //发送请求
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [temp requestSuccessAndError:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [temp requestSuccessAndError:operation];
    }];
}

- (void)requestSuccessAndError:(AFHTTPRequestOperation*)operation
{
    NSLog(@"%@",operation);
}

@end
