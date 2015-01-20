//
//  UserShareFilterView.h
//  PanliApp
//
//  Created by Liubin on 13-12-12.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

/**************************************************
 * 内容描述: 用户分享首页下拉选择view
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-12
 **************************************************/
@protocol UserShareFilterViewDelegate <NSObject>

@optional
- (void)filterDidSelectedWithIndex:(int)index;

@end

@interface UserShareFilterView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tab_menu;

    UIControl *shadowView;
    
    int selectIndex;
    
    BOOL isShowing;
}

@property (nonatomic, assign) id<UserShareFilterViewDelegate> delegate;

- (void)action;

@end
