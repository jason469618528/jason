//
//  UserScore.h
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserScore : NSObject
{
    int _type;
    int _score;
    NSString *_description;
    NSString *_tradeTime;
}
/**
 *类型(1:获得积分 2:消耗积分)
 */
@property (nonatomic, assign) int type;

/**
 *积分
 */
@property (nonatomic, assign) int score;

/**
 *说明
 */
@property (nonatomic, retain) NSString *description;

/**
 *交易时间
 */
@property (nonatomic, retain) NSString *tradeTime;

- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
