//
//  MyCouponCell.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#define rowcellCount 2
#define RMarginX 20
#define RMarginY 0

@interface MyCouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *left_CouponCode;
@property (weak, nonatomic) IBOutlet UILabel *left_Source;
@property (weak, nonatomic) IBOutlet UIImageView *left_bgImage;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *right_CouponCode;
@property (weak, nonatomic) IBOutlet UILabel *right_Source;
@property (weak, nonatomic) IBOutlet UIImageView *right_bgImage;
@property (weak, nonatomic) IBOutlet UIView *rightView;

- (void)setDataWithLeft:(Coupon *)left andRight:(Coupon *)right;

@end
