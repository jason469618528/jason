//
//  UserShareViewController.m
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareViewController.h"
#import "UserShareResultViewController.h"
#import "UpdateVersionView.h"
#import "CustomerUpdateVersion.h"
#import "UIImage+ImageScale.h"
#import "CustomUIImageView.h"

#define UPDATEVERSION_USERSHARE @"UserShareView"
@interface UserShareViewController ()

@end

@implementation UserShareViewController
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(req_MakeShare);
    SAFE_RELEASE(rpt_MakeShare);
    SAFE_RELEASE(req_ShareBuyTopics);
    SAFE_RELEASE(rpt_ShareBuyTopics);
    self.mProduct = nil;
    self.topicArray = nil;
    self.imagePicker = nil;
    self.picturePathArray = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:YES];
	
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = LocalizedString(@"UserShareViewController_Nav_Title",@"分享商品");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#EEEEEE"];
    
    //初始化数据
    self.topicArray = [[[NSMutableArray alloc] init] autorelease];
    self.picturePathArray = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    uploadingButton = nil;
    rateScore = 0.0;
    
    //商品缩略图
    CustomUIImageView *img_Product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 80.0f, 80.0f)];
    [img_Product setCustomImageWithURL:[NSURL URLWithString:self.mProduct.thumbnail] placeholderImage:[UIImage imageNamed: @"bg_SubjectNone_Product"]];
    [img_Product layer].borderColor = [PanliHelper colorWithHexString:@"#DFDFDF"].CGColor;
    [img_Product layer].borderWidth = 0.5;
    [self.view addSubview:img_Product];
    [img_Product release];
    
    //商品名称
    UILabel *lab_ProductName = [[UILabel alloc] initWithFrame:CGRectMake(110.0f, 10.0f, MainScreenFrame_Height - 340.0f, 50.0f)];
    lab_ProductName.numberOfLines = 2;
    lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#6C6C6C"];
    lab_ProductName.font = DEFAULT_FONT(16);
    lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
    lab_ProductName.text = self.mProduct.productName;
    [self.view addSubview:lab_ProductName];
    [lab_ProductName release];

    //商品备注
    UILabel *lab_skuRemark = [[UILabel alloc] initWithFrame:CGRectMake(110.0f, 65.0f, MainScreenFrame_Height - 340.0f, 25.0f)];
    lab_skuRemark.numberOfLines = 2;
    lab_skuRemark.textColor = [PanliHelper colorWithHexString:@"#6C6C6C"];
    lab_skuRemark.font = DEFAULT_FONT(16);
    lab_skuRemark.backgroundColor = PL_COLOR_CLEAR;
    lab_skuRemark.text = self.mProduct.skuRemark;
    [self.view addSubview:lab_skuRemark];
    [lab_skuRemark release];
    
    //商品评分
    UILabel *lab_rate = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 110.0f, 90.0f, 20.0f)];
    lab_rate.textColor = [PanliHelper colorWithHexString:@"#6C6C6C"];
    lab_rate.font = DEFAULT_FONT(16);
    lab_rate.backgroundColor = PL_COLOR_CLEAR;
    lab_rate.text = LocalizedString(@"UserShareViewController_labRate",@"商品评分:");
    [self.view addSubview:lab_rate];
    [lab_rate release];
    
    RatingView *rateView = [[RatingView alloc] initWithFrame:CGRectMake(100.0f, 110.0f, 150.0f, 10.0f)];
    [rateView setImagesDeselected:@"icon_ShipRate_star_none" partlySelected:@"icon_ShipDetail_star" fullSelected:@"icon_ShipDetail_star" andDelegate:self state:5];
    [self.view addSubview:rateView];
    [rateView release];
    
    //分享内容输入框
    txt_description = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 145.0f, 500.0f, 100.0f)];
    txt_description.font = DEFAULT_FONT(15);
    txt_description.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_description.returnKeyType = UIReturnKeyDone;
    txt_description.layer.cornerRadius = 1.0f;
    txt_description.layer.borderColor = [[PanliHelper colorWithHexString:@"#DEDEDE"] CGColor];
    txt_description.layer.borderWidth = 0.5f;
    txt_description.delegate = self;
    [self.view addSubview:txt_description];
    [txt_description release];

    topicView = [[UserShareTopicView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 0.0f)];
    topicView.delegate = self;
    topicView.topicArray = self.topicArray;
    [self.navigationController.view addSubview:topicView];
    [topicView release];
    
    float x = 0;
    for (int i = 0; i < 5; i++)
    {
        x += 15;
        CustomUIButton *btn_upload = [[CustomUIButton alloc] initWithFrame:CGRectMake(x, 270.0f, 46.0f, 46.0f)];
        btn_upload.tag = 1000+i;
        [btn_upload setImage:[UIImage imageNamed:@"btn_userShare_upload"] forState:UIControlStateNormal];
        [btn_upload addTarget:self action:@selector(uploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_upload];
        [btn_upload release];
        x += 46;
    }
    
    //分享按钮
    UIImageView *img_bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72.0f - 50.0f, MainScreenFrame_Height - 300, 50.0f)];
    img_bottom.image = [UIImage imageNamed:@"bg_userShare_bottom"];
    [self.view addSubview:img_bottom];
    [img_bottom release];
    
    UIButton *btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_share.frame = CGRectMake((MainScreenFrame_Height - 300 - 153)/2, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72 - 50 + 9, 153.0f, 33.0f);
    [btn_share setImage:[UIImage imageNamed:@"btn_userShare_share"] forState:UIControlStateNormal];
    [btn_share setImage:[UIImage imageNamed:@"btn_userShare_share_on"] forState:UIControlStateHighlighted];
    [btn_share addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_share];
    
    //添加手势
    UITapGestureRecognizer *hideKeyboardTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [hideKeyboardTap setNumberOfTapsRequired:1];
    [hideKeyboardTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:hideKeyboardTap];
    [hideKeyboardTap release];
    
    //蒙板
    [CustomerUpdateVersion updateVersionWithKey:UPDATEVERSION_USERSHARE complete:^{
        UpdateVersionView *guideView = [[UpdateVersionView alloc] initWithFrame:CGRectMake(0.0f,0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT) shadowLayerImage: (IS_568H ? [UIImage imageNamed:@"bg_UpdateVersion_UserShare_h568"] : [UIImage imageNamed:@"bg_UpdateVersion_UserShare"])];
        [self.tabBarController.view addSubview:guideView];
        [guideView release];
        
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(makeShareResponse:)
//                                                 name:RQNAME_SHARE_MakeShare
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getShareBuyTopicsResponse:)
//                                                 name:RQNAME_SHARE_SHARETOPICS_USERSHARE
//                                               object:nil];
    [self shareBuyTopicsRequest];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * 功能描述: 上传图片安妞妞
 * 输入参数: btn
 * 返 回 值: N/A
 */
- (void)uploadClick:(CustomUIButton*)btn
{
    uploadingButton = btn;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:LocalizedString(@"UserShareViewController_ActionSheet_Title",@"上传图片")
                                                             delegate:self
                                                    cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LocalizedString(@"UserShareViewController_ActionSheet_OthBtn1",@"从相册中选取美照"),
                                  LocalizedString(@"UserShareViewController_ActionSheet_OthBtn2",@"立即拍摄美照"),
                                  LocalizedString(@"UserShareViewController_ActionSheet_OthBtn3",@"删除"), nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

/**
 * 功能描述: 分享
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void)shareClick
{
    if (rateScore == 0)
    {
        [self showHUDErrorMessage:LocalizedString(@"UserShareViewController_HUDErrMsg1",@"请为您的商品评分")];
        return;
    }
    NSString *content = [txt_description.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([NSString isEmpty:content])
    {
        [self showHUDErrorMessage:LocalizedString(@"UserShareViewController_HUDErrMsg2",@"请填写分享内容")];
        return;
    }
    [self makeShareRequest];
}

#pragma mark - request and response
- (void)shareBuyTopicsRequest
{
    req_ShareBuyTopics = req_ShareBuyTopics ? req_ShareBuyTopics : [[ShareTopicsRequest alloc] init];
    rpt_ShareBuyTopics = rpt_ShareBuyTopics ? rpt_ShareBuyTopics : [[DataRepeater alloc] initWithName:RQNAME_SHARE_SHARETOPICS_USERSHARE];
    
    
    rpt_ShareBuyTopics.notificationName = RQNAME_SHARE_SHARETOPICS_USERSHARE;
    rpt_ShareBuyTopics.requestModal = PullData;
    rpt_ShareBuyTopics.networkRequest = req_ShareBuyTopics;
    
    rpt_ShareBuyTopics.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_ShareBuyTopics.compleBlock = ^(id repeater){
        [weakSelf getShareBuyTopicsResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_ShareBuyTopics];
}

- (void)getShareBuyTopicsResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        self.topicArray = repeater.responseValue;
        topicView.topicArray = self.topicArray;
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}

-(void)makeShareRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"UserShareViewController_HUDIndMsg",@"正在提交...")];
    req_MakeShare = req_MakeShare ? req_MakeShare : [[MakeShareRequest alloc] init];
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setValue:[NSString stringWithFormat:@"%d",self.mProduct.shareProductId] forKey:RQ_MAKESHARE_PARM_PRODUCTID];
    [params setValue:[NSString stringWithFormat:@"%.0f",rateScore] forKey:RQ_MAKESHARE_PARM_SCORE];
    NSString *content = [txt_description.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [params setValue:content forKey:RQ_MAKESHARE_PARM_DESCRIPTION];
    [params setValue:self.picturePathArray forKey:RQ_MAKESHARE_PARM_PICTURES];
    rpt_MakeShare = rpt_MakeShare ? rpt_MakeShare : [[DataRepeater alloc]initWithName:RQNAME_SHARE_MakeShare];
    rpt_MakeShare.requestParameters = params;
    rpt_MakeShare.notificationName = RQNAME_SHARE_MakeShare;
    rpt_MakeShare.requestModal = PushData;
    rpt_MakeShare.networkRequest = req_MakeShare;
    
    rpt_MakeShare.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_MakeShare.compleBlock = ^(id repeater){
        [weakSelf makeShareResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_MakeShare];
}

-(void)makeShareResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        UserShareResultViewController *resultVC = [[[UserShareResultViewController alloc] init] autorelease];
        [self.navigationController pushViewController:resultVC animated:YES];
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        [self showHUDErrorMessage:errorInfo.message];
    }
}


#pragma mark - RateView Delegate
-(void)ratingChanged:(float)newRating inid:(NSString *)sender
{
    rateScore = newRating;
}

#pragma mark - UITextView Delegate
#define KEYBOARD_HEIGHT 250
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    float height =  MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - (textView.frame.origin.y + textView.frame.size.height);
    if (height < KEYBOARD_HEIGHT)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.frame = CGRectInset(self.view.frame, 0.0, height - KEYBOARD_HEIGHT);
        }];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    float height =  MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - (textView.frame.origin.y + textView.frame.size.height);
    if (height < KEYBOARD_HEIGHT)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.frame = CGRectInset(self.view.frame, 0.0, KEYBOARD_HEIGHT - height);
        }];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.view endEditing:YES];
        return NO;
    }
    if ([text isEqualToString:@"#"] && self.topicArray && self.topicArray.count > 0)
    {
        [textView endEditing:YES];
        [topicView action];
    }
    return YES;
}

#pragma mark - actionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.delegate = self;
            ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:ipc animated:YES];
            ipc.allowsEditing = YES;
            self.imagePicker = ipc;
            [ipc release];
            break;
        }
        case 1:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.delegate = self;
            ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:ipc animated:YES];
            ipc.allowsEditing = YES;
            self.imagePicker = ipc;
            [ipc release];
            break;
        }
        case 2:
        {
            [uploadingButton setImage:[UIImage imageNamed:@"btn_userShare_upload"] forState:UIControlStateNormal];
            NSInteger btnIndex = uploadingButton.tag - 1000;
            if (self.picturePathArray.count > btnIndex)
            {
                [self.picturePathArray removeObjectAtIndex:btnIndex];
            }
        }
            
        default:
            break;
    }
}


#pragma mark - ShareTopicView Delegate
- (void)topicDidSelectedWithIndex:(int)index
{
    NSString *description = txt_description.text;
    ShareBuyTopic *mShareBuyTopic = [self.topicArray objectAtIndex:index];
    NSString *topic = [NSString stringWithFormat:@"#%@#",mShareBuyTopic.name];
    description = [description stringByAppendingString:topic];
    txt_description.text = description;
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:NO];
    if (image)
    {
//        UIImage *newImage = [img scaleToFullWidthSize];
//        [uploadingButton setImage:newImage forState:UIControlStateNormal];
//        //更新图片数组
//        int buttonIndex = uploadingButton.tag - 1000;
//        NSData *imageData = UIImageJPEGRepresentation(newImage,0.75);
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
//        timeSp = [timeSp stringByAppendingString:@".jpeg"];
//        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:timeSp];
//        [imageData writeToFile:filePath atomically:YES];
//        if (self.picturePathArray.count > buttonIndex)
//        {
//            [self.picturePathArray replaceObjectAtIndex:buttonIndex withObject:imageData];
//        }
//        else
//        {
//            [self.picturePathArray addObject:imageData];
//        }
        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
    }
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)useImage:(UIImage *)image
{
     UIImage *newImage = [image scaleToFullWidthSize];
    [uploadingButton setImage:newImage forState:UIControlStateNormal];
    NSInteger buttonIndex = uploadingButton.tag - 1000;
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.75);
    if (self.picturePathArray.count > buttonIndex)
    {
        [self.picturePathArray replaceObjectAtIndex:buttonIndex withObject:imageData];
    }
    else
    {
        [self.picturePathArray addObject:imageData];
    }
}

@end
