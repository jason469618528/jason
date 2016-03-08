//
//  SearchDetailViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-15.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "CustomViewTest.h"
@interface SearchDetailViewController ()
{
    UIView *viewTest;
}
@property (nonatomic, copy) NSString  *warningText;
@property (nonatomic, copy) UITextField *txt_UserName;
@property (nonatomic, copy) UITextField *txt_PassWord;
@end

@implementation SearchDetailViewController
@synthesize warningText;
@synthesize txt_UserName;
@synthesize txt_PassWord;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab_Title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 50.0f, MainScreenFrame_Width, 18.0f)];
    lab_Title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab_Title];
    
    
    txt_UserName = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 100.0f, MainScreenFrame_Width - 40.0f, 40.0f)];
    txt_UserName.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:txt_UserName];
    
    
    txt_PassWord = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 160.0f, MainScreenFrame_Width - 40.0f, 40.0f)];
    txt_PassWord.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:txt_PassWord];
    
    
//    [txt_PassWord.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"输出:%@",x);
//    }];
//    
    //买家评价
    UIButton *btn_ProductEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_ProductEvaluate.frame = CGRectMake(0.0f, 450.0f, MainScreenFrame_Width, 44.5f);
    btn_ProductEvaluate.backgroundColor = J_COLOR_GRAY;
    [btn_ProductEvaluate addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_ProductEvaluate];
    
    [[RACObserve(self, warningText)
      filter:^(NSString *newString) {
          lab_Title.text = newString;
          return YES;
          //          return [newString hasPrefix:@"Success"];
      }]
     subscribeNext:^(NSString *newString) {
         btn_ProductEvaluate.enabled = [newString hasPrefix:@"Success"];
     }];
    
    
    RAC(self,self.warningText) = [RACSignal combineLatest:@[
                                                            RACObserve(self,self.txt_UserName.text),RACObserve(self, self.txt_PassWord.text)]
                                                   reduce:^(NSString *password, NSString *passwordConfirm)
    {
        if ([passwordConfirm isEqualToString:password])
        {
            return @"Success";
        }
        else if([password length] == 0 || [passwordConfirm length] ==0 )
        {
            return @"Please Input";
        }
        else
            return @"Input Error";
    }
];
    
//    CustomViewTest *viewTest = [[CustomViewTest alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
//    viewTest.backgroundColor = J_COLOR_CLEAR;
//    [self.view addSubview:viewTest];
//    
    
//    viewTest = [[UIView alloc] initWithFrame:CGRectMake((MainScreenFrame_Width - 100.f) / 2, 0.0f, 100.0f, 100.0f)];
//    viewTest.backgroundColor = J_COLOR_GRAY;
//    [self.view addSubview:viewTest];
//    

}


- (void)btnClick
{
    //添加放大效果
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    NSMutableArray *values = [NSMutableArray new];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [viewTest.layer addAnimation:animation forKey:nil];
    
//        CGMutablePathRef myPah = CGPathCreateMutable();
//        CGPathMoveToPoint(myPah, nil,50, 50);
//        CGPathAddCurveToPoint(myPah, nil, 50, 50, 60, 200, 200, 200);//这里的是控制点
//        [viewTest.layer addAnimation:[self keyframeAnimation:myPah durTimes:5 Rep:MAXFLOAT] forKey:nil];

    NSLog(@"11111");
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, (MainScreenFrame_Width - 100.f)/2, 50.0f);
    CGPathAddQuadCurveToPoint(thePath, NULL, 50, 50, 300.0f, 300.0f);
//    复制代码注：startPoint是起点，endPoint是终点，150，30是x,y轴的控制点，自行调整数值可以出现理想弧度效果
//    把路径给动画变量，设置个动画时间
    bounceAnimation.path = thePath;
    bounceAnimation.duration = 0.7;
//    复制代码最后把这个动画添加给view的layer
    [viewTest.layer addAnimation:bounceAnimation forKey:@"move"];
}


-(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    return animation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
