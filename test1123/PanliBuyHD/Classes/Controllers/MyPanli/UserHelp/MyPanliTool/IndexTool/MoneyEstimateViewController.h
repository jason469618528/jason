//
//  MoneyEstimateViewController.h
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"

/**************************************************
 * 内容描述: 费用估算
 * 创 建 人: Jason
 * 创建日期: 2013-05-13
 **************************************************/
@interface MoneyEstimateViewController : BaseViewController<UITextFieldDelegate>
{
    UIButton *btn_Area;
    UITextField *txt_Price;
    UITextField *txt_Weight;
    NSString *str_Country;
}
@end
