//
//  UserShareHomeCell.m
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareHomeCell.h"

#define IMAGE_WIDTH  90.0f
#define IMAGE_HEIGHT 90.0f
#define IMAGE_MARGIN 12.0f

@implementation UserShareHomeCell
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    self.productArray = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = PL_COLOR_CLEAR;
        
        self.column = 6;
        
        btn_Array = [[NSMutableArray alloc] initWithCapacity:self.column];
        
        for (NSUInteger i = 0; i < self.column; i++) {
            CustomUIButton *btn = [[CustomUIButton alloc] initWithFrame:CGRectMake(i * IMAGE_MARGIN + i * IMAGE_WIDTH + IMAGE_MARGIN, IMAGE_MARGIN + IMAGE_MARGIN, IMAGE_WIDTH, IMAGE_HEIGHT)];
            btn.tag = 1000 + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setHidden:YES];
            [btn_Array addObject:btn];
            [self.contentView addSubview:btn];
            [btn release];
            
        }
    }
    return self;
}

/**
 * 功能描述: 设置cell数据
 * 输入参数: dataArray 数据源
 * 返 回 值: N/A
 */
- (void)setData:(NSArray *)dataArray
{
    if (!dataArray || dataArray.count == 0)
    {
        return;
    }
    for (NSUInteger i = 0; i < dataArray.count; i++) {
        CustomUIButton * btn = (CustomUIButton *)[btn_Array objectAtIndex:i];
        [btn setHidden:NO];
        
        ShareProduct *mProduct = [dataArray objectAtIndex:i];
        //                [btn_left setCustomImageWithURL:[NSURL URLWithString:mProduct.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed: @"bg_SubjectNone_Product"]];
        [btn setCustomImageWithURL:[NSURL URLWithString:mProduct.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed: @"bg_SubjectNone_Product"]];
        [btn layer].borderColor = [PanliHelper colorWithHexString:@"#DFDFDF"].CGColor;
        [btn layer].borderWidth = 0.5;
    }
    
    self.productArray = dataArray;
}

/**
 * 功能描述: 选择商品
 * 输入参数: btn
 * 返 回 值: N/A
 */
- (void)btnClick:(UIButton *)btn
{
    NSInteger i = btn.tag - 1000;
    if (self.productArray && self.productArray.count > i)
    {
        ShareProduct *mProduct = [self.productArray objectAtIndex:i];
        if (self.delegate && [self.delegate respondsToSelector:@selector(ShareWithProduct:)])
        {
            [self.delegate ShareWithProduct:mProduct];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
