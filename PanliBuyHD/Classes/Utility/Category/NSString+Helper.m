//
//  NSString+Helper.m
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)

#define NotFound -1
/**
 * 功能描述: MD5加密
 * 输入参数: N/A
 * 返 回 值: self
 */
- (NSString *)MD5
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

/**
 * 功能描述: sha1加密
 * 输入参数: N/A
 * 返 回 值: self
 */
- (NSString *)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data 	 = [NSData dataWithBytes:cstr length:self.length];
    
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
		[output appendFormat:@"%02x", digest[i]];
    }
    
	return output;
}

/**
 * 功能描述: 字符串反转
 * 输入参数: N/A
 * 返 回 值: self
 */
- (NSString *)reverse
{
	NSInteger length = [self length];
	unichar *buffer = calloc(length, sizeof(unichar));
    
	// TODO(gabe): Apparently getCharacters: is really slow
	[self getCharacters:buffer range:NSMakeRange(0, length)];
    
	for(int i = 0, mid = ceil(length/2.0); i < mid; i++)
    {
		unichar c = buffer[i];
		buffer[i] = buffer[length-i-1];
		buffer[length-i-1] = c;
	}
    
	NSString *reverseStr = [[NSString alloc] initWithCharacters:buffer length:length];
    buffer = nil;
	return reverseStr;
}

/**
 * 功能描述: 字符个数
 * 输入参数: N/A
 * 返 回 值: wordCount
 */
- (NSUInteger)wordCount
{
    
    __block NSUInteger wordCount = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByWords
                          usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              wordCount++;
                          }];
    return wordCount;
}

/**
 * 功能描述: 去掉空格或换行
 * 输入参数: N/A
 * 返 回 值: self
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 * 功能描述: 截取字符串
 * 输入参数: from 起始索引 to 结束索引
 * 返 回 值: self
 */
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to
{
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}

/**
 * 功能描述: 替换字符串
 * 输入参数: origin 原字符 replacement 目标字符
 * 返 回 值: self
 */
- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement
{
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

/**
 * 功能描述: 分割字符串
 * 输入参数: separator 分隔符
 * 返 回 值: array
 */
- (NSArray *)split:(NSString*) separator
{
    return [self componentsSeparatedByString:separator];
}

/**
 * 功能描述: 获取单个字符第一次出现的索引
 * 输入参数: str 字符
 * 返 回 值: index
 */
- (int)indexOfString:(NSString*)str
{
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound)
    {
        return NotFound;
    }
    return (int)range.location;
}

/**
 * 功能描述: 获取单个字符最后一次出现的索引
 * 输入参数: str 字符
 * 返 回 值: index
 */
- (int)lastIndexOfString:(NSString*)str
{
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    if (range.location == NSNotFound)
    {
        return NotFound;
    }
    return (int)range.location;
}

/**
 * 功能描述: 将字符串格式化成日期
 * 输入参数: string 格式
 * 返 回 值: NSDate
 */
- (NSDate*)formatToDateWithString:(NSString*)string
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:string];
    return [fmt dateFromString:self];
}

/**
 * 功能描述: 将字符串格式化成日期
 * 输入参数: style 格式
 * 返 回 值: NSDate
 */
- (NSDate*)formatToDateWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:style];
    return [fmt dateFromString:self];
}

#pragma mark - Boolean Helpers

/**
 * 功能描述: 是否为空字符串
 * 输入参数: N/A
 * 返 回 值: YES/NO
 */
+ (BOOL)isEmpty:(NSString*)string
{
    if (string == nil)
    {
        return YES;
    }
    else if (string == NULL)
    {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([[string trim] isEqualToString:@""])
    {
        return YES;
    }
    else if ([string isEqualToString:@"<null>"]
             || [string isEqualToString:@"null"]
             || [string isEqualToString:@"(null)"]
             ||[string isEqualToString:@"NULL"]
             || [string isEqualToString:@"<NULL>"]
             || [string isEqualToString:@"(NULL)"])
    {
        return YES;
    }
    return NO;
}

/**
 * 功能描述: 是否包含指定字符
 * 输入参数: N/A
 * 返 回 值: YES/NO
 */
- (BOOL)contains:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

/**
 * 功能描述: 是否以指定字符开始
 * 输入参数: suffix
 * 返 回 值: YES/NO
 */
- (BOOL)startsWith:(NSString*)prefix
{
    return [self hasPrefix:prefix];
}

/**
 * 功能描述: 是否以指定字符结尾
 * 输入参数: suffix
 * 返 回 值: YES/NO
 */
- (BOOL)endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}

/**
 * 功能描述: 判断是否为有效数字
 * 输入参数: N/A
 * 返 回 值: YES/NO
 */
- (BOOL)isNumeric
{
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return ([self rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound) ? YES : NO;
}

/**
 * 功能描述: 判断是否为电话
 * 输入参数: N/A
 * 返 回 值: YES/NO
 */
- (BOOL)isTelephone
{
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-"] invertedSet];
    return ([self rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound) ? YES : NO;
}

/**
 * 功能描述: 判断是否为有效邮箱格式
 * 输入参数: N/A
 * 返 回 值: YES/NO
 */
- (BOOL)isValidEmail
{
    BOOL isValidEmail = YES;
    NSString *pattern = [NSString stringWithFormat:@"[A-Z0-9]+@[A-Z0-9_-]+\\.[A-Z]{2,4}"];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSRange range;
    range.location = 0;
    range.length = [self length];
    
    if ([regEx numberOfMatchesInString:self options:0 range:range] == 0) {
        
        isValidEmail = NO;
    }
    return isValidEmail;
}


@end
