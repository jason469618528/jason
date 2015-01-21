//
//  GuideView.h
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "Guide.h"

/**************************************************
 * 内容描述: 小指南banner
 * 创 建 人: 刘彬
 * 创建日期: 2013-11-04
 **************************************************/
@protocol GuideViewDelegate <NSObject>

- (void)goToGuideDetailView:(Guide *)guide;

@end

@interface GuideView : UIView
{
    UIImageView *_bgImageView;
    Guide *_mGuide;
    id<GuideViewDelegate> _guideViewDelegate;
}

@property (nonatomic, retain) Guide *mGuide;

@property (nonatomic, assign) id<GuideViewDelegate> guideViewDelegate;

- (void)setGuideData:(Guide *)data;

@end
