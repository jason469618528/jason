//
//  FavoriteShopCell.h
//  PanliBuyHD
//
//  Created by guo on 14-10-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteShopCell : UITableViewCell
//店铺的图片
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
//店铺的名字
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//店铺来源图片
@property (weak, nonatomic) IBOutlet UIImageView *shopOriginImage;
//cell右侧的箭头
@property (weak, nonatomic) IBOutlet UIImageView *shopCellArrow;

@end
