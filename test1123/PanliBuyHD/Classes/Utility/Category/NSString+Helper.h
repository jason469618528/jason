//
//  NSString+Helper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)MD5;
- (NSString *)sha1;
- (NSString *)reverse;
- (NSUInteger)wordCount;
- (NSString *)trim;
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement;
- (NSArray *)split:(NSString*)separator;
- (int)indexOfString:(NSString*)str;
- (int)lastIndexOfString:(NSString*)str;
- (NSDate*)formatToDateWithString:(NSString*)string;
- (NSDate*)formatToDateWithStyle:(NSDateFormatterStyle)style;


+ (BOOL)isEmpty:(NSString*)string;
- (BOOL)contains:(NSString *)string;
- (BOOL)startsWith:(NSString*)prefix;
- (BOOL)endsWith:(NSString*)suffix;
- (BOOL)isNumeric;
- (BOOL)isTelephone;
- (BOOL)isValidEmail;


@end
