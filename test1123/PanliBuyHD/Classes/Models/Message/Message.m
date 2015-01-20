//
//  Message.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize messageId = _messageId;
@synthesize content = _content;
@synthesize dateCreated = _dateCreated;
@synthesize kefuName = _kefuName;
@synthesize isOwn = _isOwn;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_messageId forKey:@"ID"];
    [aCoder encodeObject:_content forKey:@"Content"];
    [aCoder encodeObject:_dateCreated forKey:@"DateCreated"];
    [aCoder encodeObject:_kefuName forKey:@"KefuName"];
    [aCoder encodeBool:  _isOwn forKey:@"IsOwn"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
          self.messageId   = [aDecoder decodeIntForKey:@"ID"];
          self.content     = [aDecoder decodeObjectForKey:@"Content"];
          self.dateCreated = [aDecoder decodeObjectForKey:@"DateCreated"];
          self.kefuName    = [aDecoder decodeObjectForKey:@"KefuName"];
          self.isOwn       = [aDecoder decodeBoolForKey:@"IsOwn"];
    }
    return self;
}
- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_content);
    SAFE_RELEASE(_dateCreated);
    SAFE_RELEASE(_kefuName);
    [super dealloc];
}

@end
