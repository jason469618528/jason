//
//  Message.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject<NSCoding>

{
    int _messageId;
    NSString * _content;
    NSString * _dateCreated;
    NSString * _kefuName;
    BOOL _isOwn;
}

/**
 *短信id
 */
@property (nonatomic,assign) int   messageId;

/**
 *短信内容
 */
@property (nonatomic, retain) NSString *  content;

/**
 *创建时间
 */
@property (nonatomic, retain) NSString *  dateCreated;

/**
 *客服名称
 */
@property (nonatomic, retain) NSString *  kefuName;

/**
 *是否自己发起
 */
@property(nonatomic,assign)BOOL isOwn;

@end
