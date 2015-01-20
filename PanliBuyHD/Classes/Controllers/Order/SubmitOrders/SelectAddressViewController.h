//
//  SelectAddressViewController.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "DeliveryAddress.h"
#import "GetShipCountryRequest.h"
#import "SelectAddressCell.h"
#import "DeleteUserAddressRequest.h"
#import "GetDeliyAddressRequest.h"

/**
 *  内容描述: 选择提交地址
 *  创 建 人: Tommy
 *  创建日期: 2014-4-22
 */
@interface SelectAddressViewController : BaseViewController<UIAlertViewDelegate,SelectAddressDelegate>
{
    //请求运送区域
    GetShipCountryRequest *req_ShipCountry;
    DataRepeater *rpt_ShipCountry;
    
    //删除收货地址
    DeleteUserAddressRequest *req_Delete;
    DataRepeater *rpt_Delete;
    
    //请求地址
    GetDeliyAddressRequest *req_GetAddress;
    DataRepeater *data_GetAddress;
    
    //运送地址id
    int iDeliveryAddressID;

}
@property (weak, nonatomic) IBOutlet UITableView *tab_Address;
@property(nonatomic,strong)NSArray *arr_OrderList;
@property(nonatomic,copy)NSString *str_CountID;

@property(nonatomic,assign)int viewType; //0. 提交运送 1. 收货地址更改

@property (nonatomic, assign) NSInteger IsSelect;
@property (nonatomic, strong) NSMutableArray * mArr_UserAddress;
@end
