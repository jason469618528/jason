//
//  ShareBuyTopicTheme.h
//  PanliApp
//
//  Created by jason on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareBuyTopicTheme : NSObject
{
    int _themeId;
    NSString *_theme;
}
/**
 *主题id
 */
@property (nonatomic, assign) int themeId;

/**
 *主题名称
 */
@property (nonatomic, retain) NSString *theme;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;
@end
