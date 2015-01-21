//
//  FlowStatusRecord.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "FlowStatusRecord.h"

@implementation FlowStatusRecord

@synthesize flowStatusRecordId = _flowStatusRecordId;
@synthesize remark = _remark;
@synthesize dataCreated = _dataCreated;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_flowStatusRecordId forKey:@"Id"];
    [aCoder encodeObject:_remark forKey:@"Remark"];
    [aCoder encodeObject:_dataCreated forKey:@"DataCreated"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.flowStatusRecordId = [aDecoder decodeIntForKey:@"Id"];
        self.remark             = [aDecoder decodeObjectForKey:@"Remark"];
        self.dataCreated        = [aDecoder decodeObjectForKey:@"DataCreated"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
