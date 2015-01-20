//
//  CustomerSkusView.h
//  PanliApp
//
//  Created by Liubin on 13-6-20.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 自定义款式选择视图
 * 创 建 人: 刘彬
 * 创建日期: 2013-06-20
 **************************************************/
#import <UIKit/UIKit.h>
#import "SkuObject.h"
#import "SkuCombination.h"

@protocol CustomerSkusViewDelegate <NSObject>

@required

//- (void)viewDidDrawDone:(float)height;

- (void)skuCombinationDidChange:(SkuCombination *)skuCombination;

- (void)updateSelectSkuImageView:(SkuObject*)iSkuObject;

@end

@interface CustomerSkusView : UIView
{
    //款式分类
    NSMutableArray *mArr_skuType;
    
    //款式未选中背景
    UIImage *img_propertyBtnBackground;
    
    //款式选中背景
    UIImage *img_propertyBtnSelectBackground;
    
    //按钮数组
    NSMutableArray *mArr_propertyBtns;
    
    //选中的skuid集合
    NSMutableArray *mArr_selectSkuIds;
    
    //选中的SkuCombination
    SkuCombination *selectSkuCombination;
    
}

@property (nonatomic, strong) NSArray *mArr_skus;
@property (nonatomic, strong) NSArray *mArr_skuCombinations;
@property (nonatomic, unsafe_unretained) id<CustomerSkusViewDelegate> skuDelegate;

- (id)initWithFrame:(CGRect)frame skus:(NSArray *)skuArr skuCombinations:(NSArray *)skuCombinations;
@end
