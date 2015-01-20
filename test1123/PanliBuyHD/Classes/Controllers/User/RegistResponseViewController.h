//
//  RegistResponseViewController.h
//  PanliApp
//
//  Created by Liubin on 13-7-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorInfo.h"
#import "BaseViewController.h"

/**************************************************
 * 内容描述: 注册结果
 * 创 建 人: 刘彬
 * 创建日期: 2013-07-18
 **************************************************/
@interface RegistResponseViewController : BaseViewController

//0-注册成功 1-激活成功 2-激活失败
@property (nonatomic, assign) int responseType;

@property (nonatomic, retain) NSString *emailSite;

@end
