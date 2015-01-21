//
//  HelpBuyProductDetail.h
//  PanliBuyHD
//
//  Created by jason on 14-6-20.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIImageView.h"
#import "SnatchProducts.h"
#import "CustomerSkusView.h"
#import "SkuCombination.h"
#import "CustomerSkusView.h"
typedef enum helpBuyLodingStyte
{
    loading = 1,
    success = 2,
    error = 3,
}helpBuyLodingType;
@protocol helpbuySkuDelegate <NSObject>
- (void)didSelectSku:(SkuCombination*)iSkuCombination productCount:(int)count productRemark:(NSString*)remark;
- (void)hideDetail;
@end

@interface HelpBuyProductDetail : UIView<CustomerSkusViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView *mainScrollView;
    //半透明
    UIControl *shadowView;
    //款式view高度
    float skuViewHeight;
    //款式
    CustomerSkusView *skuView;
    //商品单价
    float singlePrice;
    //页面显示数据
    CustomUIImageView *img_Product;
    UILabel *lab_ProductName;
    UILabel *lab_Price;
    
    //数量 备注 我要代购
    UIView *view_Other;
    UITextField *txt_Count;
    UITextView *txt_Remark;
    
    //滑动后退手势
    UIPanGestureRecognizer *panGestureRecognizer;
    /**
     *错误状态
     */
    UIView *noneDataView;
}
/**
 *数据源
 */
@property (nonatomic, strong) SnatchProducts *mSnatchProducts;
/**
 *保存sku选中数据
 */@property (nonatomic, strong) SkuCombination *selectSkuCombination;
/**
 *点击sku委托
 */
@property (nonatomic, unsafe_unretained) id<helpbuySkuDelegate> skuDelegate;
/**
 *初始化view
 */
- (void)reloadView:(helpBuyLodingType)viewType data:(SnatchProducts*)iSnatchProducts;
@end
