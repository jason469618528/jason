//
//  ShareBuyDetail.h
//  PanliApp
//
//  Created by jason on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareBuyDetail : NSObject
{
    NSString *_nickname;
    float _score;
    NSString *_message;
    NSMutableArray *_pictureArray;
    NSString *_dateShare;
}
/**
 *用户昵称
 */
@property (nonatomic, retain) NSString * nickname;

/**
 *评分
 */
@property (nonatomic, assign) float  score;

/**
 *留言
 */
@property (nonatomic, retain) NSString * message;

/**
 *图片列表
 */
@property (nonatomic, retain) NSMutableArray * pictureArray;

/**
 *分享时间
 */
@property (nonatomic, retain) NSString * dateShare;

/**
 *实例化对象
 */
- (id)initWithDictionary:(NSDictionary *)iDictionary;
@end
