//
//  Guide.h
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 小指南问题
 * 创 建 人: 刘彬
 * 创建日期: 2013-11-04
 **************************************************/
@interface Guide : NSObject
{
    int _guideId;
    NSString * _guideName;
    NSString * _guideimage;
    int _type;
}

/**
 *id
 */
@property(nonatomic,assign) int guideId;

/**
 *名称
 */
@property (nonatomic, retain) NSString *guideName;

/**
 *图片
 */
@property (nonatomic, retain) NSString *guideImage;

/**
 *类型(1 常见问题)
 */
@property(nonatomic,assign) int type;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
