//
//  ShipCountry.h
//  PanliApp
//
//  Created by jason on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipCountry : NSObject

{
    int _shipCountryId;
    NSString *_code;
    NSString *_name;
    int _order;
    NSString *_initial;
    BOOL _isCommon;
}
/**
 *运送区域id
 */
@property(nonatomic,assign) int shipCountryId;

/**
 *国家代码
 */
@property (nonatomic, retain) NSString * code;

/**
 *国际名称
 */
@property (nonatomic, retain) NSString * name;


/**
 *排序
 */
@property(nonatomic,assign) int order;

/**
 *排序字母
 */

@property (nonatomic, retain) NSString * initial;

/**
 *是否热门
 */
@property(nonatomic,assign) BOOL isCommon;

@end
