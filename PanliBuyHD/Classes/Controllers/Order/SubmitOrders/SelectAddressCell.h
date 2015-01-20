//
//  SelectAddressCell.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryAddress.h"

@protocol SelectAddressDelegate <NSObject>
//type 1为确定 2为编辑 3为删除
- (void)selectAddressType:(int)type btnTag:(int)selectIndex;
@end

@interface SelectAddressCell : UITableViewCell
{
    //收件人
    UILabel *left_lab_Consignee;
    //电话
    UILabel *left_lab_Phone;
    //国家
    UILabel *left_lab_CountryAndCity;
    //地址和邮编
    UILabel *left_lab_AddressAndZip;
    //是否选中
    UIImageView *left_icon_IsSelectFlag;
    //是否选中背景
//    UIImageView *left_img_IsMain;
    //编辑
    UIButton *left_btn_Edit;
    //删除
    UIButton *left_btn_Delete;
    //确定
    UIButton *left_btn_Confirm;
    //标识
    int indexFlag;
    
    UIImageView *left_img_Logo;
    
    //收件人
    UILabel *right_lab_Consignee;
    //电话
    UILabel *right_lab_Phone;
    //国家
    UILabel *right_lab_CountryAndCity;
    //地址和邮编
    UILabel *right_lab_AddressAndZip;
    //是否选中
    UIImageView *right_icon_IsSelectFlag;
    //是否选中背景
//    UIImageView *right_img_IsMain;
    //编辑
    UIButton *right_btn_Edit;
    //删除
    UIButton *right_btn_Delete;
    //确定
    UIButton *right_btn_Confirm;
    
    UIImageView *right_img_Logo;
}


-(void)SendLeftDisplayData:(DeliveryAddress*)deliveryAddress isSelect:(BOOL)isSelect isIndex:(int)index iViewType:(int)viewType;

-(void)SendRightDisplayData:(DeliveryAddress*)deliveryAddress isSelect:(BOOL)isSelect isIndex:(int)index iViewType:(int)viewType;

-(void)hideRight;

-(void)resetRight;

@property (nonatomic, assign) id<SelectAddressDelegate> selectAddressDelegate;

@property (nonatomic, strong) UIImageView *left_img_IsMain;
@property (nonatomic, strong) UIImageView *right_img_IsMain;


@end
