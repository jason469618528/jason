//
//  MessageDetailBottomView.m
//  PanliApp
//
//  Created by Liubin on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageDetailBottomView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MessageDetailBottomView

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PanliHelper colorWithHexString:@"#ebebed"];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.masksToBounds = NO;
        
        UIView *txtView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, MainScreenFrame_Width - 150, 30)];
        txtView.backgroundColor = PL_COLOR_WHITE;
        txtView.layer.cornerRadius = 15.0f;
        txtView.layer.masksToBounds = YES;
        [self addSubview:txtView];
        [txtView release];

        
        btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit.frame = CGRectMake(MainScreenFrame_Width - 130.0f, 6, 56.0f, 29.0f);
        [btn_submit setBackgroundImage:[UIImage imageNamed:@"btn_msgDetail_message"] forState:UIControlStateNormal];
        [btn_submit setBackgroundImage:[UIImage imageNamed:@"btn_msgDetail_message_on"]  forState:UIControlStateHighlighted];
        [btn_submit addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_submit];
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
