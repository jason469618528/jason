//
//  PageData.m
//  PanliApp
//
//  Created by Liubin on 13-8-30.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "PageData.h"

@implementation PageData
@synthesize list = _list;
@synthesize hasNext = _hasNext;
@synthesize rowCount = _rowCount;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}
@end
