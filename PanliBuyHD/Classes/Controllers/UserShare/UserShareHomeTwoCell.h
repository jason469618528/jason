//
//  UserShareHomeTwoCell.h
//  PanliApp
//
//  Created by Liubin on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareProduct.h"
#import "CustomUIImageView.h"
/**************************************************
 * 内容描述: 已分享和赞过的商品cell
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-13
 **************************************************/
@interface UserShareHomeTwoCell : UITableViewCell
{
    CustomUIImageView *img_Product;

    UILabel *lab_ProductName;
    
    UIImageView *img_praise;
    
    UILabel *lab_PraiseCount;
}

- (void)setData:(ShareProduct *)mProduct;

@end
