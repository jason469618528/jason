//
//  CustomerViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-13.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "CustomerNavgaionController.h"
#import "HomeViewController.h"
#import "HomeDetailViewController.h"

@interface CustomerNavgaionController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomerNavgaionController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.canBack = YES;
    
    //去掉bar半透明
//    self.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor blueColor];
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor blueColor];
    
//    self.navigationBar.backgroundColor =
//    UIImage *image = [self createImageWithColor:[UIColor blueColor]];
//    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
//    __weak typeof(id) weakSelf = self;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = weakSelf;
//    }
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}
    
- (UIImage*) createImageWithColor: (UIColor*) color
    {
        CGRect rect=CGRectMake(0,0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage;  
    }
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //关闭滑动手势
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
    [super pushViewController:viewController animated:animated];
}


- (void)handleNavigationTransition:(UIPanGestureRecognizer*)test
{

}

#pragma mark - UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //开启滑动手势
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] && self.canBack)
//    {
//        navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;  //支持横向
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //    return  UIInterfaceOrientationPortrait;
    return self.topViewController.interfaceOrientation;
}


@end
