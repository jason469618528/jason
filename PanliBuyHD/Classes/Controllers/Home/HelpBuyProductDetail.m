//
//  HelpBuyProductDetail.m
//  PanliBuyHD
//
//  Created by jason on 14-6-20.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "HelpBuyProductDetail.h"
#import "SkuObject.h"
#define COUNT_REMARK_BUTTON_HEIGHT 200.0f
#define BTN_MINUS 5001
#define BTN_PULS 5002
#define BTN_BUY 5003
@implementation HelpBuyProductDetail

#pragma mark - default
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //init
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        mainScrollView.hidden = YES;
        mainScrollView.backgroundColor = [PanliHelper colorWithHexString:@"#F5F5F5"];
        mainScrollView.canCancelContentTouches = NO;
        mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        mainScrollView.clipsToBounds = NO;
        mainScrollView.pagingEnabled = NO;
        mainScrollView.scrollEnabled = YES;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.showsVerticalScrollIndicator = NO;
        mainScrollView.bounces = YES;
        [self addSubview:mainScrollView];
        //顶部线条
        UIView *view_TopLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.5f)];
        view_TopLine.backgroundColor = [PanliHelper colorWithHexString:@"#d4d4d4"];
//        view_TopLine.layer.shadowColor = [PanliHelper colorWithHexString:@"#e2e2e2"].CGColor;
        view_TopLine.layer.shadowOffset = CGSizeMake(0, 1.8);
        view_TopLine.layer.shadowOpacity = 0.5;
        view_TopLine.layer.shadowRadius = 5.0;
        [self addSubview:view_TopLine];
        
        img_Product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(68.0f, 33.0f, 165.0f, 165.0f)];
        [img_Product.layer setBorderWidth:1.0f];
        [img_Product.layer setBorderColor:[PanliHelper colorWithHexString:@"#c8c9c6"].CGColor];
        img_Product.layer.cornerRadius = 2.0f;
        [mainScrollView addSubview:img_Product];
        
        lab_ProductName = [[UILabel alloc] initWithFrame:CGRectMake(27.0f, 220.0f, 250.0f, 35.0f)];
        lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
        lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#909090"];
        lab_ProductName.textAlignment = UITextAlignmentLeft;
        lab_ProductName.font = DEFAULT_FONT(15.0f);
        lab_ProductName.numberOfLines = 2;
        [mainScrollView addSubview:lab_ProductName];
        
        lab_Price = [[UILabel alloc] initWithFrame:CGRectMake(27.0f, 270.0f, 200.0f, 16.0f)];
        lab_Price.backgroundColor = PL_COLOR_CLEAR;
        lab_Price.textColor = PL_COLOR_RED;
        lab_Price.textAlignment = UITextAlignmentLeft;
        lab_Price.font = DEFAULT_FONT(15.0f);
        [mainScrollView addSubview:lab_Price];
        
        //数量 备注 我要代购
        view_Other = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, COUNT_REMARK_BUTTON_HEIGHT)];
        view_Other.backgroundColor = PL_COLOR_CLEAR;
        [mainScrollView addSubview:view_Other];
        
        
        //数量
        UILabel *lab_Count = [[UILabel alloc] initWithFrame:CGRectMake(27.0f, 0.0f, 135.0f, 16.0f)];
        lab_Count.backgroundColor = PL_COLOR_CLEAR;
        lab_Count.textColor = [PanliHelper colorWithHexString:@"#909090"];
        lab_Count.textAlignment = UITextAlignmentLeft;
        lab_Count.text = LocalizedString(@"HelpBuyProductDetail_labCount",@"数量");
        lab_Count.font = DEFAULT_FONT(15.0f);
        [view_Other addSubview:lab_Count];
    
        UIButton *btn_countMinus = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_countMinus.frame = CGRectMake(47.0f, -17.0f, 50.0f, 50.0f);
        btn_countMinus.tag = BTN_MINUS;
        [btn_countMinus addTarget:self action:@selector(helpBuyDetailClick:) forControlEvents:UIControlEventTouchDown];
        [btn_countMinus setImage:[UIImage imageNamed:@"btn_padSC_CountLeft"] forState:UIControlStateNormal];
        [view_Other addSubview:btn_countMinus];
        
        txt_Count = [[UITextField alloc] initWithFrame:CGRectMake(47.0f + 50.0f + 3.0f, -2.0f, 35.0f, 22.0f)];
        txt_Count.keyboardType = UIKeyboardTypeNumberPad;
        txt_Count.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
        txt_Count.textColor = [PanliHelper colorWithHexString:@"#666666"];
        [txt_Count.layer setBorderWidth:1.0f];
        [txt_Count.layer setBorderColor:[PanliHelper colorWithHexString:@"#c8c8c8"].CGColor];
        txt_Count.layer.cornerRadius = 2.0f;
        txt_Count.font = DEFAULT_FONT(14.0f);
        txt_Count.text = @"1";
        txt_Count.delegate = self;
        txt_Count.returnKeyType = UIReturnKeyDone;
        txt_Count.textAlignment = UITextAlignmentCenter;
        [view_Other addSubview:txt_Count];
        
        UIButton *btn_CountPlus = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_CountPlus.frame = CGRectMake(47.0f + 23.0f + 20.0f + 50.0f, -17.0f, 50.0f, 50.0f);
        btn_CountPlus.tag = BTN_PULS;
        [btn_CountPlus addTarget:self action:@selector(helpBuyDetailClick:) forControlEvents:UIControlEventTouchDown];
        [btn_CountPlus setImage:[UIImage imageNamed:@"btn_padSC_CountRight"] forState:UIControlStateNormal];
        [view_Other addSubview:btn_CountPlus];
        
        //备注
        UILabel *lab_Remark = [[UILabel alloc] initWithFrame:CGRectMake(27.0f, 42.0f, 135.0f, 16.0f)];
        lab_Remark.backgroundColor = PL_COLOR_CLEAR;
        lab_Remark.textColor = [PanliHelper colorWithHexString:@"#909090"];
        lab_Remark.textAlignment = UITextAlignmentLeft;
        lab_Remark.text = LocalizedString(@"HelpBuyProductDetail_labRemark",@"备注");
        lab_Remark.font = DEFAULT_FONT(15.0f);
        [view_Other addSubview:lab_Remark];

        txt_Remark = [[UITextView alloc] initWithFrame:CGRectMake(80.0f, 42.0f, 188.0f, 67.0f)];
        txt_Remark.delegate = self;
        txt_Remark.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
        txt_Remark.textColor = [PanliHelper colorWithHexString:@"#666666"];
        [txt_Remark.layer setBorderWidth:1.0f];
        [txt_Remark.layer setBorderColor:[PanliHelper colorWithHexString:@"#c8c8c8"].CGColor];
        txt_Remark.layer.cornerRadius = 6.0f;
        txt_Remark.font = DEFAULT_FONT(14.0f);
        txt_Remark.returnKeyType = UIReturnKeyDone;
        [view_Other addSubview:txt_Remark];

        //代购
        UIButton *btn_Buy = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Buy.frame = CGRectMake(27.0f, 140.0f, 248.0f, 41.0f);
        btn_Buy.tag = BTN_BUY;
        [btn_Buy addTarget:self action:@selector(helpBuyDetailClick:) forControlEvents:UIControlEventTouchDown];
        [btn_Buy setImage:[UIImage imageNamed:@"btn_padHome_Buy"] forState:UIControlStateNormal];
        [btn_Buy setImage:[UIImage imageNamed:@"btn_padHome_Buy_on"] forState:UIControlStateHighlighted];
        [view_Other addSubview:btn_Buy];

        /**********************************************************************
         *****************************半透明(加载时显示)********************************
         **********************************************************************/
        shadowView = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        shadowView.backgroundColor = PL_COLOR_BLACK;
        shadowView.hidden = YES;
        shadowView.alpha = 0.3;
        [self insertSubview:shadowView belowSubview:mainScrollView];
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activity.frame = CGRectMake((self.frame.size.width - 20)/2, (self.frame.size.height - 20)/2, 20.0f, 20.0f);
        [activity startAnimating];
        [shadowView addSubview:activity];
        
        //左边线条
        UIView *view_LeftLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.5f, self.frame.size.height)];
        view_LeftLine.backgroundColor = [PanliHelper colorWithHexString:@"#cecece"];
        [self addSubview:view_LeftLine];
        
        /**********************************************************************
         *****************************无数据view********************************
         **********************************************************************/
        noneDataView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        noneDataView.backgroundColor = [PanliHelper colorWithHexString:@"#ebebeb"];
        noneDataView.hidden = YES;
        [self insertSubview:noneDataView aboveSubview:mainScrollView];
        
        UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_back.frame = CGRectMake(60.0f, (self.frame.size.height  - 17)/2, 200, 17);
        [btn_back setTitle:LocalizedString(@"HelpBuyProductDetail_btnBack",@"加载错误,请点击刷新!") forState:UIControlStateNormal];
        [btn_back setTitleColor: [PanliHelper colorWithHexString:@"#a2a2a2"] forState:UIControlStateNormal];
        [btn_back setTitleColor: [PanliHelper colorWithHexString:@"#dfdfdf"] forState:UIControlStateHighlighted];
        [btn_back addTarget:self action:@selector(helpbuyDetailRefresh)forControlEvents:UIControlEventTouchDown];
        [noneDataView addSubview:btn_back];

        /**********************************************************************
         *****************************手势********************************
         **********************************************************************/
        //点击手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGestureRecognizer];
        //平移手势
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}
#pragma mark - realoadView
- (void)reloadView:(helpBuyLodingType)viewType data:(SnatchProducts*)iSnatchProducts
{
    //每次刷新初始化数据
    mainScrollView.contentOffset = CGPointMake(0.0f, 0.0f);
    txt_Remark.text = nil;
    txt_Count.text = @"1";
    self.mSnatchProducts = nil;
    self.selectSkuCombination = nil;
    panGestureRecognizer.enabled = NO;
    
    //判断状态刷新View
    switch (viewType)
    {
        case loading:
        {
            shadowView.hidden = NO;
            noneDataView.hidden = YES;
            mainScrollView.hidden = YES;
            break;
        }
        case success:
        {
            mainScrollView.hidden = NO;
            shadowView.hidden = YES;
            noneDataView.hidden = YES;
            //加载view && 数据源
            self.mSnatchProducts = iSnatchProducts;
            [self initScrollView];
            break;
        }
        case error:
        {
            noneDataView.hidden = NO;
            shadowView.hidden = YES;
            mainScrollView.hidden = YES;
            break;
        }
        default:
        {
            shadowView.hidden = YES;
            mainScrollView.hidden = YES;
            noneDataView.hidden = NO;
            break;
        }
    }
}
#pragma mark - initScrollViewData
- (void)initScrollView
{
    panGestureRecognizer.enabled = YES;
    if (self.mSnatchProducts)
    {
        mainScrollView.hidden = NO;
        //滚动图片
        [img_Product setCustomImageWithURL:[NSURL URLWithString:self.mSnatchProducts.thumbnail]];
        //商品名称
        lab_ProductName.text = [NSString stringWithFormat:@"%@",self.mSnatchProducts.productName];
        
        //价格lab
        singlePrice = self.mSnatchProducts.price * self.mSnatchProducts.vipDiscount;
        singlePrice =  self.mSnatchProducts.promotionPrice > 0 ? MIN(singlePrice, self.mSnatchProducts.promotionPrice) : singlePrice;
        
        CGSize maxSize = CGSizeMake(100.0f,50);
        CGSize priceSize = [[NSString stringWithFormat:@"￥%.2f", singlePrice] sizeWithFont:DEFAULT_FONT(15.0f) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        lab_Price.text = [NSString stringWithFormat:@"￥%.2f", singlePrice];
        lab_Price.frame = CGRectMake(27.0f, 270.0f, priceSize.width, 16.0f);
        
//        //邮费
//        lab_productFreight.frame = CGRectMake(15 + priceSize.width, 288.0f, MainScreenFrame_Width - 20 - priceSize.width, 20.0f);
//        lab_productFreight.text = [NSString stringWithFormat:@"(国内邮费￥%.2f)", self.mSnatchProducts.freight];
//        
//        
//        //判断价钱
//        if(productPrice != singlePrice)
//        {
//            bl_Price = YES;
//            NSString *str_Price = [NSString stringWithFormat:@"￥%.2f",productPrice];
//            //计算长度
//            CGSize size = [str_Price sizeWithFont:DEFAULT_FONT(15)
//                                constrainedToSize:CGSizeMake(320, 20)
//                                    lineBreakMode:NSLineBreakByCharWrapping];
//            
//            CustomerUILabelWithLine *lab_CostPrice = [[CustomerUILabelWithLine alloc]initWithFrame:CGRectMake(10.0f, 287.0f, size.width, 20.0f)textSize:size];
//            lab_CostPrice.textColor = [PanliHelper colorWithHexString:@"#898989"];
//            lab_CostPrice.font = DEFAULT_FONT(15);
//            lab_CostPrice.backgroundColor = COLOR_CLEAR;
//            lab_CostPrice.text = str_Price;
//            [mainScrollView addSubview:lab_CostPrice];
//            [lab_CostPrice release];
//            
//            lab_productPrice.frame =  CGRectMake(10.0f+size.width, 288.0f, priceSize.width, 20.0f);
//            
//            lab_productFreight.frame = CGRectMake(10.0f+priceSize.width+size.width, 288.0f, MainScreenFrame_Width - 20 - priceSize.width, 20.0f);
//        }
//
        if(skuView)
        {
            [skuView removeFromSuperview];
        }
        //款式
        skuView = [[CustomerSkusView alloc] initWithFrame:CGRectMake(17.0f, 300.0f, self.frame.size.width, 200.0f) skus:self.mSnatchProducts.skus skuCombinations:self.mSnatchProducts.skuCombinations];
        skuView.skuDelegate = self;
        [mainScrollView addSubview:skuView];
        
        //款式下面的view和toolbar在获取到款式高度后的协议中完成
        float y = skuView.frame.origin.y + skuView.frame.size.height;
        view_Other.frame = CGRectMake(0.0f, y, self.frame.size.width, COUNT_REMARK_BUTTON_HEIGHT);
        mainScrollView.contentSize = CGSizeMake(self.frame.size.width, y + COUNT_REMARK_BUTTON_HEIGHT + 100.0f);
    }
    else
    {
        mainScrollView.hidden = YES;
    }
}

#pragma mark - skuView delegate
- (void)skuCombinationDidChange:(SkuCombination *)skuCombination
{
    if (skuCombination)
    {
        singlePrice = skuCombination.price * self.mSnatchProducts.vipDiscount;
        
        singlePrice = skuCombination.promo_Price > 0 ? MIN(singlePrice, skuCombination.promo_Price) : singlePrice;
    }
    //重新定义价格和邮费的位置
    lab_Price.text = [NSString stringWithFormat:@"￥%.2f", singlePrice];
    CGSize maxSize = CGSizeMake(100.0f,50);
    CGSize priceSize = [[NSString stringWithFormat:@"￥%.2f", singlePrice] sizeWithFont:DEFAULT_FONT(15.0f) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    lab_Price.frame = CGRectMake(27.0f, 270.0f, priceSize.width, 16.0f);
    //    lab_productFreight.frame = CGRectMake(15 + priceSize.width, 288.0f, MainScreenFrame_Width - 20 - priceSize.width, 20.0f);
    
    //    //判断价钱
    //    if(bl_Price)
    //    {
    //        NSString *str_Price = [NSString stringWithFormat:@"￥%.2f",self.mSnatchProducts.price];
    //        //计算长度
    //        CGSize size = [str_Price sizeWithFont:DEFAULT_FONT(15)
    //                            constrainedToSize:CGSizeMake(320, 20)
    //                                lineBreakMode:NSLineBreakByCharWrapping];
    //
    //        lab_productPrice.frame =  CGRectMake(10.0f+size.width, 288.0f, priceSize.width, 20.0f);
    //
    //        lab_productFreight.frame = CGRectMake(10.0f+priceSize.width+size.width, 288.0f, MainScreenFrame_Width - 20 - priceSize.width, 20.0f);
    //    }
    //
    //    if (selectSkuCombination)
    //    {
    //        SAFE_RELEASE(selectSkuCombination);
    //    }
    self.selectSkuCombination = skuCombination;
    DLOG(@"%@",self.selectSkuCombination);
}

- (void)updateSelectSkuImageView:(SkuObject *)iSkuObject
{
    if(iSkuObject != nil && ![NSString isEmpty:iSkuObject.thumbnailUrl])
    {
        [img_Product setCustomImageWithURL:[NSURL URLWithString:iSkuObject.thumbnailUrl]];
        
        if([NSString isEmpty:iSkuObject.thumbnailUrl])
        {
            [img_Product setCustomImageWithURL:[NSURL URLWithString:self.mSnatchProducts.thumbnail]];
        }
    }
}

#pragma mark - UitextFieldDegatele
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    DLOG(@"%f",view_Other.frame.origin.y);
    float y = view_Other.frame.origin.y + txt_Count.frame.size.height - 200.0f;
    DLOG(@"%f----",y);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(y > 0)
    mainScrollView.contentOffset = CGPointMake(0.0f, y);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    mainScrollView.contentOffset = CGPointMake(0.0f, 0.0f);
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        if([string isEqualToString:@"\n"])
        {
            [textField resignFirstResponder];
            return NO;
        }
    return YES;
}

#pragma mark - UitextViewDegatele
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    float y = view_Other.frame.origin.y + txt_Remark.frame.size.height - 200.0f;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(y > 0)
    mainScrollView.contentOffset = CGPointMake(0.0f, y);
    [UIView commitAnimations];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    mainScrollView.contentOffset = CGPointMake(0.0f, 0.0f);
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        if([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            return NO;
        }
    return YES;
}
#pragma mark - btnClick && tapgesture
- (void)helpBuyDetailClick:(UIButton*)btn
{
    [txt_Remark resignFirstResponder];
    [txt_Count resignFirstResponder];
    int productCount = [txt_Count.text intValue];
    switch (btn.tag)
    {
        case 5001:
        {
            if(productCount > 0)
            {
                productCount --;
            }
            if(productCount == 0)
            {
                productCount = 1;
            }
        break;
        }
        case 5002:
        {
            productCount++;
            break;
        }
        case 5003:
        {
            UserInfo *userInfo = [GlobalObj getUserInfo];
            if (userInfo != nil)
            {
                if (self.selectSkuCombination == nil
                    && self.mSnatchProducts.skus.count > 0
                    && self.mSnatchProducts.skuCombinations.count > 0
                    )
                {
                    [MBProgressHUD showInView:self errorMessage:LocalizedString(@"HelpBuyProductDetail_HUDErrMsg1",@"请选择款式")];
                    return;
                }
                else if (self.selectSkuCombination && self.selectSkuCombination.quantity < [txt_Count.text intValue])
                {
                    [MBProgressHUD showInView:self errorMessage:LocalizedString(@"HelpBuyProductDetail_HUDErrMsg2",@"商品库存不足,请选择其他款式")];
                    return;
                }
                else
                {
                    
                    if(self.skuDelegate != nil && [self.skuDelegate respondsToSelector:@selector(didSelectSku:productCount:productRemark:)])
                    {
                        [self.skuDelegate didSelectSku:self.selectSkuCombination productCount:[txt_Count.text intValue] productRemark:txt_Remark.text];
                    }
                }
            }
            else
            {
                //清空用户信息
                [GlobalObj setUserInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_POP_LOGIN object:nil];
            }
            break;
        }
            
        default:
            break;
    }
    txt_Count.text = [NSString stringWithFormat:@"%d",productCount];
}
#pragma mark - refresh_Post_NSNotificationCenter
- (void)helpbuyDetailRefresh
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HELPBUYPRODUCTDETIL_REFRESH" object:nil];
}

#pragma mark - UIPanGestureRecognizer (isShowProductDetail?)
-(void)handelPan:(UIPanGestureRecognizer*)gestureRecognizer
{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    CGPoint traPoint = [gestureRecognizer translationInView:self];
    //判断是否隐藏详情
    if(traPoint.x >= 60)
    {
        if(self.skuDelegate != nil && [self.skuDelegate respondsToSelector:@selector(hideDetail)])
        {
            [self.skuDelegate hideDetail];
        }
    }
}
#pragma mark - UITapGestureRecognizer hideKeyBoard
- (void)hideKeyBoard:(UITapGestureRecognizer*)sender
{
    [txt_Remark resignFirstResponder];
    [txt_Count resignFirstResponder];
}
@end
