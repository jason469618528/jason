//
//  FullScreenImageView.h
//  PanliApp
//
//  Created by Liubin on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

/**************************************************
 * 内容描述: 点击全屏展示图片,支持多张图片滚动
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-18
 **************************************************/

@protocol FullScreenImageDelegate <NSObject>
@optional
- (void)fullImageDidRemove;
@end

@interface FullScreenImageView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *mainScrollView;
    
    UIPageControl *pageControl;
    
    int pageIndex;
}

@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, assign) id<FullScreenImageDelegate> delegate;

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)array showIndex:(int)index;

@end
