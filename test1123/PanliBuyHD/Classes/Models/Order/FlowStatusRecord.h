//
//  FlowStatusRecord.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowStatusRecord : NSObject<NSCoding>

{
    int _flowStatusRecordId;
    NSString * _remark;
    NSString * _dataCreated;
}

/**
 *记录id
 */
@property(nonatomic,unsafe_unretained)int flowStatusRecordId;

/**
 *说明
 */
@property (nonatomic, strong) NSString *  remark;

/**
 *创建时间
 */
@property (nonatomic, strong) NSString *  dataCreated;

@end
