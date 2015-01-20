//
//  CustomerNavagationBarController.h
//  PanliApp
//
//  Created by Liubin on 13-4-12.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

/**************************************************
 * 内容描述: 自定义navagationbar
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-12
 **************************************************/
@interface CustomerNavagationBarController : UINavigationController<UIGestureRecognizerDelegate>

{
    UIImage* backgroundImage;//背景图片
}
// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;

@end
