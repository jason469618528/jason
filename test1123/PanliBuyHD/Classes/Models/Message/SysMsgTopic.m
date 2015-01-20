//
//  SysMsgTopic.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SysMsgTopic.h"

@implementation SysMsgTopic

@synthesize topicId = _topicId;
@synthesize title = _title;
@synthesize content = _content;
@synthesize msgType = _msgType;
@synthesize dateCreated = _dateCreated;
@synthesize isRead = _isRead;
@synthesize dateCreated_zhCN = _dateCreated_zhCN;
@synthesize links = _links;
@synthesize linkLabels = _linkLabels;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
     [aCoder encodeInt:_topicId forKey:@"TopicId"];
     [aCoder encodeObject:_title forKey:@"Title"];
     [aCoder encodeObject:_content forKey:@"Content"];
     [aCoder encodeInt:_msgType forKey:@"MsgType"];
     [aCoder encodeObject:_dateCreated forKey:@"DateCreated"];
     [aCoder encodeBool:_isRead forKey:@"IsRead"];
     [aCoder encodeObject:_dateCreated_zhCN forKey:@"DateCreated_zhCN"];
     [aCoder encodeObject:_links forKey:@"Links"];
     [aCoder encodeObject:_linkLabels forKey:@"LinkLabels"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.topicId            = [aDecoder decodeIntForKey:@"TopicId"];
        self.title              = [aDecoder decodeObjectForKey:@"Title"];
        self.content            = [aDecoder decodeObjectForKey:@"Content"];
        self.msgType            = [aDecoder decodeIntForKey:@"MsgType"];
        self.dateCreated        = [aDecoder decodeObjectForKey:@"DateCreated"];
        self.isRead             = [aDecoder decodeBoolForKey:@"IsRead"];
        self.dateCreated_zhCN   = [aDecoder decodeObjectForKey:@"DateCreated_zhCN"];
        self.links              = [aDecoder decodeObjectForKey:@"Links"];
        self.linkLabels         = [aDecoder decodeObjectForKey:@"LinkLabels"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_title);
    SAFE_RELEASE(_content);
    SAFE_RELEASE(_dateCreated);
    SAFE_RELEASE(_dateCreated_zhCN);
    SAFE_RELEASE(_links);
    SAFE_RELEASE(_linkLabels);
    [super dealloc];
}

@end
