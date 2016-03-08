//
//  PanliMoneyCell.m
//  JasonBlog
//
//  Created by jason on 15/6/9.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "PanliMoneyCell.h"

@interface PanliMoneyCell()
/**
 *控件
 */
@property (strong, nonatomic) IBOutlet UIImageView *img_State;
@property (strong, nonatomic) IBOutlet UILabel *lab_State;
@property (strong, nonatomic) IBOutlet UILabel *lab_GetTime;
@property (strong, nonatomic) IBOutlet UILabel *lab_GetSource;
@property (strong, nonatomic) IBOutlet UILabel *lab_Money;

/**
 *约束
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *time_Y;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labTime_Y;

@end


@implementation PanliMoneyCell

- (void)awakeFromNib
{
    // Initialization code
    //已使用
//    _lab_State.hidden = YES;
//    _labTime_Y.constant = -5;
//    _time_Y.constant = -2.2;
    //已过期
//    _lab_State.text = @"已过期";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
