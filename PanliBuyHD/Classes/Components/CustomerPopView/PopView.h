//
//  PopView.h
// 
//
//  Created by liubin on 13-4-26.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

/**************************************************
 * 内容描述: 右边弹出气泡按钮
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-26
 **************************************************/
/**********************************修改记录1********
 * 修改日期: 2013-12-1
 * 修 改 人: jason
 * 修改内容: (功能修改)底部按钮(商品详情，运单详情)
 **************************************************/
@interface PopView : UIView


@property(nonatomic,retain)UIButton *btn_top;
@property(nonatomic,retain)UIButton *btn_bottom;

-(id)initWithButtonCount:(int)buttonCont isNewMessage:(BOOL)isNew isDisplayIcon:(BOOL)isDisplayFlag;
@end


