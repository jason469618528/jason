//
//  MyJoinCell.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyJoinCell.h"

@implementation MyJoinCell

- (void)awakeFromNib
{
    [self initView];
}

- (void)initView{
    //商品缩略图
    img_product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 80.0f, 80.0f)];
    img_product.layer.masksToBounds = YES;
    img_product.layer.cornerRadius = 6.0f;
    img_product.layer.borderColor = [[PanliHelper colorWithHexString:@"#BDCAD1"] CGColor];
    img_product.layer.borderWidth = 0.5f;
    [self.contentView addSubview:img_product];
}

-(void)SetDataDisplay:(MyJoinGroupBuyProduct*)m_JoinProduct
{
    [img_product setCustomImageWithURL:[NSURL URLWithString:m_JoinProduct.thumbnail]
                      placeholderImage:[UIImage imageNamed:@"icon_product"]];
    NSString *str_SkuRemark = [NSString stringWithFormat:LocalizedString(@"MyJoinCell_strSkuRemark",@"备注:%@"),m_JoinProduct.skuRemark];
    CGSize skuSize = [str_SkuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(210.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    self.lab_productSkuRemark.frame = CGRectMake(100.0f, 70.0f, skuSize.width, skuSize.height);
    self.lab_productName.text = [NSString stringWithFormat:@"%@",m_JoinProduct.productName];
    self.lab_productPrice.text = [NSString stringWithFormat:@"￥%.2f    x%d",m_JoinProduct.price,m_JoinProduct.buyNum];
    self.lab_productRemark.text = [NSString stringWithFormat:LocalizedString(@"MyJoinCell_labProductRemark",@"备注:%@"),[NSString isEmpty:m_JoinProduct.remark] ? LocalizedString(@"MyJoinCell_mJoinProduct",@"暂无") : m_JoinProduct.remark];
    self.lab_productSkuRemark.text = [NSString isEmpty:m_JoinProduct.skuRemark] ? LocalizedString(@"MyJoinCell_mJoinProduct",@"暂无"): m_JoinProduct.skuRemark;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
