//
//  MenuTableViewCell.m
//  PanliBuyHD
//
//  Created by guo on 14-10-20.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UserInfo.h"
#import "ShipOrder.h"

@implementation MenuTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    NSLog(@"=-=-=-=awakeFromNib=-=-=-==");
    self.backgroundColor = PL_COLOR_CLEAR;
    
    //cell 的图片
    self.menuImageView.backgroundColor = PL_COLOR_CLEAR;
    
    //cell 静态 文字信息
    self.menuLabelName.textColor = [PanliHelper colorWithHexString:@"#444444"];
    self.menuLabelName.font = DEFAULT_FONT(16);
    self.menuLabelName.textAlignment = UITextAlignmentLeft;
    self.menuLabelName.backgroundColor = PL_COLOR_CLEAR;
    
    //cell 动态 文字信息
    lab_Message = [[DynamicLabelForUpDown alloc] initWithFrame:CGRectMake(135.0f, 10.0f, 152.5f, 20.0f)];
    lab_Message.textColor = [PanliHelper colorWithHexString:@"#b0b0b0"];
    lab_Message.font = DEFAULT_FONT(13);
    lab_Message.textAlignment = UITextAlignmentRight;
    lab_Message.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:lab_Message];
    
    //虚线
//    view_Line = [[UIView alloc] initWithFrame:CGRectMake(36.0f, 49.5f, MainScreenFrame_Width - 36.0f, 0.5f)];
//    view_Line.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
//    [self.contentView addSubview:view_Line];

    //短信显示数字
    img_Sys  = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 22.0f - 30.0f, 15.0f, 22.0f, 21.0f)];
    img_Sys.hidden = YES;
    
    img_Sys.image = [UIImage imageNamed:@"bg_myPanli_smallBadge"];
    [self.contentView addSubview:img_Sys];
    
    lab_Sys = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 16.0f)];
    lab_Sys.font = DEFAULT_FONT(15.0f);
    lab_Sys.backgroundColor = PL_COLOR_CLEAR;
    lab_Sys.textColor = [PanliHelper colorWithHexString:@"#eeeeef"];
    [img_Sys addSubview:lab_Sys];
}

- (void)initWithData:(NSString*)iStringTitle imageString:(NSString*)iImageString iRow:(NSIndexPath*)indexPath tabBottomLine:(BOOL)isBomLineFlag systemMessageCount:(int)iCount
{
    img_Sys.hidden = YES;
    img_Sys.alpha = 0.0;
    
    self.menuImageView.image = [UIImage imageNamed:iImageString];
    self.menuLabelName.text = iStringTitle;
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    
//    if(isBomLineFlag)
//    {
//        view_Line.hidden = NO;
//    }
//    else
//    {
//        view_Line.hidden = YES;
//    }
    
    //未登录状态
    if(!mUserInfo)
    {
        [lab_Message animateWithWords:nil forDuration:1.0f defaults:nil];
        return;
    }
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    NSMutableArray *msgArray = [[NSMutableArray alloc] init];
                    NSMutableArray *lastShipList = [GlobalObj getLastShipList];
                    [lastShipList filterUsingPredicate:[NSPredicate predicateWithFormat:@"self.haveRead = 0"]];
                    for (ShipOrder *item in lastShipList)
                    {
                        if (item.status == Deliverd)
                        {
                            [msgArray addObject:[NSString stringWithFormat:LocalizedString(@"MenuTableViewCell_msgArray_item1", @"%@已发货"),item.orderId]];
                        }
                        else if (item.status == IncorrectInfo || item.status == Untransportable)
                        {
                            [msgArray addObject:[NSString stringWithFormat:LocalizedString(@"MenuTableViewCell_msgArray_item2", @"%@存在异常"),item.orderId]];
                        }
                    }
                    [lab_Message animateWithWords:msgArray forDuration:4.0f defaults:@""];
                    break;
                }
//                case 1:
//                {
//                    NSMutableArray *msgArray = [[NSMutableArray alloc] init];
//                    NSMutableArray *lastShipList = [GlobalObj getLastShipList];
//                    [lastShipList filterUsingPredicate:[NSPredicate predicateWithFormat:@"self.haveRead = 0"]];
//                    for (ShipOrder *item in lastShipList)
//                    {
//                        if (item.status == Deliverd)
//                        {
//                            [msgArray addObject:[NSString stringWithFormat:@"%@已发货",item.orderId]];
//                        }
//                        else if (item.status == IncorrectInfo || item.status == Untransportable)
//                        {
//                            [msgArray addObject:[NSString stringWithFormat:@"%@存在异常",item.orderId]];
//                        }
//                    }
//                    [lab_Message animateWithWords:msgArray forDuration:4.0f defaults:@""];
//                    break;
//                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //余额
                    float balance = [[NSString stringWithFormat:@"%.2f",mUserInfo.balance] floatValue];
                    [lab_Message animateWithWords:nil forDuration:1.0f defaults:[NSString stringWithFormat:@"%@",[PanliHelper getCurrencyStyle:balance]]];
                    break;
                }
                case 1:
                {
                    //优惠券
                    [lab_Message animateWithWords:nil forDuration:1.0f defaults:(mUserInfo.couponNumber <= 0 ? @"":
                                                                                 [NSString stringWithFormat:LocalizedString(@"MenuTableViewCell_labMessage", @"%d张可用"),mUserInfo.couponNumber])];
                    break;
                }
                case 2:
                {
                    //积分
                    [lab_Message animateWithWords:nil forDuration:1.0f defaults:[NSString stringWithFormat:@"%d",mUserInfo.integration]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
            
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    img_Sys.hidden = NO;
                    
                    //重新计算短信数字和背景
                    int numberValue = [[NSString stringWithFormat:@"%d",iCount] intValue];
                    //谈出动画
                    [UIView beginAnimations:@"HideArrow" context:nil];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                    [UIView setAnimationDuration:1];
                    img_Sys.alpha = 1;
                    [UIView commitAnimations];
                    
                    if(numberValue >= 1 && numberValue < 10)
                    {
                        img_Sys.hidden = NO;
                        UIImage *img = [UIImage imageNamed:@"bg_myPanli_smallBadge"];
                        img_Sys.image = img;
                        lab_Sys.frame = CGRectMake(6.4f, 2.0f, 20.0f, 16.0f);
                        lab_Sys.text = [NSString stringWithFormat:@"%d",numberValue];
                        img_Sys.frame = CGRectMake(img_Sys.frame.origin.x, img_Sys.frame.origin.y, 22.0f, 21.0f);
                    }
                    else if(numberValue >= 10 && numberValue < 100)
                    {
                        img_Sys.hidden = NO;
                        UIImage *img = [UIImage imageNamed:@"bg_myPanli_middleBadge"];
                        img_Sys.image = img;
                        lab_Sys.frame = CGRectMake(5.4f, 2.0f, 20.0f, 16.0f);
                        lab_Sys.text = [NSString stringWithFormat:@"%d",numberValue];
                        img_Sys.frame = CGRectMake(img_Sys.frame.origin.x, img_Sys.frame.origin.y, 28.0f, 21.0f);
                    }
                    else if(numberValue >= 100)
                    {
                        img_Sys.hidden = NO;
                        UIImage *img = [UIImage imageNamed:@"bg_myPanli_bigBadge"];
                        img_Sys.image = img;
                        lab_Sys.text = @"99+";
                        lab_Sys.frame = CGRectMake(5.6f, 2.0f, 30.0f, 16.0f);
                        img_Sys.frame = CGRectMake(MainScreenFrame_Width-60, img_Sys.frame.origin.y, 36.0f, 21.0f);
                    }
                    else
                    {
                        img_Sys.hidden = YES;
                    }
                    
                    break;
                }
                case 1:
                {
                    
                    break;
                }
                case 2:
                {
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 3:
            switch (indexPath.row) {
                case 0:
                    self.menuImageView.image = [UIImage imageNamed:iImageString];
                    self.menuLabelName.text = iStringTitle;
                    [lab_Message animateWithWords:nil forDuration:1.0f defaults:nil];
                    break;
                    
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    NSLog(@"-=-=-=-setSelected:-=-=-=-=");
    // Configure the view for the selected state
}

@end
