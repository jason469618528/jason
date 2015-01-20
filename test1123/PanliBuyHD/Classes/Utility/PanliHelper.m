//
//  PanliHelper.m
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//


#import "PanliHelper.h"
#include <netdb.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "UserInfo.h"

@implementation PanliHelper

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *oAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return oAppVersion;
}

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        DLOG(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 * 功能描述: 根据格式将时间戳转换成字符串
 * 输入参数: timestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 * 返 回 值: 字符串形式的时间
 */
+ (NSString *)timestampToDateString:(NSString*)iTimestamp formatterString:(NSString*)iFormatStr
{
    if([NSString isEmpty:iTimestamp])
    {
        return @"";
    }
    
    //截取时间戳
    NSRange range = NSMakeRange(6, [iTimestamp length] - 8);
    iTimestamp = [iTimestamp substringWithRange:range];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[iTimestamp doubleValue]/1000];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:iFormatStr];
    return [formatter stringFromDate:date];
}

/**
 * 功能描述: 将本地日期字符串转为UTC日期字符串
 * 输入参数: 本地时间
 * 返 回 值: UTC时间
 */
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate formatterString:(NSString*)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:formatterStr];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}

/**
 * 功能描述: 将UTC日期字符串转为本地时间字符串
 * 输入参数: UTC时间
 * 返 回 值: 本地时间
 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate formatterString:(NSString*)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@Z",formatterStr]];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}

/**
 * 功能描述: 根据字段类型获取JSON数据的字段值
 * 输入参数: wantType 希望解析成的类型  dict 解析的JSON的字典对象 name 解析的字段名
 * 输出参数: N/A
 * 返 回 值: 解析后的对象
 */
+ (id)getValue:(int)iWantType inJsonDictionary:(NSDictionary*)iDic propertyName:(NSString*)iName;
{
    //获取字典中的原始数据
    id value = [iDic objectForKey:iName];
    //字典
    if ([value isKindOfClass:[NSDictionary class]])
    {
        if (iWantType == Q_TYPE_DICTIONARY)
        {
            return value;
        }
    }
    //数组
    if ([value isKindOfClass:[NSArray class]])
    {
        if (iWantType == Q_TYPE_ARRAY)
        {
            return value;
        }
    }
    //NSNumber
    if ([value isKindOfClass:[NSNumber class]])
    {
        switch (iWantType)
        {
            case Q_TYPE_NUMBER:
            {
                return value;
                break;
            }
            case Q_TYPE_BOOLEAN:
            {
                return value;
                break;
            }
                
            case Q_TYPE_INT_STRING:
            {
                return [[[NSString alloc]initWithFormat:@"%.0f",[value doubleValue]] autorelease];
                break;
            }
                
            case Q_TYPE_STRING:
            {
                return [[[NSString alloc]initWithFormat:@"%.2f",[value doubleValue]] autorelease];
                break;
            }
                
            default:
                break;
        }
        
    }
    //字符串
    if([value isKindOfClass:[NSString class]])
    {
        switch (iWantType)
        {
            case Q_TYPE_NUMBER:
            {
                
                return [[[NSNumber alloc]initWithDouble:[value doubleValue]] autorelease];
                break;
            }
            case Q_TYPE_BOOLEAN:
            {
                
                if ([value isEqualToString:@"true"]||[value isEqualToString:@"TRUE"]||[value isEqualToString:@"YES"]||[value isEqualToString:@"yes"]||[value isEqualToString:@"1"])
                {
                    return [[[NSNumber alloc]initWithBool:YES] autorelease];
                }
                else if([value isEqualToString:@"false"]||[value isEqualToString:@"FALSE"]||[value isEqualToString:@"NO"]||[value isEqualToString:@"no"]||[value isEqualToString:@"0"])
                {
                    return [[[NSNumber alloc]initWithBool:NO] autorelease];
                }
                break;
            }
            case Q_TYPE_INT_STRING:
            {
                return value;
                break;
            }
            case Q_TYPE_STRING:
            {
                return value;
                break;
            }
        }
    }
    
    return nil;
}

/**
 * 功能描述: 清除TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;
{
    UIView *view = [UIView new];
    view.backgroundColor = PL_COLOR_CLEAR;
    [iTableView setTableFooterView:view];
    [view release];
}

/**
 * 功能描述: 清除ios7 cell 向右多20像素
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView
{
    if([iTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [iTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([iTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [iTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert;
{
    NSString *cString = [[iStringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor yellowColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 * 功能描述: 获取商品价格
 * 输入参数: iCost 原价 iPromotion 促销价 iVip vip折扣价
 * 返 回 值: N/A
 */
+ (float)getMinPriceWithCostPrice:(float)iCost promotionPrice:(float)iPromotion vipPrice:(float)iVip
{
    /*****************************************
     *价格计算规则
     *a.拼单购、代购均取原价、促销价、vip价中最小值
     *b.团购取商品原价
     *****************************************/
    float oMinPrice = iCost;
    if (iPromotion > 0)
    {
        oMinPrice = MIN(iCost, iPromotion);
    }
    if (iVip > 0)
    {
        oMinPrice = MIN(oMinPrice, iVip);
    }
    return oMinPrice;
}

/**
 * 功能描述: 更新用户金额
 * 输入参数: 余额
 * 返 回 值: N/A
 */
+(void)updataUserBalance:(float)iBalance
{
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    if(mUserInfo)
    {
        mUserInfo.balance = iBalance;
        [GlobalObj setUserInfo:mUserInfo];
    }
}

/**
 * 功能描述: 获取本地当前资源文件路径
 * 输入参数: string 资源名称
 * 返 回 值: 转换成功的本地路径
 */
+ (UIImage*)getImageFileByName:(NSString*)sourceName
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:sourceName ofType:@""];
    return  [UIImage imageWithContentsOfFile:imagePath];
}

/**
 * 功能描述: 获取千分位显示状态
 * 输入参数: string 数据源
 * 返 回 值: 转换成功的数据
 */
+ (NSString*)getCurrencyStyle:(float)iNumber
{
    if(iNumber <= 0)
    {
        return [NSString stringWithFormat:@"￥%.2f",iNumber];
    }
    NSString *resultString = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:iNumber] numberStyle:NSNumberFormatterCurrencyStyle];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"$" withString:@"￥"];
    return resultString;
}

@end
