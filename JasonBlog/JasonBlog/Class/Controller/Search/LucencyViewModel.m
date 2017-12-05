//
//  LucencyViewModel.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/12/4.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "LucencyViewModel.h"

@interface LucencyViewModel ()

@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation LucencyViewModel


- (instancetype)init {
    if(self = [super init]) {
        //init dataSource
    }
    return self;
}

#pragma mark - getter
- (NSMutableArray*)sections {
    if(_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}



@end
