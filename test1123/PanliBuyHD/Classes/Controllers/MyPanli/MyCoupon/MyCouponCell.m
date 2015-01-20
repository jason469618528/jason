//
//  MyCouponCell.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyCouponCell.h"



@implementation MyCouponCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initView];
}

-(void) initView
{
    //有效期
    UILabel *lab_Validity = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 30.0f, 73.0f, 60.0f)];
    lab_Validity.backgroundColor = PL_COLOR_CLEAR;
    lab_Validity.font = DEFAULT_FONT(14.0f);
    lab_Validity.tag = 7004;
    lab_Validity.numberOfLines = 3;
    lab_Validity.hidden = YES;
    lab_Validity.textColor = [PanliHelper colorWithHexString:@"#f0f0f0"];
    [self.left_bgImage addSubview:lab_Validity];

    
    //使用状态
    UIImageView *img_Status = [[UIImageView alloc] initWithFrame:CGRectMake(192.0f, 0.0f, 106.5f, 94.5f)];
    img_Status.tag = 7005;
    img_Status.hidden = YES;
    img_Status.image = [UIImage imageNamed:@"icon_CouponHome_NoUable"];
    img_Status.backgroundColor = PL_COLOR_CLEAR;
    [self.left_bgImage addSubview:img_Status];
    
    //有效期
    UILabel *right_Validity = [[UILabel alloc] initWithFrame:CGRectMake(210.0f, 30.0f, 73.0f, 60.0f)];
    right_Validity.backgroundColor = PL_COLOR_CLEAR;
    right_Validity.font = DEFAULT_FONT(14.0f);
    right_Validity.tag = 7004;
    right_Validity.numberOfLines = 3;
    right_Validity.hidden = YES;
    right_Validity.textColor = [PanliHelper colorWithHexString:@"#f0f0f0"];
    [self.right_bgImage addSubview:right_Validity];
    
    
    //使用状态
    UIImageView *right_Status = [[UIImageView alloc] initWithFrame:CGRectMake(192.0f, 0.0f, 106.5f, 94.5f)];
    right_Status.tag = 7005;
    right_Status.hidden = YES;
    right_Status.image = [UIImage imageNamed:@"icon_CouponHome_NoUable"];
    right_Status.backgroundColor = PL_COLOR_CLEAR;
    [self.right_bgImage addSubview:right_Status];
    

}

- (void)setDataWithLeft:(Coupon *)left andRight:(Coupon *)right
{
    //优惠券编号
    [self.left_CouponCode setText:[NSString stringWithFormat:LocalizedString(@"MyCouponViewController_labCouponCode",@"编号:%@"),left.code]];
    
    //来源
    [self.left_Source setText:[self getCouponSource:left.couponSource]];
    /**
     *状态 0-未激活 1-待使用 2-已使用 4-过期的，5-失效的 6-一个月内即将过期的
     */
    
    NSString *str_Image = [self getImageState:left.denomination couponType:left.status];
    
    //背景图片
    [self.left_bgImage setImage:[UIImage imageNamed:str_Image]];
    
    [self setValidityAndStatus:@"left" Data:left];
    if (right != nil) {
        
        //优惠券编号
        [self.right_CouponCode setText:[NSString stringWithFormat:LocalizedString(@"MyCouponViewController_labCouponCode",@"编号:%@"),right.code]];
        
        //来源
        [self.right_Source setText:[self getCouponSource:right.couponSource]];
        
        str_Image = [self getImageState:right.denomination couponType:right.status];
        
        [self.right_bgImage setImage:[UIImage imageNamed:str_Image]];
        [self setValidityAndStatus:@"right" Data:right];
    }
    else
    {
        self.rightView.hidden = YES;
        self.right_bgImage.hidden = YES;
        self.right_CouponCode.hidden = YES;
        self.right_Source.hidden = YES;
    }
    
    
}

- (void)setValidityAndStatus:(NSString *)orientation Data:(Coupon *)data
{
    //有效期
    UILabel *lab_Validity = nil;
    
    //使用状态
    UIImageView *img_Status = nil;
    
    if ([orientation isEqualToString:@"left"]) {
        lab_Validity = (UILabel *)[self.left_bgImage viewWithTag:7004];
        img_Status = (UIImageView*)[self.left_bgImage viewWithTag:7005];
    }
    else
    {
        lab_Validity = (UILabel *)[self.right_bgImage viewWithTag:7004];
        img_Status = (UIImageView*)[self.right_bgImage viewWithTag:7005];
    }
    
    
    if(data.status == 1 || data.status == 6)
    {
        lab_Validity.hidden = NO;
    }
    else
    {
        lab_Validity.hidden = YES;
    }
    
    if(data.status == 2)
    {
        img_Status.hidden = NO;
    }
    else
    {
        img_Status.hidden = YES;
    }
    
    [lab_Validity setText:[PanliHelper timestampToDateString:data.deadlineForActivation formatterString:LocalizedString(@"MyCouponViewController_labValidity",@"此优惠券有效期至yyyy-MM-dd")]];
}

#pragma mark - getCouponSource
- (NSString*)getCouponSource:(int)type
{
    switch (type)
    {
        case 1:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource1",@"积分兑换");
            break;
        }
        case 2:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource2",@"商城购买");
            break;
        }
        case 3:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource3",@"活动发放");
            break;
        }
        case 4:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource4",@"他人赠送");
            break;
        }
        case 5:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource5",@"抽奖获得");
            break;
        }
        case 6:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource6",@"抽奖获得");
            break;
        }
        case 7:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource7",@"优秀分享");
            break;
        }
        case 8:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource8",@"活动发放");
            break;
        }
        case 9:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource9",@"活动发放");
            break;
        }
        case 10:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource10",@"注册赠送");
            break;
        }
        case 11:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource11",@"系统赠送");
            break;
        }
        case 12:
        {
            return LocalizedString(@"MyCouponViewController_CouponSource12",@"活动发放");
            break;
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - GetCell Image
- (NSString*)getImageState:(float)denomination couponType:(int)type
{
    /**
     *type 0-未激活 1-待使用 2-已使用 4-过期的，5-失效的 6-一个月内即将过期的
     */
    if(denomination == 5)
    {
        if(type == 0 || type == 4 || type == 5)
        {
            return @"btn_CouponHome_Five_NO";
        }
        else
        {
            return @"btn_CouponHome_Five_On";
        }
    }
    else if(denomination == 10)
    {
        if(type == 0 || type == 4 || type == 5)
        {
            return @"btn_CouponHome_Ten_NO";
        }
        else
        {
            return @"btn_CouponHome_Ten_On";
        }
        
    }
    else if(denomination == 20)
    {
        if(type == 0 || type == 4 || type == 5)
        {
            return @"btn_CouponHome_twenty_NO";
        }
        else
        {
            return @"btn_CouponHome_twenty_On";
        }
    }
    else if(denomination == 50)
    {
        if(type == 0 || type == 4 || type == 5)
        {
            return @"btn_CouponHome_fifty_NO";
        }
        else
        {
            return @"btn_CouponHome_fifty_On";
        }
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
