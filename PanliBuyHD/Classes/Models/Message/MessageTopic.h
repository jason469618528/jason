//
//  MessageTopic.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageTopic : NSObject<NSCoding>

{
    int  _topicId;
    NSString * _title;
    NSString * _objId;
    NSString * _lastMessageTime;
    MessageType  _objType;
    BOOL       _isRead;
    NSString * _lastMessageContent;
    NSString *_image;
    NSString *_lastSender;
    NSString *_lastMessageTime_zhCn;
}

/**
 *短信主题id
 */
@property (nonatomic,assign) int  topicId;

/**
 *短信主题
 */
@property (nonatomic, retain) NSString *  title;

/**
 *关联物品ID
 */
@property (nonatomic, retain) NSString *  objId;

/**
 *最后回复时间
 */
@property (nonatomic, retain) NSString *  lastMessageTime;

/**
 *0:商品短信 1:运单短信 2:包裹短信
 */
@property (nonatomic, assign) MessageType  objType;

/**
 *是否已读
 */
@property (nonatomic,assign) BOOL  isRead;

/**
 *最近一条短信内容
 */
@property (nonatomic, retain) NSString *  lastMessageContent;

/**
 *图片
 */
@property (nonatomic, retain) NSString * image;

/**
 *最后发送人
 */
@property (nonatomic, retain)NSString *  lastSender;

/**
 *最后回复时间
 */
@property (nonatomic, retain) NSString *  lastMessageTime_zhCn;
@end
