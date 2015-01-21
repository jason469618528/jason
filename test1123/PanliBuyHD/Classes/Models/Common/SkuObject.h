//
//  SkuObject.h
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkuObject : NSObject

{
    NSString *_skuId;
    NSString *_propertyName;
    NSString *_typeName;
    NSString *_picUrl;
    NSString *_thumbnailUrl;
}

/**
 *Skuid
 */
@property (nonatomic, strong) NSString *skuId;

/**
 *属性中文名字串
 */
@property (nonatomic, strong) NSString *propertyName;

/**
 *属性类别名称
 */
@property (nonatomic, strong) NSString *typeName;

/**
 *属性图片原图
 */
@property (nonatomic, strong) NSString *picUrl;

/**
 *缩略图
 */
@property (nonatomic, strong) NSString *thumbnailUrl;

- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
