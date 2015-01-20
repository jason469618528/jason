//
//  ShareBuyDetailViewController.h
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ShareBuyProductDetailRequest.h"
#import "CustomerExceptionView.h"
#import "ShareProduct.h"
#import "ShareBuyDetail.h"
#import "ShareBuyDetailCell.h"
#import "ShareBuyPraiseRequest.h"
#import "ShareBuyIsPraisedBySelfRequest.h"
#import "FullScreenImageView.h"
/**************************************************
 * 内容描述: 分享购详情
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-10
 **************************************************/
//刷新分享购首页选荐数据
@protocol shareHomeRefreshDelegate <NSObject>
- (void)refreshRecommend;
@end

@interface ShareBuyDetailViewController : BaseViewController <ShareBuyDetaimImageDelegate,UITableViewDataSource,UITableViewDelegate,FullScreenImageDelegate>

{
    //底部工具栏
    UIView *view_Bottom;
    
    //分享详情
    UITableView *tab_ShareBuyDetail;
    
    //详情数据
    NSArray *arr_DetailInfo;
    
    //赞
    UIButton *btn_Praise;
    
    CustomerExceptionView *exceptionView_ShareBuyDetail;
    
    //用户分享详情
    DataRepeater *rpt_SharedProductDetails;
    ShareBuyProductDetailRequest *req_SharedProductDetails;
    
    //赞
    ShareBuyPraiseRequest *req_MakePraise;
    DataRepeater *rpt_MakePraise;
    
    //获取用户是否赞过
    ShareBuyIsPraisedBySelfRequest *req_UserIsPraised;
    DataRepeater *rpt_UserIsPraised;
    
    UILabel *lab_Praise;
    
    UIImageView *bg_HeadPraise;
    
    BOOL isPraise;
}

@property (nonatomic, assign) id<shareHomeRefreshDelegate> refreshHomeDelegate;

@property (nonatomic, retain) ShareProduct *  mainSharePrduct;

@end
