//
//  ExpressInfo.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressInfo : NSObject<NSCoding>

{
    NSString * _content;
    NSString * _time;
}

/**
 *物流信息
 */
@property (nonatomic, strong) NSString *  content;

/**
 *信息时间
 */
@property (nonatomic, strong) NSString *  time;

@end
 