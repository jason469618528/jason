//
//  NSUserDefaults+Helper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)

+ (void)saveObject:(id)object forKey:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;

@end
