//
//  RechargeViewController.h
//  PanliApp
//
//  Created by jason on 13-4-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "RechargeInfoRequest.h"
#import "RechargeOrCreateRequest.h"
#import "PaypalNotifyRequest.h"
#import "BaseViewController.h"

/**************************************************
 * 内容描述: 冲值页面
 * 创 建 人: jason
 * 创建日期: 2013-4-19
 **************************************************/

/**
 *支付类型
 */
typedef enum
{
    //账户充值
    Recharge,
    //余额不足,先充值再支付
    BalanceNotEnough,
    //余额充足,直接支付
    BalanceEnough,
    
}PayType;

@interface RechargeViewController : BaseViewController<PayPalPaymentDelegate,UITextFieldDelegate>
{
    //获取充值信息
    RechargeInfoRequest *req_RegeInfo;
    DataRepeater *rpt_RegeInfo;
    
    //生成充值订单
    RechargeOrCreateRequest *req_RegeCreate;
    DataRepeater *rpt_RegeCreate;
    
    //与服务器对账
    PaypalNotifyRequest *req_RegeNotify;
    DataRepeater *rpt_RegeNotify;

    //充值金额
    UITextField *txt_InputMoney;

    //实际到账
    UILabel *lab_DealMoney;
    
    //汇率.手续费
    UILabel *lab_PayDetail;
    
    //当前充值金额(美金)
    float currentUSAMoney;
    /**
     *损失汇率
     */
    float lossRate;
    /**
     *损失美金
     */
    float baseFee;
    /**
     *美元汇率
     */
    float dollarRate;
    /**
     *充值状态
     */
    int rechargeType;
    /**
     *生成的充值订单号
     */
    NSString *str_CallbackUrl;
    
    //支付按钮
    UIButton *btn_payPalTest;
    //账户余额
    UILabel *lab_Balance;
    //还需支付
    UILabel *lab_LittleMoney;
}
@property(nonatomic,retain) UIToolbar *keyboardToolbar;

/**
 *type 0为充值 1为(余额不足时)支付 2(余额充足时)支付
 */
@property (nonatomic, assign) PayType payTypeFlag;
/**
 *应付金额
 */
@property (nonatomic, assign) float shouldPayMoney;

/**
 *支付请求DataRepeater
 */
@property (nonatomic, retain) DataRepeater * rpt_DataRepeater;

/**
 *支付成功页面
 */
@property (nonatomic,retain) UIViewController * successViewController;

@end
