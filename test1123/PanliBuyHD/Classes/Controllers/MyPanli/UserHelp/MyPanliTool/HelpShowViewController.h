//
//  HelpShowViewController.h
//  PanliApp
//
//  Created by Liubin on 13-6-17.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#

@interface HelpShowViewController : UIViewController<UIScrollViewDelegate>
{
    /**
     * 引导页图片
     */
    NSMutableArray *mArr_images;
    
    /**
     * 滚动视图
     */
    UIScrollView *scroll_helpScrollView;
    
    /**
     * 页码控制器
     */
    UIPageControl *page_helpPageControl;
    
    int currentPage;
}

@property (nonatomic, assign) int  type;

@end
