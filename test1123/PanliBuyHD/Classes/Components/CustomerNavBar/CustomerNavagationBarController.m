//
//  CustomerNavagationBarController.m
//  PanliApp
//
//  Created by Liubin on 13-4-12.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomerNavagationBarController.h"
#import <QuartzCore/QuartzCore.h>

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view
@interface CustomerNavagationBarController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation CustomerNavagationBarController

-(void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    self.screenShotsList = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
//        self.canDragBack = YES;
    }
    return self;
}

- (void)loadView
{    
    [super loadView];
    backgroundImage = [self createImageWithColor:[UIColor whiteColor]];
}
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIImage *capturedImage = [self capture];
    if (capturedImage)
    {
        [self.screenShotsList addObject:capturedImage];
    }
    [super pushViewController:viewController animated:animated];
    
    UIImageView *navBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height)];
    navBackgroundImageView.tag = 1001;

    navBackgroundImageView.contentMode = UIViewContentModeScaleToFill;

    navBackgroundImageView.image = backgroundImage;

    [self.navigationBar insertSubview:navBackgroundImageView atIndex:0];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
    
    UIImageView *navBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height)];
    navBackgroundImageView.tag = 1001;

    navBackgroundImageView.contentMode = UIViewContentModeScaleToFill;

    navBackgroundImageView.image = backgroundImage;

    [self.navigationBar insertSubview:navBackgroundImageView atIndex:0];
    
    
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.screenShotsList.count == 0) {
        
        UIImage *capturedImage = [self capture];
        
        if (capturedImage)
        {
            [self.screenShotsList addObject:capturedImage];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置背景图
    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];

    //向后滑动view返回功能
//    UIPanGestureRecognizer *recognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                                 action:@selector(paningGestureReceive:)]autorelease];
//    recognizer.delegate = self;
//    [recognizer delaysTouchesBegan];
//    [self.view addGestureRecognizer:recognizer];
}
#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
//- (void)moveViewWithX:(float)x
//{
//    
//    NSLog(@"Move to:%f",x);
//    x = x>320?320:x;
//    x = x<0?0:x;
//    
//    CGRect frame = TOP_VIEW.frame;
//    frame.origin.x = x;
//    TOP_VIEW.frame = frame;
//    
//    float scale = (x/6400)+0.95;
//    float alpha = 0.4 - (x/800);
//    
//    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
//    blackMask.alpha = alpha;
//    
//}

#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if (self.viewControllers.count <= 1 || !self.canDragBack)
//    {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - Gesture Recognizer -
//- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
//{
//    // If the viewControllers has only one vc or disable the interaction, then return.
//    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
//    
//    // we get the touch position by the window's coordinate
//    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
//    
//    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
//    if (recoginzer.state == UIGestureRecognizerStateBegan) {
//        
//        _isMoving = YES;
//        startTouch = touchPoint;
//        
//        if (!self.backgroundView)
//        {
//            CGRect frame = TOP_VIEW.frame;
//            
//            self.backgroundView = [[[UIView alloc]initWithFrame:CGRectMake(0,IS_IOS7 ? 0 : 20, frame.size.width , frame.size.height)]autorelease];
//            [TOP_VIEW.superview insertSubview:self.backgroundView belowSubview:TOP_VIEW];
//            
//            blackMask = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)]autorelease];
//            blackMask.backgroundColor = [UIColor blackColor];
//            [self.backgroundView addSubview:blackMask];
//        }
//        
//        self.backgroundView.hidden = NO;
//        
//        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
//        
//        UIImage *lastScreenShot = [self.screenShotsList lastObject];
//        lastScreenShotView = [[[UIImageView alloc]initWithImage:lastScreenShot]autorelease];
//        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
//        
//        //End paning, always check that if it should move right or move left automatically
//    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
//        
//        if (touchPoint.x - startTouch.x > 50)
//        {
//            [UIView animateWithDuration:0.3 animations:^{
//                [self moveViewWithX:320];
//            } completion:^(BOOL finished) {
//                
//                [self popViewControllerAnimated:NO];
//                CGRect frame = TOP_VIEW.frame;
//                frame.origin.x = 0;
//                TOP_VIEW.frame = frame;
//                
//                _isMoving = NO;
//                self.backgroundView.hidden = YES;
//                
//            }];
//        }
//        else
//        {
//            [UIView animateWithDuration:0.3 animations:^{
//                [self moveViewWithX:0];
//            } completion:^(BOOL finished) {
//                _isMoving = NO;
//                self.backgroundView.hidden = YES;
//            }];
//            
//        }
//        return;
//        
//        // cancal panning, alway move to left side automatically
//    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            [self moveViewWithX:0];
//        } completion:^(BOOL finished) {
//            _isMoving = NO;
//            self.backgroundView.hidden = YES;
//        }];
//        
//        return;
//    }
//    
//    // it keeps move with touch
//    if (_isMoving) {
//        [self moveViewWithX:touchPoint.x - startTouch.x];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
