//
//  BaseViewController.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
 *检测第三方购物网站状态
 */
- (HelpBuySourceState)resuleIsHelpBuySourceType:(NSString*)strSource;

- (void) checkLoginWithBlock:(void(^)(void))complete;

/**
 * 功能描述: 判断是否登录
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void) checkLoginWithBlock:(void(^)(void))complete andLoginTag:(int)tag;

- (void)viewDidLoadWithBackButtom:(BOOL)backButton;

/**
 * 功能描述: 根据运单状态判断展示类型
 * 输入参数: status 运单状态
 * 返 回 值: 运单展示类型枚举
 */
- (ShipDisState)getShipStateWithStatus:(int)status;
@end
