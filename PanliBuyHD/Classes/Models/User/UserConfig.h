//
//  UserConfig.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject

{
  
    NSString *_dateCreatedUtc;
    NSMutableArray *_notifications;
    int _noDisturbBeginHour;
    int _noDisturbEndHour;
    NSString *_lastUpdateDateUtc;
}



/**
 *创建时间
 */
@property(nonatomic,retain) NSString *dateCreatedUtc;

/**
 *消息配置列表
 */
@property (nonatomic, retain) NSMutableArray *notifications;

/**
 *免打扰开始时间
 */
@property (nonatomic, assign) int noDisturbBeginHour;

/**
 *免打扰结束时间
 */
@property (nonatomic, assign) int noDisturbEndHour;

/**
 *最近更新时间
 */
@property (nonatomic, retain) NSString *lastUpdateDateUtc;

@end
