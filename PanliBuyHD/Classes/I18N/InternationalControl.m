//
//  InternationalControl.m
//  PanliApp
//
//  Created by ZhaoFucheng on 14-10-15.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "InternationalControl.h"

@implementation InternationalControl

static NSBundle *bundle = nil;
/**
 *  获取当前资源文件
 *
 *  @return Bundle
 */
+ (NSBundle *)bundle {
    return bundle;
}

/**
 *  初始化语言文件
 */
+ (void)initUserLanguage {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:@"userLanguage"];
    if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,繁体zh-Hant,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        if (![current isEqualToString:@"zh-Hans"] && ![current isEqualToString:@"zh-Hant"]) {
            current = @"zh-Hant";
        }
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

/**
 *  获取当前语言
 *
 *  @return NSString
 */
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:@"userLanguage"];
    
    return language;
}

/**
 *  设置当前语言
 *
 *  @param language 语言代码
 */
+(void)setUserLanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    
    [def synchronize];
}

/**
 *  设置跟随系统语言
 */
+ (void)setSystemLanguage
{
    //获取系统当前语言版本(中文zh-Hans,繁体zh-Hant,英文en)
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [def objectForKey:@"AppleLanguages"];
    
    NSString *current = [languages objectAtIndex:0];
    if (![current isEqualToString:@"zh-Hans"] && ![current isEqualToString:@"zh-Hant"]) {
        current = @"zh-Hans";
    }
    
    [def removeObjectForKey:@"userLanguage"];
    
    [def synchronize];//持久化
    
    NSString *path = [[NSBundle mainBundle] pathForResource:current ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

@end
