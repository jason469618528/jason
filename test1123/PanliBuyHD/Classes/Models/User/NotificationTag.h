//
//  NotificationTag.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationTag : NSObject

{
    NotificationTypeState _type;
    BOOL _enable;
    
}

/**
 *消息接受类型
 */
@property (nonatomic, assign) NotificationTypeState type;

/**
 *是否接收
 */
@property (nonatomic, assign) BOOL enable;
@end
