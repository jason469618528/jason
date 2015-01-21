//
//  GuideDetailViewController.h
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guide.h"
#import "BaseViewController.h"

/**************************************************
 * 内容描述: 问题详情
 * 创 建 人: 刘彬
 * 创建日期: 2013-11-04
 **************************************************/
@interface GuideDetailViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *mainWebView;
}

@property (nonatomic, retain) Guide *mGuide;

@end
