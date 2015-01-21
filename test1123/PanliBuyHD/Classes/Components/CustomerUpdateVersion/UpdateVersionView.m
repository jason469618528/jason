//
//  UpdateVersionView.m
//  PanliApp
//
//  Created by jason on 13-11-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UpdateVersionView.h"

@implementation UpdateVersionView

- (id)initWithFrame:(CGRect)frame shadowLayerImage:(UIImage *)shadowImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        [button setBackgroundImage:shadowImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (id)initUpdateVersionBgMain:(UIImage*)bgMain MainFrame:(CGRect)MainRect bgTitle:(UIImage*)bgTitle titleFrame:(CGRect)titleFrame
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT)];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        UIImageView * bg_Main = [[UIImageView alloc]initWithImage:bgMain];
        bg_Main.frame = MainRect;
        [self addSubview:bg_Main];
        [bg_Main release];
        
        UIButton *btn_Text = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Text.frame = titleFrame;
        [btn_Text setImage:bgTitle forState:UIControlStateNormal];
//        [btn_Text addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_Text];
        
        UIButton *btn_Remove = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Remove.backgroundColor = PL_COLOR_CLEAR;
        btn_Remove.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT);
        [btn_Remove addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_Remove];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame ButtonFrame:(CGRect)btnFrame backgroundImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = PL_COLOR_CLEAR;
        
        UIImageView * bg_Main = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        bg_Main.frame = frame;
        [self addSubview:bg_Main];
        [bg_Main release];
        
        UIButton *btn_Text = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Text.backgroundColor = PL_COLOR_CLEAR;
//        btn_Text.backgroundColor = COLOR_RED;
        btn_Text.frame = btnFrame;
        [btn_Text addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_Text];
    }
    return self;
}


- (void)removeGuideView
{
    [self removeFromSuperview];
}


@end
