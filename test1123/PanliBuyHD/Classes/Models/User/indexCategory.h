//
//  indexCategory.h
//  PanliBuyHD
//
//  Created by jason on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface indexCategory : NSObject
{
    NSString *_str_Name;
    
    NSString *_str_Url;
}

/**
 *第三方网购名字
 */
@property (nonatomic, strong) NSString *str_Name;
/**
 *第三方网购URL
 */
@property (nonatomic, strong) NSString *str_Url;

@end
