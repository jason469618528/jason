//
//  SearchHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "SearchHomeViewController.h"
#import "LoginViewController.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface SearchHomeViewController ()

@end

@implementation SearchHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
//    //
//    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
//    view_Header.backgroundColor = [UIColor whiteColor];
//    view_Header.layer.borderColor = [UIColor blueColor].CGColor;
//    view_Header.layer.borderWidth = 10.0f;
//    view_Header.layer.cornerRadius = 50.0f;
////    view_Header.layer.masksToBounds = YES;
//    [[view_Header layer] setShadowOffset:CGSizeMake(0.0f, 0.0f)];
//    [[view_Header layer] setShadowRadius:1];
//    [[view_Header layer] setShadowOpacity:1];
//    [[view_Header layer] setShadowColor:[UIColor blackColor].CGColor];
//    [self.view addSubview:view_Header];
//    
//    
//    UIImageView *imageTest = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 21.0f)];
//    imageTest.image = [UIImage imageNamed:@"Image-4"];
//    [self.view addSubview:imageTest];
    
    
//    UIView *sv = [UIView new];
//    sv.backgroundColor = [UIColor blackColor];
//    WS(ws);
//    [self.view addSubview:sv];
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(ws.view).offset(-10);
//        make.height.mas_equalTo(100);
//    }];
    
//    WS(ws);
//    UIView *sv1 = [UIView new];
//    sv1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:sv1];
//    
//    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//        // 等价于
//         make.top.equalTo(ws.view).with.offset(10);
//         make.left.equalTo(ws.view).with.offset(10);
//         make.bottom.equalTo(ws.view).offset(-10);
//         make.right.equalTo(ws.view).offset(-10);
//         
//        /* 也等价于
//         make.top.left.bottom.and.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//         */
//    }];
    
    __weak typeof(UIViewController*) weaSelf = self;
    UIView *left_View = [[UIView alloc] init];
    left_View.backgroundColor = J_COLOR_GRAY;
    [self.view addSubview:left_View];
    
    
    UIView *right_View = [[UIView alloc] init];
    right_View.backgroundColor = J_COLOR_RED;
    [self.view addSubview:right_View];
    
    int padding1 = 10;
    [left_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weaSelf.view.mas_centerY);
        make.left.equalTo(weaSelf.view).with.offset(padding1);
        make.right.equalTo(right_View.mas_left).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(right_View);
    }];
    
    [right_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weaSelf.view.mas_centerY);
        make.left.equalTo(left_View.mas_right).with.offset(padding1);
        make.right.equalTo(weaSelf.view.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(left_View);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnNameClick:(id)sender
{
    NSLog(@"asdfadsfadsfassfsad");
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end
