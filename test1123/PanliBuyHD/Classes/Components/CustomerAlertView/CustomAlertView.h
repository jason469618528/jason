//
//  CustomAlertView.h
//  textAlertView
//
//  Created by lv xingtao on 12-10-13.
//  Copyright (c) 2012年 lv xingtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIAlertView


@property(nonatomic,retain) NSString *bg_AlertMain;
@property(nonatomic,retain) NSString *btn_ClickLeft;
@property(nonatomic,retain) NSString *btn_ClickLeft_on;
@property(nonatomic,retain) NSString *btn_ClickRight;
@property(nonatomic,retain) NSString *btn_ClickRight_on;
@property(nonatomic,assign) CGRect *titleFrame;
@property(nonatomic,assign) int index;
@end
