//
//  InternationalControl.h
//  国际化语言控制
//  PanliApp
//
//  Created by ZhaoFucheng on 14-10-15.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternationalControl : NSObject

/**
 *  获取当前资源文件
 *
 *  @return Bundle
 */
+ (NSBundle *)bundle;

/**
 *  初始化语言文件
 */
+ (void)initUserLanguage;

/**
 *  获取当前语言
 *
 *  @return NSString
 */
+ (NSString *)userLanguage;

/**
 *  设置当前语言
 *
 *  @param language 语言代码
 */
+ (void)setUserLanguage:(NSString *)language;

/**
 *  设置跟随系统语言
 */
+ (void)setSystemLanguage;
@end
