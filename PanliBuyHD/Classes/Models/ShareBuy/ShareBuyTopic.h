//
//  ShareBuyTopic.h
//  PanliApp
//
//  Created by jason on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareBuyTopicTheme.h"
@interface ShareBuyTopic: NSObject
{
    NSString *_name;
    NSString *_content;
    int _shareBuyTopicId;
    NSString *_outerImage;
    NSString *_innerImage;
}
/**
 *名称
 */
@property (nonatomic, retain) NSString * name;

/**
 *内容
 */
@property (nonatomic, retain) NSString * content;

/**
 *话题ID
 */
@property (nonatomic, assign) int shareBuyTopicId;

/**
 *外层图片
 */
@property (nonatomic, retain) NSString * outerImage;

/**
 *内层图片
 */
@property (nonatomic, retain) NSString * innerImage;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
