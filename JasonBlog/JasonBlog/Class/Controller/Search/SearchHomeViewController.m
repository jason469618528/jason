//
//  SearchHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "SearchHomeViewController.h"
#import "LoginViewController.h"
#import "SearchDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface SearchHomeViewController ()
{
    UILabel *lab_Title;
}
@end

@implementation SearchHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
//    //
//    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 100.0f, 100.0f)];
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
    
//    __weak typeof(UIViewController*) weaSelf = self;
//    UIView *left_View = [[UIView alloc] init];
//    left_View.backgroundColor = J_COLOR_GRAY;
//    [self.view addSubview:left_View];
//    
//    
//    UIView *right_View = [[UIView alloc] init];
//    right_View.backgroundColor = J_COLOR_RED;
//    [self.view addSubview:right_View];
//    int padding1 = 10;
//    
//    [left_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weaSelf.view).offset(padding1);
//        make.left.equalTo(weaSelf.view).with.offset(padding1);
//        make.right.equalTo(right_View.mas_left).with.offset(-padding1);
//        make.bottom.equalTo(weaSelf.view).with.offset(-padding1);
//        make.width.mas_equalTo(right_View);
//    }];
//    
//    [right_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weaSelf.view).offset(padding1);
//        make.left.equalTo(right_View.mas_right).with.offset(padding1);
//        make.right.equalTo(weaSelf.view).with.offset(-padding1);
//        make.bottom.equalTo(weaSelf.view).with.offset(-padding1);
//        make.width.mas_equalTo(left_View);
//    }];
//
//    UIView *center_View = [[UIView alloc] init];
//    center_View.backgroundColor = J_COLOR_WHITE;
//    [left_View addSubview:center_View];
//    [center_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(left_View).with.insets(UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
//    }];
    
    
    
    lab_Title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 20.0f, 60.0f, 15.0f)];
    lab_Title.backgroundColor = J_COLOR_CLEAR;
    [self.view addSubview:lab_Title];
    
    
    //买家评价
    UIButton *btn_ProductEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_ProductEvaluate.frame = CGRectMake(0.0f, 50.0f, MainScreenFrame_Width, 44.5f);
    btn_ProductEvaluate.backgroundColor = J_COLOR_GRAY;
    [btn_ProductEvaluate addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_ProductEvaluate];

    
    
    
    //添加放大效果
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    NSMutableArray *values = [NSMutableArray new];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [values release];
//    [selectedButton.layer addAnimation:animation forKey:nil];
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
//    [lab_Title.layer addAnimation:animation forKey:nil];
//    lab_Title.text = @"123456";
    
    
    SearchDetailViewController *detailView = [[SearchDetailViewController alloc] init];
    detailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
//    [self configNowPlayingInfoCenter];
    lab_Title.text = @"12345";

}

-(void)configNowPlayingInfoCenter
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"name" forKey:MPMediaItemPropertyTitle];
        [dict setObject:@"singer" forKey:MPMediaItemPropertyArtist];
        [dict setObject:@"album" forKey:MPMediaItemPropertyAlbumTitle];
        
        UIImage *image = [UIImage imageNamed:@"LaunchImage@2x.png"];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent
{
    if (receivedEvent.type == UIEventTypeRemoteControl)
    {
        switch (receivedEvent.subtype)
        {
            case UIEventSubtypeRemoteControlPause:
            {
                NSLog(@"UIEventSubtypeRemoteControlPause");
                break;
            }
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                NSLog(@"UIEventSubtypeRemoteControlPreviousTrack");
                break;
            }
            case UIEventSubtypeRemoteControlNextTrack:
            {
                NSLog(@"UIEventSubtypeRemoteControlNextTrack");
                break;
            }
            case UIEventSubtypeRemoteControlPlay:
            {
                NSLog(@"UIEventSubtypeRemoteControlPlay");
                break;
            }
            default:
                break;  
        }  
    }  
}  

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNameClick:(id)sender
{
    //进入后台
    NSLog(@"%s",__FUNCTION__);
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Inmysong" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    [self.player setVolume:1];
    self.player.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    if(self.player)
    {
        [self.player play]; //播放
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];

//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    loginVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:loginVC animated:YES];
}
@end
