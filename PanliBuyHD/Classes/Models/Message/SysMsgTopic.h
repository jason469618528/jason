//
//  SysMsgTopic.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysMsgTopic : NSObject<NSCoding>

{
    int _topicId;
    NSString * _title;
    NSString * _content;
    SysMsgType _msgType;
    NSString * _dateCreated;
    BOOL       _isRead;
    NSString *_dateCreated_zhCN;
    NSMutableArray *_links;
    NSMutableArray *_linkLabels;
}

/**
 *短信id
 */
@property (nonatomic,assign) int  topicId;

/**
 *标题
 */
@property (nonatomic, retain) NSString *  title;

/**
 *内容
 */
@property (nonatomic, retain) NSString *  content;

/**
 *短信类别
 */
@property (nonatomic, assign) SysMsgType  msgType;

/**
 *创建时间
 */
@property (nonatomic, retain) NSString *  dateCreated;

/**
 *是否已读
 */
@property(nonatomic,assign) BOOL isRead;

/**
 *回复时间
 */
@property (nonatomic, retain) NSString * dateCreated_zhCN;

/**
 *超链接链接
 */
@property (nonatomic, retain)  NSMutableArray * links;

/**
 *超链接文字
 */
@property (nonatomic, retain) NSMutableArray * linkLabels;
@end
