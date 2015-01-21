//
//  NSDate+Helper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

- (NSString *)formatWithString:(NSString *)format;
- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;
- (NSString *)distanceOfTimeInWords;
- (NSString *)distanceOfTimeInWords:(NSDate *)date;

@end
