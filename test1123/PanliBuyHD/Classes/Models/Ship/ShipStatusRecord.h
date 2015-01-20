//
//  ShipStatusRecord.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "FlowStatusRecord.h"

@interface ShipStatusRecord : FlowStatusRecord

{
    NSString * _shipId;
    ShipStatus _status;
}

/**
 *运单id
 */
@property (nonatomic, retain) NSString *  shipId;

/**
 *运单状态
 */
@property(nonatomic,assign)ShipStatus status;

@end
