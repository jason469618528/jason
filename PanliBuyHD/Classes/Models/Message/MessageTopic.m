//
//  MessageTopic.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageTopic.h"

@implementation MessageTopic

@synthesize topicId = _topicId;
@synthesize title = _title;
@synthesize objId = _objId;
@synthesize lastMessageTime = _lastMessageTime;
@synthesize objType = _objType;
@synthesize isRead = _isRead;
@synthesize lastMessageContent = _lastMessageContent;
@synthesize image = _image;
@synthesize lastSender = _lastSender;
@synthesize lastMessageTime_zhCn = _lastMessageTime_zhCn;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_topicId forKey:@"TopicId"];
    [aCoder encodeObject:_title forKey:@"Title"];
    [aCoder encodeObject:_objId forKey:@"ObjId"];
    [aCoder encodeObject:_lastMessageTime forKey:@"LastMessageTime"];
    [aCoder encodeInt:_objType forKey:@"ObjType"];
    [aCoder encodeBool:_isRead forKey:@"IsRead"];
    [aCoder encodeObject:_lastMessageContent forKey:@"LastMessageContent"];
    [aCoder encodeObject:_image forKey:@"ObjImage"];
    [aCoder encodeObject:_lastSender forKey:@"LastSender"];
    [aCoder encodeObject:_lastMessageTime_zhCn forKey:@"LastMessageTime_zhCn"];    
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
         self.objId              = [aDecoder decodeObjectForKey:@"ObjId"];
         self.lastMessageTime    = [aDecoder decodeObjectForKey:@"LastMessageTime"];
         self.objType            = [aDecoder decodeIntForKey:@"ObjType"];
         self.isRead             = [aDecoder decodeBoolForKey:@"IsRead"];
         self.lastMessageContent = [aDecoder decodeObjectForKey:@"LastMessageContent"];
         self.image = [aDecoder decodeObjectForKey:@"ObjImage"];
        self.lastSender = [aDecoder decodeObjectForKey:@"LastSender"];
        self.lastMessageTime_zhCn = [aDecoder decodeObjectForKey:@"LastMessageTime_zhCn"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_title);
    SAFE_RELEASE(_objId);
    SAFE_RELEASE(_lastMessageTime);
    SAFE_RELEASE(_lastMessageContent);
    SAFE_RELEASE(_image);
    SAFE_RELEASE(_lastSender);
    SAFE_RELEASE(_lastMessageTime_zhCn);
    [super dealloc];
}





@end
