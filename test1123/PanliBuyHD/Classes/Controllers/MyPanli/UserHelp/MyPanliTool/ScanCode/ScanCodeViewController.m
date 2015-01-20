//
//  ScanCodeViewController.m
//  PanliApp
//
//  Created by jason on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "SVWebViewController.h"
@interface ScanCodeViewController ()

@end

@implementation ScanCodeViewController

#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_readerView start];
    lab_ScanData.text = nil;
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:IS_568H ? 210.0f : 205.0f];
    rotationAnimation.duration = 2.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.autoreverses = YES;
    [bg_Line.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"ScanCodeViewController_Nav_Title",@"扫一扫");
    
    //zbar初始化
    _readerView = [[ZBarReaderView alloc] init];
    _readerView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, self.view.frame.size.height);
    _readerView.readerDelegate = self;
    //关闭闪光灯
    _readerView.torchMode = 0;
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(_readerView.frame) - 126, MainScreenFrame_Width, MainScreenFrame_Height);
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR)
    {
        ZBarCameraSimulator *cameraSimulator = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = _readerView;
        [cameraSimulator release];
    }
    [self.view addSubview:_readerView];
    [_readerView release];
    
    //扫描区域计算
    _readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:self.readerView.bounds];
    

    
    UIImageView * bg_Main=[[UIImageView alloc]initWithImage:IS_568H ? [PanliHelper getImageFileByName:@"bg_scan_main_h568@2x.png"]:[PanliHelper getImageFileByName:@"bg_scan_main@2x.png"]];
    bg_Main.frame=CGRectMake(0, 0, MainScreenFrame_Width,IS_568H ? 504 : 416);
    [self.view addSubview:bg_Main];
    [bg_Main release];

    
//    UISwitch *swi_editRemark = [[UISwitch alloc] initWithFrame:CGRectMake(10.0f,MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 55.0f, 60.0f, 25.0f)];
//    [swi_editRemark addTarget:self action:@selector(scanLightButtonClick:)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:swi_editRemark];
//    [swi_editRemark release];
//    
    //线条
    bg_Line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_scan_line"]];
    bg_Line.frame = CGRectMake(55.0f,IS_568H ? 120.0f : 90.0f, 212.5f, 3.0f);
    [self.view addSubview:bg_Line];
    [bg_Line release];
    
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:IS_568H ? 210.0f : 205.0f];
//    rotationAnimation.duration = 2.0f;
//    rotationAnimation.cumulative = Amwwvf668
    
//    rotationAnimation.repeatCount = HUGE_VALF;
//    rotationAnimation.autoreverses = YES;
//    [bg_Line.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    lab_ScanData = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 55.0f, 200.0f, 20.0f)];
    lab_ScanData.backgroundColor = PL_COLOR_CLEAR;
    lab_ScanData.textColor = PL_COLOR_RED;
    [self.view addSubview:lab_ScanData];
    [lab_ScanData release];
}

/**
 *扫描灯光开关
 */
//- (void)scanLightButtonClick:(UISwitch*)bSwitch
//{
//    if(bSwitch.isOn)
//    {
//        _readerView.torchMode = 1;
//    }
//    else
//    {
//        _readerView.torchMode = 0;
//    }
//}


/**
 *Set ScanGrop
 */
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    return CGRectMake(x, y, width, height);
}

/**
 *ScanDelegate
 */
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    NSString *scanString;
    for (ZBarSymbol *symbol in symbols)
    {
        NSLog(@"%@", symbol.data);
        scanString = symbol.data;
        lab_ScanData.text = scanString;
        [self scanCodeReload];
        break;
    }
    [_readerView stop];
}

- (void)scanCodeReload
{
    [bg_Line.layer removeAllAnimations];
    NSString *url = lab_ScanData.text;
    if([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"])
    {
        SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithAddress:url] autorelease];
        webViewController.type = 1;
        //返回
        UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
        [btn_nav_back addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
        btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
        btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
        UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
        webViewController.navigationItem.leftBarButtonItem = btn_Left;
        [btn_Left release];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (void)BackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
