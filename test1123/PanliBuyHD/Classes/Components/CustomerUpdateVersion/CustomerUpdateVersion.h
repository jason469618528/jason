//
//  CustomerUpdateVersion.h
//  CoverPlateTest
//
//  Created by jason on 13-6-24.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerUpdateVersion : NSObject

+(void)updateVersionWithKey:(NSString *)key complete:(void (^)(void))complete;


+(void)resetWithKey:(NSString *)key;
@end
