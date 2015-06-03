//
//  LoginViewController.m
//  PanliBuyHD
//
//  Created by jason on 15-1-27.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()<UIAlertViewDelegate>
{
    UIImageView *image_Arror;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_LoginTag;
@property (weak, nonatomic) IBOutlet UIButton *btn_RegisterTag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginWidth;
@end

@implementation LoginViewController


- (void) dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = J_COLOR_WHITE;
    
    
    if([UIScreen mainScreen].bounds.size.width <= 320)
    {
        self.loginWidth.constant -= 40.0f;
    }
    NSLog(@"%@----%@",self.btn_LoginTag,self.btn_RegisterTag);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
