//
//  CustomAlertView.m
//  textAlertView
//
//  Created by lv xingtao on 12-10-13.
//  Copyright (c) 2012年 lv xingtao. All rights reserved.
//
#define kAlertViewBounce         20
#define kAlertViewBorder         10
#define kAlertButtonHeight       44

#define kAlertViewTitleFont             [UIFont boldSystemFontOfSize:20]
#define kAlertViewTitleTextColor        [UIColor colorWithWhite:244.0/255.0 alpha:1.0]
#define kAlertViewTitleShadowColor      [UIColor blackColor]
#define kAlertViewTitleShadowOffset     CGSizeMake(0, -1)

#define kAlertViewMessageFont           [UIFont systemFontOfSize:18]
#define kAlertViewMessageTextColor      [UIColor colorWithWhite:244.0/255.0 alpha:1.0]
#define kAlertViewMessageShadowColor    [UIColor blackColor]
#define kAlertViewMessageShadowOffset   CGSizeMake(0, -1)

#define kAlertViewButtonFont            [UIFont boldSystemFontOfSize:18]
#define kAlertViewButtonTextColor       PL_COLOR_GRAY
#define kAlertViewButtonShadowColor     PL_COLOR_GRAY
#define kAlertViewButtonShadowOffset    CGSizeMake(0, -1)

#define kAlertViewBackgroundCapHeight   38
#import "CustomAlertView.h"

@implementation CustomAlertView

@synthesize bg_AlertMain;
@synthesize btn_ClickLeft;
@synthesize btn_ClickLeft_on;
@synthesize btn_ClickRight;
@synthesize btn_ClickRight_on;
@synthesize index;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(bg_AlertMain);
    SAFE_RELEASE(btn_ClickLeft);
    SAFE_RELEASE(btn_ClickLeft_on);
    SAFE_RELEASE(btn_ClickRight);
    SAFE_RELEASE(btn_ClickRight_on);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)layoutSubviews{
    CGSize alertViewSize;
     
    for (UIView *v in self.subviews) {
        //背景
        if ([v isKindOfClass:[UIImageView class]])
        {
            UIImage *image = [UIImage imageNamed:bg_AlertMain];
            image = [[image stretchableImageWithLeftCapWidth:0 topCapHeight:kAlertViewBackgroundCapHeight] retain];
            alertViewSize = image.size;
            UIImageView *imageV = (UIImageView *)v;
            if(index)
            {
                imageV.frame=CGRectMake(0, -110, alertViewSize.width, alertViewSize.height);
            }
            else
            {
                imageV.frame=CGRectMake(0, 0, alertViewSize.width, alertViewSize.height);
            }
            [imageV setImage:image];
            [image release];
        }
        //文字
        if ([v isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)v;
            if ([label.text isEqualToString:self.title])
            {
                label.font = kAlertViewTitleFont;
                label.numberOfLines = 0;
                label.lineBreakMode = NSLineBreakByCharWrapping;
                label.textColor = PL_COLOR_GRAY;;
                label.backgroundColor = PL_COLOR_GRAY;
                label.textAlignment = UITextAlignmentCenter;
                label.shadowColor = kAlertViewTitleShadowColor;
                label.shadowOffset = kAlertViewTitleShadowOffset;
            }
            else
            {
                label.font = kAlertViewMessageFont;
                label.numberOfLines = 0;
                label.frame=CGRectMake(40, 30, 200, 20);
                label.lineBreakMode = NSLineBreakByCharWrapping;
                label.textColor = [PanliHelper colorWithHexString:@"#525872"];
                label.backgroundColor = PL_COLOR_GRAY;
                label.textAlignment = UITextAlignmentCenter;
                label.shadowColor = PL_COLOR_GRAY;;
                label.shadowOffset = kAlertViewMessageShadowOffset;
            }
        }
        
        //按钮
        if ([v isKindOfClass:NSClassFromString(@"UIAlertButton")])
        {
            UIButton *button = (UIButton *)v;
           
            UIImage *image = nil;
            UIImage * image_on=nil;
            if (button.tag == 1)
            {
                image = [UIImage imageNamed:btn_ClickRight];
                image_on=[UIImage imageNamed:btn_ClickRight_on];
                button.frame=CGRectMake(145, 60, 100, 35);
            }
            else
            {
                image = [UIImage imageNamed:btn_ClickLeft];
                image_on=[UIImage imageNamed:btn_ClickLeft_on];
                button.frame=CGRectMake(35, 60, 100, 35);
            }
                                    
            image = [image stretchableImageWithLeftCapWidth:(int)(image.size.width+1)>>1 topCapHeight:0];
            button.titleLabel.font = kAlertViewButtonFont;
            button.titleLabel.shadowOffset = kAlertViewButtonShadowOffset;
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image_on forState:UIControlStateHighlighted];
            [button setTitleColor:kAlertViewButtonTextColor forState:UIControlStateNormal];
            [button setTitleColor:kAlertViewButtonTextColor forState:UIControlStateHighlighted];
            [button setTitleShadowColor:kAlertViewButtonShadowColor forState:UIControlStateNormal];
            [button setTitleShadowColor:kAlertViewButtonShadowColor forState:UIControlStateHighlighted];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}
*/

@end
