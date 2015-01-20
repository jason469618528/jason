//
//  CustomerExceptionView.h
//  PanliBuyHD
//
//  Created by guo on 14-10-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**
 *  说明：异常显示的View
 */

#import <UIKit/UIKit.h>

typedef enum Exception
{
    Not_NetWork = 0,
    Not_Data = 1,
    
}ExcepTionType;

@interface CustomerExceptionView : UIView
{
    UIImageView *img_icon;
    UILabel *lab_title;
    UILabel *lab_detail;
}

//0.无网络 1.无数据
@property (nonatomic, assign) ExcepTionType exceptionType;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) UILabel *lab_detail;
@property (nonatomic, retain) UIImageView *img_icon;
@property (nonatomic, retain) UILabel *lab_title;

@end
