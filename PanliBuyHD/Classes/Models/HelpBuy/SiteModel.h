//
//  SiteModel.h
//  PanliApp
//
//  Created by jason on 13-6-27.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiteModel : NSObject

{
    NSString *_siteName;
    NSString *_siteUrl;
    NSString *_logo;
}


/**
 *站点名称
 */
@property (nonatomic, strong)  NSString * siteName;

/**
 *站点Url
 */
@property (nonatomic, strong)  NSString * siteUrl;

/**
 *图片
 */
@property (nonatomic, strong)  NSString * logo;

- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
