//
//  IYBSlideLabel.h
//  iYunBao
//
//  Created by iyb-hj on 2017/8/18.
//  Copyright © 2017年 iYunBao. All rights reserved.
//

//  describe  个人中心金额变更使用的label

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ADTickerLabelScrollDirection){
    ADTickerLabelScrollDirectionUp,
    ADTickerLabelScrollDirectionDown
};

@interface IYBSlideLabel : UILabel
/*
 Default ADTickerLabelScrollDirectionUp
 */
@property (nonatomic, assign) ADTickerLabelScrollDirection scrollDirection;
/*
 Default 0.8
 */
@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, copy) NSString *slideText;

-(void)setText:(NSString *)text animated:(BOOL)animated;

@end
