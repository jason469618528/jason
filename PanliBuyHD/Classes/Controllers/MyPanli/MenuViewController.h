//
//  MainViewController.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-17.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "CustomLoadingView.h"
#import "ShipOrdersRequest.h"
#import "GetUserInfoRequest.h"
#import "GetUserUnReadMessages.h"
#import "VPImageCropperViewController.h"
#import "UploadAvatarRequest.h"
#import "MessageUserNoteViewController.h"
#import "LoginViewController.h"
#import "ActiveViewController.h"
#import "UserUnReadMessages.h"
#import "UIButton+WebCache.h"

typedef enum {
    no_Request = 0,//不请求
    refresh_Request,//刷新请求
} RequsetType;

/**************************************************
 * 内容描述: Mypanli首页
 * 创 建 人: Thomas
 * 创建日期: 2014-10-20
 **************************************************/

@interface MenuViewController : UITableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate>
{    
    //Tabel 数据源
    NSArray *arr_CellTitle;
    NSArray *arr_Image;
    
    //用户头像
    UIButton *_btn_User_Head;
    //用户背景
    UIImageView *img_TopBg;
    //上传照片
    UIButton *btn_UpdataAvatar;
    //用户名
    UILabel *lab_UserName;
    //注册按钮
    UIButton *btn_Register;
    //登录按钮
    UIButton *btn_login;
    
    /**
     *刷新标志
     */
    BOOL _refreshing;
    
    /**
     刷新view
     */
    CustomLoadingView *_headView;
    
    /**
     是否需要刷新或者加载标志位
     */
    RequsetType _requestType;
    
    //请求运单
    ShipOrdersRequest *req_AllShip;
    DataRepeater *rpt_AllShip;
    
    //用户信息请求
    GetUserInfoRequest *req_UserInfo;
    DataRepeater *rpt_UserInfo;
    
    //用户未读短信请求
    GetUserUnReadMessages *req_UnreadMessage;
    DataRepeater *rpt_UnreadMessage;
    
    //上传头像
    UploadAvatarRequest *req_UpAvatar;
    DataRepeater *rpt_UpAvatar;
    

}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) UIButton *btn_User_Head;
@property (nonatomic, strong) UIPopoverController *popOver;

/**
 *用户未读短信
 */
@property (nonatomic, retain) UserUnReadMessages *mUserUnReadMessages;

@end
