//
//  CustomerUpdateVersion.m
//  CoverPlateTest
//
//  Created by jason on 13-6-24.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "CustomerUpdateVersion.h"

@implementation CustomerUpdateVersion

+(void)updateVersionWithKey:(NSString *)key complete:(void (^)(void))complete
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *flag = [userDefault objectForKey:key];
    if ([NSString isEmpty:flag]) {
        complete();
        [userDefault setValue:key forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        return;
    }
}


+(void)resetWithKey:(NSString *)key
{
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:nil forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
