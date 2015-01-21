//
//  PageData.h
//  PanliApp
//
//  Created by Liubin on 13-8-30.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageData : NSObject
{
    NSMutableArray *_list;
    BOOL _hasNext;
    int _rowCount;
}

/**
 *数据源
 */
@property (nonatomic, strong) NSMutableArray *list;

/**
 *是否有下一页
 */
@property (nonatomic, unsafe_unretained) BOOL hasNext;

/**
 *总条数
 */
@property (nonatomic, unsafe_unretained) int rowCount;
@end
