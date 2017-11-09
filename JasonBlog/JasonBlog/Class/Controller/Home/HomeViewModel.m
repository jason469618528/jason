//
//  HomeViewModel.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/8/7.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel () {
    RACCommand *_homeCommand;
}

@end

@implementation HomeViewModel

#pragma mark - getter
- (RACCommand*)homeCommand {
    if(_homeCommand == nil) {
        _homeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //模仿网络延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //数据传送
                    [subscriber sendNext:@"data"];
                    //数据传送完毕，必须调用完成，否则命令永远处于执行状态
                    [subscriber sendCompleted];
                });
                //信号结束
                    return [RACDisposable disposableWithBlock:^{
                    NSLog(@"get recommend command disposable");
                }];
            }];
        }];
    }
    return _homeCommand;
}

@end
