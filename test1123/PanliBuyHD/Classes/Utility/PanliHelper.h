//
//  PanliHelper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"

#define Q_TYPE_NUMBER 0
#define Q_TYPE_BOOLEAN 1
#define Q_TYPE_STRING 2
#define Q_TYPE_INT_STRING 3
#define Q_TYPE_DICTIONARY 4
#define Q_TYPE_ARRAY 5

@interface PanliHelper : NSObject

+ (NSString *)getVersion;
+ (BOOL)connectedToNetwork;
+ (NSString *)timestampToDateString:(NSString*)iTimestamp formatterString:(NSString*)iFormatStr;
+ (NSString *)getUTCFormateLocalDate:(NSString *)iLocalDate formatterString:(NSString*)iFormatterStr;
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)iUtcDate formatterString:(NSString*)iFormatterStr;
+ (id)getValue:(int)iWantType inJsonDictionary:(NSDictionary*)iDic propertyName:(NSString*)iName;
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;
+ (void)setExtraCellPixelExcursion :(UITableView *)iTableView;
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert;

+ (float)getMinPriceWithCostPrice:(float)iCost promotionPrice:(float)iPromotion vipPrice:(float)iVip;
+ (void)updataUserBalance:(float)iBalance;
+ (UIImage*)getImageFileByName:(NSString*)sourceName;
+ (NSString*)getCurrencyStyle:(float)iNumber;

@end
