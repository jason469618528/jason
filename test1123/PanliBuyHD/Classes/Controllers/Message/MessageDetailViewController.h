//
//  MessageDetailViewController.h
//  PanliApp
//
//  Created by Liubin on 13-4-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewController.h"
#import "MessageDetailRequest.h"
#import "MessageObjectcsRequest.h"
#import "SendMsgByObjectIdRequest.h"
#import "SendMsgByTopicIdRequest.h"
#import "MessageDetailBottomView.h"
#import "MessagePopView.h"
#import "BaseViewController.h"

typedef enum {
    no_Request = 0,//不请求
    refresh_Request,//刷新请求
} RequsetType;

/**************************************************
 * 内容描述: 消息详细列表
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-18
 **************************************************/
@interface MessageDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    /**
     *消息列表view
     */
    UITableView *tab_MessageTable;
    
    /**
     是否需要刷新或者加载标志位
     */
    RequsetType _requestType;
    
    /**
     刷新view
     */
    CustomLoadingView *_headView;
    
    /**
     *刷新标志
     */
    BOOL _refreshing;
    
    /**
     *底部回复view
     */
    MessageDetailBottomView *view_BottomMessageView;
    
    /**
     *弹出回复view
     */
    MessagePopView *view_PopMessageView;        
    
    /**
     *根据topicid获取消息请求
     */
    MessageDetailRequest *req_MessageDetailRequest;
    
    /**
     *发送消息请求
     */
    SendMsgByTopicIdRequest *req_SendMsgByTopicIdRequest;
    
    /**
     *根据objid获取消息请求
     */
    MessageObjectcsRequest *req_MessageObjectcsRequest;
    
    /**
     *根据objid发送消息请求
     */
    SendMsgByObjectIdRequest *req_SendMsgByObjectIdRequest;
    
    /**
     *消息数组
     */
    NSMutableArray *mArr_messageArray;
    
    /**
     *数据转发器
     */
    DataRepeater *dataRepeater;
    
    /**
     *短信临时存储变量
     */
    NSString *str_MessageTemp;
    
    /**
     *界面上是否正在做动画
     */
    BOOL _isAnimating;
    
    /**
     *是否是第一次请求
     */
    BOOL _isFirst;
}

/**
 *消息主题
 */
@property (nonatomic, retain) NSString *str_messageTopic;

/**
 *运单objectID
 */
@property (nonatomic, retain) NSString *str_objectId;

/**
 *短信类型
 */
@property (nonatomic, assign) MessageType messageType;

/**
 *短信主题ID
 */
@property (nonatomic, assign) int messageTopicId;

/**
 *图片
 */
@property(nonatomic,retain) NSString * str_Image;

/**
 *短信获取详情id
 */
@property (nonatomic, retain) NSString *messageGetDetailId;

@end
