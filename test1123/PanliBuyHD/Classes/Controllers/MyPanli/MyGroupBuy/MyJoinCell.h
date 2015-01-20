//
//  MyJoinCell.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyJoinGroupBuyProduct.h"
#import "CustomUIImageView.h"

@interface MyJoinCell : UITableViewCell
{
    CustomUIImageView *img_product;
}

@property (weak, nonatomic) IBOutlet UILabel *lab_productName;
@property (weak, nonatomic) IBOutlet UILabel *lab_productPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_productRemark;
@property (weak, nonatomic) IBOutlet UILabel *lab_productSkuRemark;

-(void)SetDataDisplay:(MyJoinGroupBuyProduct*)m_JoinProduct;

@end
