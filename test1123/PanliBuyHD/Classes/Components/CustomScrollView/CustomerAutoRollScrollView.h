//
//  CustomerAutoRollScrollView.h
//  PanliApp
//
//  Created by Liubin on 13-10-24.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerPageControl.h"

/**************************************************
 * 内容描述: 循环自动滚动广告栏
 * 创 建 人: 刘彬
 * 创建日期: 2013-10-24
 **************************************************/

@protocol ScrollViewDataSource;
@protocol ScrollViewDelegate;
@interface CustomerAutoRollScrollView : UIView<UIScrollViewDelegate>
{
    /**
     scrollview控件
     */
    UIScrollView *_scrollView;
    
    /**
     pageControl控件
     */
    CustomerPageControl *_pageControl;
    
    /**
     总页数
     */
    NSInteger _totalPages;
    
    /**
     当前页数
     */
    NSInteger _curPage;
    
    /**
     自动滚动计时器
     */
    NSTimer *_rollTimer;
    
    int timerNumber;
    
    /**
     控件数据源回调
     */
    id<ScrollViewDataSource> _dataSource;
}

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) id<ScrollViewDataSource> dataSource;

/**
 重新刷新控件数据
 */
- (void)reloadData;


@end

@protocol ScrollViewDataSource <NSObject>

@required
/**
 获取控件的数据总数
 */
- (NSInteger) scrollView:(CustomerAutoRollScrollView *)csViewNumberOfPages;

/**
 构建view
 */
- (UIView *)scrollView:(CustomerAutoRollScrollView *)csView viewAtIndex:(NSInteger)index;

@end

