//
//  ScoreExchangeViewController.h
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ScoreExchangeRequest.h"

@interface ScoreExchangeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    int currentScore;
    //当前句柄
    int currentIndex;
    //当前要兑换的积分
    int currentScoreCount;
    
    //图片数组
    NSArray *arr_ImageMain;
    
    UITableView *tab_Main;
    
    //换取优惠券请求
    ScoreExchangeRequest *req_Exchange;
    DataRepeater *rpt_Exchange;
}

@end
