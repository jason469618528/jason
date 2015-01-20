//
//  AddShipAddressViewController.h
//  PanliApp
//
//  Created by jason on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryAddress.h"
#import "AddChangeAddressRequest.h"
#import "BaseViewController.h"

/**************************************************
 * 内容描述: 新增 ，修改地址
 * 创 建 人: jason
 * 创建日期: 2013-4-24
 **************************************************/
@interface AddShipAddressViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate>
{
   // 新增 ，修改地址请求
    AddChangeAddressRequest *req_AddChangeAddress;
    DataRepeater *data_AddChangeAddress;
    
    UITextView *text_Consignee;
    UIButton *btn_Country;
    UITextView *text_City;
    UITextView *text_Address;
    UITextView *text_Zip;
    UITextView *text_Phone;
    
    NSString *str_Consignee;
    NSString *str_Country;
    NSString *str_City;
    NSString *str_Address;
    NSString *str_Zip;
    NSString *str_Phone;
    
    NSString *str_CountryID;
    
}

/**
 *修改收货地址
 */
@property(nonatomic,strong)DeliveryAddress *m_AddressObject;
/**
 *添加收货地址
 */
@property(nonatomic,strong)NSMutableArray *mArr_AddressData;

/**
 *提交运送商品组合
 */
@property (nonatomic, strong) NSArray * arr_OrderList;

/**
 *0. 提交运送 1. 收货地址更改
 */
@property(nonatomic,assign)int viewType; //0. 提交运送 1. 收货地址更改

/**
 *判断是否新加
 */
@property (nonatomic, assign) BOOL isNewAdd;

@end
