//
//  FavoriteProductsCell.h
//  PanliBuyHD
//
//  Created by guo on 14-10-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteProductsCell : UITableViewCell

//收藏商品的 图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
//收藏商品的 名字
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
//收藏商品的 价格
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
//cell右侧的箭头
@property (weak, nonatomic) IBOutlet UIImageView *cell_Arrow;

@end
