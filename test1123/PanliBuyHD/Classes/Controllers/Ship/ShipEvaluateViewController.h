//
//  ShipEvaluateViewController.h
//  PanliApp
//
//  Created by jason on 13-5-2.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "RateRequest.h"
#import "GetReviewRequest.h"
#import "BaseViewController.h"
/**************************************************
 * 内容描述: 运单评价
 * 创 建 人: jason
 * 创建日期: 2013-5-2
 **************************************************/
@interface ShipEvaluateViewController : BaseViewController<RatingViewDelegate,UITextViewDelegate>
{
    //评价控件 
    RatingView * r_Server;
    RatingView * r_Speed;
    RatingView * r_Sh;
    RatingView * r_All;
    
    //评价分数
    int ServerNum;
    int SpeedNum;
    int ShNum;
    int AllNum;
    
    //评价文字
    UITextView *text_RateText;
    
    UIView * containerView ;
    
    //评价
    RateRequest *req_Rate;
    DataRepeater *data_Repeater;
    
    //获取运单评价
    GetReviewRequest *req_GetRate;
    DataRepeater *data_GetRate;
    
    
}


@property(nonatomic,retain) NSString * str_Image;

@property (nonatomic, retain) NSString * str_ScoreCount;

//@property(nonatomic,assign)BOOL b_RateState;
@property (nonatomic, retain) NSString * str_ShipId;
@end
