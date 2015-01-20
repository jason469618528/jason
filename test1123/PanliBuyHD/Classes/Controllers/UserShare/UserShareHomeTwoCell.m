//
//  UserShareHomeTwoCell.m
//  PanliApp
//
//  Created by Liubin on 13-12-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareHomeTwoCell.h"

@implementation UserShareHomeTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 75.0f, 75.0f)];
        view.backgroundColor = PL_COLOR_WHITE;
        view.layer.borderColor = [PanliHelper colorWithHexString:@"#DEDEDE"].CGColor;
        view.layer.borderWidth = 0.5;
        [self.contentView addSubview:view];
        [view release];

        //商品缩略图
        img_Product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, 70.0f, 70.0f)];
		[view addSubview:img_Product];
        [img_Product release];
        
        //商品名称
        lab_ProductName = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 10.0f, MainScreenFrame_Height - 340.0f, 50.0f)];
        lab_ProductName.numberOfLines = 2;
        lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#4e4e4f"];
        lab_ProductName.font = DEFAULT_FONT(14);
        lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
        [self.contentView addSubview:lab_ProductName];
        [lab_ProductName release];
        
        //给力
        img_praise = [[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 65.0f, 86.0f, 20.0f)];
        img_praise.image = [UIImage imageNamed:@"icon_userShare_praise"];
        [self.contentView addSubview:img_praise];
        [img_praise release];
        
        lab_PraiseCount = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 0.0f, 60.0f, 20.0f)];
        lab_PraiseCount.numberOfLines = 1;
        lab_PraiseCount.textColor = PL_COLOR_WHITE;
        lab_PraiseCount.font = DEFAULT_FONT(14);
        lab_PraiseCount.backgroundColor = PL_COLOR_CLEAR;
        [img_praise addSubview:lab_PraiseCount];
        [lab_PraiseCount release];
        
        UIImageView *img_line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 99.0f, MainScreenFrame_Width, 1.0f)];
        img_line.image = [UIImage imageNamed:@"icon_CartSubmit_Line"];
        [self.contentView addSubview:img_line];
        [img_line release];

    }
    return self;
}

- (void)setData:(ShareProduct *)mProduct
{
    [img_Product setCustomImageWithURL:[NSURL URLWithString:mProduct.thumbnail] placeholderImage:[UIImage imageNamed:@"bg_SubjectNone_Product"]];
    lab_ProductName.text = mProduct.productName;
    NSString *praiseCountStr = [NSString stringWithFormat:LocalizedString(@"UserShareHomeTwoCell_praiseCountStr",@"给栗%d人"),mProduct.numberOfPraise];
    CGSize size = [praiseCountStr sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(180, 20) lineBreakMode:NSLineBreakByCharWrapping];
    UIImage *image = [UIImage imageNamed:@"icon_userShare_praise"];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    img_praise.frame = CGRectMake(90.0f, 65.0f, size.width+35, 20.0f);
    img_praise.image = image;
    lab_PraiseCount.text = praiseCountStr;
    lab_PraiseCount.frame = CGRectMake(25.0f, 0.0f, size.width, 20.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
