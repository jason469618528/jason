//
//  PopView.m
//
//  Created by liubin on 13-4-26.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "PopView.h"


@implementation PopView



@synthesize btn_top;
@synthesize btn_bottom;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}

-(id)initWithButtonCount:(int)buttonCont isNewMessage:(BOOL)isNew isDisplayIcon:(BOOL)isDisplayFlag
{
    if (buttonCont == 1)
    {
        self = [super initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 50.0f)];
        if (self)
        {
            btn_top = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_top.frame = CGRectMake(MainScreenFrame_Width - 65 -150.5, 10, 120.5f, 32.5);
            [self addSubview:btn_top];
        }
    }
    else
    {
        self = [super initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 50.0f)];
        if (self)
        {
            
            btn_top = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_top.frame = CGRectMake(35.0f, 10, 120.5f, 32.5);
            [self addSubview:btn_top];
            
            btn_bottom = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_bottom.frame = CGRectMake(btn_top.frame.origin.x + btn_top.frame.size.width + 10, 10, 120.5f, 32.5);
            [self addSubview:btn_bottom];
        }
    }
    if(isNew && isDisplayFlag)
    {
        UIImageView *img_New = [[UIImageView alloc] initWithFrame:CGRectMake(buttonCont == 1 ? self.btn_top.frame.origin.x - 75.0f : 35.0f - 9.0f , 7.0f, 7.0f, 7.0f)];
        img_New.image =  [UIImage imageNamed:@"bg_myPanli_smallBadge"];
        [self.btn_top addSubview:img_New];
        [img_New release];
    }
    return self;
}



@end
