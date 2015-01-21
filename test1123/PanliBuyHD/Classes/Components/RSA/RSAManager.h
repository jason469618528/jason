//
//  RSAManager.h
//  PanliApp
//
//  Created by Liubin on 13-8-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface RSAManager : NSObject

+ (NSData *)encryptToData:(NSString *)plainText error:(NSError **)err;

+ (NSString *)encryptToString:(NSString *)plainText error:(NSError **)err;

@end
