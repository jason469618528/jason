//
//  UserShareTopicView.h
//  PanliApp
//
//  Created by Liubin on 13-12-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 分享话题选择view
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-19
 **************************************************/
#import <UIKit/UIKit.h>
#import "ShareBuyTopic.h"

@protocol UserShareTopicViewDelegate <NSObject>
@optional
- (void)topicDidSelectedWithIndex:(int)index;

@end

@interface UserShareTopicView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tab_topic;
    
    UIButton *btn_close;

    UIControl *shadowView;

    int selectIndex;

    BOOL isShowing;
}

@property (nonatomic, retain) NSArray *topicArray;

@property (nonatomic, assign) id<UserShareTopicViewDelegate> delegate;

- (void)action;

@end
