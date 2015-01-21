//
//  ProductCell.h
//  PanliApp
//
//  Created by Liubin on 13-4-24.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIImageView.h"
#import "UserProduct.h"

/**************************************************
 * 内容描述: 订单列表cell
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-24
 **************************************************/
@interface ProductCell : UITableViewCell
{
    CustomUIImageView *img_Product;
    UIImageView *img_ProductType;
    UILabel *lab_ProductName;
    UILabel *lab_ProductPrice;
    UILabel *lab_ProductCount;
    UILabel *lab_SkuRemark;
    UIImageView *img_Forrbidden;
    UIImageView *img_Weight;
    UIImageView *img_ProductState;
    UIButton *btn_isNewMessage;
    UserProduct *mUserProduct;
}

- (void)setOrderDate:(UserProduct *)data withType:(OrderDisState)OrderState isFullWidth:(BOOL)fullWidthFlag isShipOrder:(BOOL)isShipOrders;

@end
