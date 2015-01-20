//
//  UserShareHomeCell.h
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIButton.h"
#import "ShareProduct.h"

/**************************************************
 * 内容描述: 用户分享已到货cell
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-10
 **************************************************/
@protocol UserShareHomeCellDelegate <NSObject>

@required
-(void)ShareWithProduct:(ShareProduct *)product;

@end

@interface UserShareHomeCell : UITableViewCell
{
    NSMutableArray *btn_Array;
}

@property (nonatomic, assign) NSUInteger column;

/**
 *商品数据
 */
@property (nonatomic, retain) NSArray *productArray;

@property (nonatomic, assign) id<UserShareHomeCellDelegate> delegate;

- (void)setData:(NSArray *)dataArray;

@end
