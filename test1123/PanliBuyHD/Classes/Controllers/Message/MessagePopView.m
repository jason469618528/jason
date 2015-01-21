//
//  MessagePopView.m
//  PanliApp
//
//  Created by Liubin on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessagePopView.h"
#import "UserInfo.h"
#import "CustomUIImageView.h"

@implementation MessagePopView

@synthesize txt_InputView = _txt_InputView;
@synthesize btn_PopButton = _btn_PopButton;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_txt_InputView);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [PanliHelper colorWithHexString:@"#dcdde1"];
        self.layer.borderColor = [PL_COLOR_WHITE CGColor];
        self.layer.borderWidth = 1.0;
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5.0;
        
        CustomUIImageView *img_message = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        img_message.image = [UIImage imageNamed:@"icon_message"];
        img_message.layer.cornerRadius = 5.0f;
        img_message.layer.masksToBounds = YES;
        img_message.layer.borderColor = [PL_COLOR_GRAY CGColor];
        img_message.layer.borderWidth = 0.5f;
        img_message.userInteractionEnabled = NO;
        UserInfo *userInfo = [GlobalObj getUserInfo];
        [img_message setCustomImageWithURL:[NSURL URLWithString:userInfo.avatarUrl]
                          placeholderImage:[UIImage imageNamed:@"icon_msgDetail_user"]];
        [self addSubview:img_message];
        [img_message release];
        
        UIImageView *img_input = [[UIImageView alloc] initWithFrame:CGRectMake(55, 27, 25, 6)];
        img_input.image = [UIImage imageNamed:@"icon_msgDetail_dot"];
        [self addSubview:img_input];
        [img_input release];
        
        _txt_InputView = [[UITextView alloc] initWithFrame:CGRectMake(5, 55, MainScreenFrame_Width - 65 - 80, 55.5)];
        _txt_InputView.font = DEFAULT_FONT(15);
        _txt_InputView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _txt_InputView.layer.cornerRadius = 4.0f;
        _txt_InputView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _txt_InputView.layer.borderWidth = 0.5f;
        [self addSubview:_txt_InputView];
        
        //输入框
        UITextField *txt_fieldView = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, MainScreenFrame_Width - 65 - 80, 20)];
        txt_fieldView.backgroundColor = PL_COLOR_CLEAR;
        txt_fieldView.font = DEFAULT_FONT(15);
        txt_fieldView.textColor = [UIColor blackColor];
        txt_fieldView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [_txt_InputView addSubview:txt_fieldView];
        [txt_fieldView release];
        
        //发送按钮
        _btn_PopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_PopButton setBackgroundImage:[UIImage imageNamed:@"btn_msgDetail_send"] forState:UIControlStateNormal];
        [_btn_PopButton setBackgroundImage:[UIImage imageNamed:@"btn_msgDetail_send_on"] forState:UIControlStateHighlighted];
        _btn_PopButton.frame = CGRectMake(MainScreenFrame_Width - 65 - 70,55,60,55);
        [_btn_PopButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_PopButton];
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
