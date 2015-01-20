//
//  MyCouponViewController.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerExceptionView.h"
#import "GetCouponRequest.h"
#import "BaseViewController.h"

@interface MyCouponViewController : BaseViewController
{
    NSArray *arr_Coupon;
    CustomerExceptionView *exceptionView;
    
    //当前选中的优惠券编号
    NSString *current_CouponCode;
    
    GetCouponRequest *req_Coupon;
    DataRepeater *rpt_Coupon;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
