//
//  OrderProCell.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-19.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "OrderProCell.h"

@implementation OrderProCell

- (void)awakeFromNib
{
    [self.img_product.layer setBorderWidth:1.0f];
    [self.img_product.layer setBorderColor:[PanliHelper colorWithHexString:@"#c8c9c6"].CGColor];
    self.lab_proName.textColor = [PanliHelper colorWithHexString:@"#858585"];
    self.lab_price.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
    self.lab_proSku.textColor = [PanliHelper colorWithHexString:@"#9b9b9b"];
    self.lab_number.textColor = [PanliHelper colorWithHexString:@"#9b9b9b"];
}

- (void)initWithProduct:(UserProduct *)mProduct hiddenButton:(BOOL)hidden
{
    self.mProduct = mProduct;
    self.lab_proName.text = mProduct.productName;
    self.lab_proSku.text = mProduct.skuRemark;
    self.lab_price.text = [NSString stringWithFormat:@"￥%.2f",mProduct.price];
    [self.img_product setCustomImageWithURL:[NSURL URLWithString:mProduct.thumbnail]];
    if (mProduct.isSelected)
    {
        [self.btn_select setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect_on"] forState:UIControlStateNormal];
        [self.btn_select setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.btn_select setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect"] forState:UIControlStateNormal];
        [self.btn_select setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect_on"] forState:UIControlStateHighlighted];
    }
    //是否拼单购
    if (mProduct.isPiece)
    {
        [self.img_type setImage:[UIImage imageNamed:@"img_order_group"]];
    }
    else if (mProduct.isGroup)
    {
        [self.img_type setImage:[UIImage imageNamed:@"img_order_join"]];
    }
    else
    {
        [self.img_type setImage:nil];
    }
    
    //敏感
    if (mProduct.isForbidden)
    {
        [self.icon_m setImage:[UIImage imageNamed:@"icon_order_m"]];
    }
    else
    {
        [self.icon_m setImage:nil];
    }
    //超重
    if (mProduct.isLightOverWeight)
    {
        [self.icon_z setImage:[UIImage imageNamed:@"icon_order_z"]];
    }
    else
    {
        [self.icon_z setImage:nil];
    }
    
    if (mProduct.isYellovWarning)
    {
        self.backgroundView.backgroundColor = [PanliHelper colorWithHexString:@"#fffbbb"];
    }
    else if (mProduct.isRedWarning)
    {
        self.backgroundView.backgroundColor = [PanliHelper colorWithHexString:@"#ffe2e1"];
    }
    else
    {
        self.backgroundView.backgroundColor = [PanliHelper colorWithHexString:@"#f3f3f3"];
    }
    
    if (hidden)
    {
        for (UIView *view in self.contentView.subviews)
        {
            CGRect rect = view.frame;
            rect.origin.x -= self.btn_select.frame.size.width;
            view.frame = rect;
        }
        self.lab_number.text = [NSString stringWithFormat:LocalizedString(@"OrderProCell_labNumber1", @"数量:%d"),mProduct.count];
        
    }
    else
    {
        self.lab_number.text = [NSString stringWithFormat:LocalizedString(@"OrderProCell_labNumber2", @"数量:%d（%d克）"),mProduct.count,mProduct.weight];

    }
    self.btn_select.hidden = hidden;
}

-(IBAction)onSelected:(id)sender
{
    UIButton *button = sender;
    if (self.mProduct.isSelected)
    {
        self.mProduct.isSelected = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect_on"] forState:UIControlStateHighlighted];
    }
    else
    {
        self.mProduct.isSelected = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect_on"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_padSC_isSelect"] forState:UIControlStateHighlighted];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CELLCHECK" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
