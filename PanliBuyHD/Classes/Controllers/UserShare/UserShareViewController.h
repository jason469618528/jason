//
//  UserShareViewController.h
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ShareProduct.h"
#import "RatingView.h"
#import "CustomUIButton.h"
#import "MakeShareRequest.h"
#import "ShareTopicsRequest.h"
#import "ShareBuyTopic.h"
#import "UserShareTopicView.h"
/**************************************************
 * 内容描述: 用户分享
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-10
 **************************************************/
@interface UserShareViewController : BaseViewController<RatingViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UserShareTopicViewDelegate>
{
    UITextView *txt_description;
    
    //正在选择图片的CustomUIButton
    CustomUIButton *uploadingButton;

    //话题选择view
    UserShareTopicView *topicView;
    
    //评分
    float rateScore;

    //分享商品
    MakeShareRequest *req_MakeShare;
    DataRepeater *rpt_MakeShare;
    
    //分享话题
    ShareTopicsRequest *req_ShareBuyTopics;
    DataRepeater *rpt_ShareBuyTopics;
}

/**
 *商品信息
 */
@property (nonatomic, retain) ShareProduct *mProduct;

/**
 *分享话题集合
 */
@property (nonatomic, retain) NSMutableArray *topicArray;

/**
 *图片选择控件
 */
@property (nonatomic, retain) UIImagePickerController *imagePicker;

/**
 *上传图片路径集合
 */
@property (nonatomic, retain) NSMutableArray *picturePathArray;

@end
