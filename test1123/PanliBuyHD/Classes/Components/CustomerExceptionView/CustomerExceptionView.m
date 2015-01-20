//
//  CustomerExceptionView.m
//  PanliBuyHD
//
//  Created by guo on 14-10-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "CustomerExceptionView.h"

@implementation CustomerExceptionView
@synthesize lab_detail;
@synthesize lab_title;
@synthesize img_icon;

- (id)initWithFrame:(CGRect)frame
{
    self.clipsToBounds = YES;
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[PanliHelper colorWithHexString:@"#f0f0f3"]];
        
        //图片
        img_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [img_icon setFrame:CGRectMake((frame.size.width - 401.0)/2, 68.0f, 401.0f, 292.0f)];
        [img_icon setContentMode:UIViewContentModeCenter];
        [self addSubview:img_icon];
        
        //主要提示
        lab_title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 360.0f, frame.size.width, 20.0f)];
        lab_title.textColor = [PanliHelper colorWithHexString:@"#999999"];
        lab_title.font = DEFAULT_FONT(16);
        lab_title.textAlignment = UITextAlignmentCenter;
        lab_title.backgroundColor = PL_COLOR_CLEAR;
        lab_title.text = @"";
        [self addSubview:lab_title];
        
        //详细
        lab_detail = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 380.0f, frame.size.width, 20.0f)];
        lab_detail.textColor = [PanliHelper colorWithHexString:@"#ACACAC"];
        lab_detail.font = DEFAULT_FONT(13);
        lab_detail.textAlignment = UITextAlignmentCenter;
        lab_detail.backgroundColor = PL_COLOR_CLEAR;
        lab_detail.text = @"";
        [self addSubview:lab_detail];
    }
    return self;
}
@end
