//
//  AddShipAddressViewController.m
//  PanliApp
//
//  Created by jason on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "AddShipAddressViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShipCountry.h"
#import "SelectShipCountryViewController.h"
#import "SelectAddressViewController.h"
//#import "SelectShipTypeViewController.h"
#import "UserToolHomeViewController.h"
//#import "ProductListViewController.h"
#import "DataRequestManager.h"
#import "CustomerNavagationBarController.h"

#define DEFAULT_TEXT_COLOR [PanliHelper colorWithHexString:@"#4fb138"]
@interface AddShipAddressViewController ()

@end

@implementation AddShipAddressViewController
@synthesize m_AddressObject;
@synthesize arr_OrderList;
@synthesize viewType = _viewType;

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
    [self viewDidLoadWithBackButtom:YES];
    
    if(_viewType)
    {
        self.navigationItem.title = LocalizedString(@"AddShipAddressViewController_NavItem1_Title",@"填写收货地址");
    }
    else
    {
         self.navigationItem.title = LocalizedString(@"AddShipAddressViewController_NavItem2_Title",@"1/3填写收货地址");
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#e8e8e8"];
    UIImage *bg = IS_568H ? [PanliHelper getImageFileByName:@"bg_AddressDetail_AddList_h568@2x.png"] : [PanliHelper getImageFileByName:@"bg_AddressDetail_AddList@2x.png"];
    UIImageView * bgimage=[[UIImageView alloc]init];
    bgimage.image = bg;
    bgimage.frame=CGRectMake(10.0f, 10.0f, bg.size.width, bg.size.height);
    [self.view addSubview:bgimage];
    
    str_Consignee = m_AddressObject.consignee;
    str_Country = m_AddressObject.country;
    str_City = m_AddressObject.city;
    str_Address = m_AddressObject.address;
    str_Zip = m_AddressObject.zip;
    str_Phone = m_AddressObject.telephone;
    
    text_Consignee = [self ReturnTextview:CGRectMake(113,IS_IOS7 ? 18: 23, 190, 30)];
    text_Consignee.text = str_Consignee;
    text_Consignee.tag = 1001;
   
    btn_Country = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Country.frame = CGRectMake(115, 52, 190, 30);
    [btn_Country setBackgroundColor:PL_COLOR_CLEAR];
    [btn_Country setTitle:[NSString isEmpty:str_Country] ? LocalizedString(@"AddShipAddressViewController_btnCountry1",@"点击选择运送区域") : str_Country forState:UIControlStateNormal];
    
    [btn_Country setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
    btn_Country.titleLabel.font = DEFAULT_FONT(15);
    NSString *tempStr = [NSString isEmpty:str_Country] ? LocalizedString(@"AddShipAddressViewController_btnCountry1",@"点击选择运送区域") : str_Country;
    CGSize maxSize = CGSizeMake(190.0f, 30.0f);
    CGSize scSize = [tempStr sizeWithFont:DEFAULT_FONT(15) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    float leftInset = (190 - scSize.width)/2;
    [btn_Country setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -leftInset*2, 0.0f, 0.0f)];
    [btn_Country addTarget:self action:@selector(CountryClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Country];
    
    text_City = [self ReturnTextview:CGRectMake(113, IS_IOS7 ? 83:88, 190, 30)];
    text_City.tag = 1003;
    text_City.text = str_City;
    
    text_Address = [[UITextView alloc] initWithFrame:CGRectMake(108, IS_IOS7 ? 108:113, 190, 62)];
	text_Address.returnKeyType = UIReturnKeyNext; //just as an example
	text_Address.font = DEFAULT_FONT(15);
    text_Address.textColor = DEFAULT_TEXT_COLOR;
	text_Address.delegate = self;
    text_Address.backgroundColor = PL_COLOR_CLEAR;
    text_Address.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    text_Address.tag = 1004;
    text_Address.text = str_Address;
   
    text_Zip = [self ReturnTextview:CGRectMake(113, IS_IOS7 ? 186:191, 190, 30)];
    text_Zip.tag = 1005;
    text_Zip.text = str_Zip;
    
    text_Phone = [self ReturnTextview:CGRectMake(113, IS_IOS7 ? 218:223, 190, 30)];
    text_Phone.tag = 1006;
    text_Phone.returnKeyType = UIReturnKeyDone;
    text_Phone.text = str_Phone;

    [self.view addSubview:text_Consignee];
    [self.view addSubview:text_City];
    [self.view addSubview:text_Address];
    [self.view addSubview:text_Zip];
    [self.view addSubview:text_Phone];
    
    //取消键盘 
    UITapGestureRecognizer * recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestrueRecognizerCanncel:)];
    recognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:recognizer];
  
    //下一步
    UIView *view_Bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0, MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f - 50.0f , MainScreenFrame_Height - 300.0f, 50.0f)];
    view_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#f3f3f3"];
    [[view_Bottom layer] setBorderWidth:1];
    [[view_Bottom layer] setBorderColor:[PanliHelper colorWithHexString:@"#cccccc"].CGColor];
    [self.view addSubview:view_Bottom];
    
    
    UIButton* btn_Next = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Next.frame = CGRectMake((320-248.0f)/2, 7.0f, 248.0f, 37.5f);
    
    //判断是否收货地址
    if(self.viewType)
    {
        [btn_Next setImage:[UIImage imageNamed:@"btn_SetAddress_AddAddress"] forState:UIControlStateNormal];
        [btn_Next setImage:[UIImage imageNamed:@"btn_SetAddress_AddAddress_on"] forState:UIControlStateHighlighted];
    }
    else
    {
        [btn_Next setImage:[UIImage imageNamed:@"btn_SetAddressHome_confirm"] forState:UIControlStateNormal];
        [btn_Next setImage:[UIImage imageNamed:@"btn_SetAddressHome_confirm_on"] forState:UIControlStateHighlighted];
    }
    [btn_Next addTarget:self action:@selector(nextStepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view_Bottom addSubview:btn_Next];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shipCountrySelected:)
                                                 name:@"SHIPCOUNTRYSELECTED"
                                               object:nil];
}

/**
 *重写父类返回方法
 */
- (void)barButtonItemClick:(UIButton *)btn
{
    
    //收货地址
    if(self.viewType)
    {
        //如果新增加地址一项为空返回顶页
        if(self.isNewAdd && ([NSString isEmpty:text_Address.text] || [NSString isEmpty:text_Address.text] || [NSString isEmpty:text_Address.text] || [NSString isEmpty:text_Address.text] || [NSString isEmpty:text_Address.text]))
        {
            //判断数据源是否为空
            if(self.mArr_AddressData == nil || self.mArr_AddressData.count <= 0)
            {
                NSArray *arr_NavView = self.navigationController.viewControllers;
                UIViewController *viewController = nil;
                for (int i = 0; i < arr_NavView.count; i++)
                {
                    if([[arr_NavView objectAtIndex:i] isMemberOfClass:[UserToolHomeViewController class]])
                    {
                        viewController = (UserToolHomeViewController*)[arr_NavView objectAtIndex:i];
                        [self.navigationController popToViewController:viewController animated:YES];
                        return;
                    }
                }
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            //编辑状态
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //提交运送
        
        //如果新增加地址一项为空返回顶页
        if(self.isNewAdd)
        {
            //判断是否有选择收货地址与商品列表（优先跳转到选择收货地址）
            NSArray *arr_NavView = self.navigationController.viewControllers;
            UIViewController *viewController = nil;
            for (int i = 0; i < arr_NavView.count; i++)
            {
                if([[arr_NavView objectAtIndex:i] isMemberOfClass:[SelectAddressViewController class]])
                {
                    viewController = (SelectAddressViewController*)[arr_NavView objectAtIndex:i];
                    continue;
                }
//                if([[arr_NavView objectAtIndex:i] isMemberOfClass:[ProductListViewController class]])
//                {
//                    viewController = (ProductListViewController*)[arr_NavView objectAtIndex:i];
//                    ((ProductListViewController*)viewController).isInpanli = YES;
//                    continue;
//                }
            }
            if(viewController)
            {
                [self.navigationController popToViewController:viewController animated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            //编辑状态
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (str_Country && ![NSString isEmpty:str_Country])
    {
        [btn_Country setTitle:str_Country forState:UIControlStateNormal];
        [btn_Country setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        CGSize maxSize = CGSizeMake(190.0f, 30.0f);
        CGSize scSize = [str_Country sizeWithFont:DEFAULT_FONT(15) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        float leftInset = (190 - scSize.width)/2;
        [btn_Country setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -leftInset*2, 0.0f, 0.0f)];
    }
    else
    {
        [btn_Country setTitle:LocalizedString(@"AddShipAddressViewController_btnCountry2",@"点击选择运送区域或国家") forState:UIControlStateNormal];
        
        [btn_Country setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        NSString *defaultCountry = LocalizedString(@"AddShipAddressViewController_btnCountry2",@"点击选择运送区域或国家");
        CGSize maxSize = CGSizeMake(190.0f, 30.0f);
        CGSize scSize = [defaultCountry sizeWithFont:DEFAULT_FONT(15) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        float leftInset = (190 - scSize.width)/2;
        [btn_Country setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -leftInset*2, 0.0f, 0.0f)];
    }    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
-(void)RequestAddress
{
    [self showHUDIndicatorMessage:LocalizedString(@"AddShipAddressViewController_HUDMsg",@"正在加载...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *str_ID = [NSString stringWithFormat:@"%d",m_AddressObject.deliveryAddressId];
    [params setValue: str_ID forKey:RQ_DELIVERYADDRESS_PARAM_ID];
    [params setValue: text_Consignee.text forKey:RQ_DELIVERYADDRESS_PARAM_CONSIGNEE];
    [params setValue: text_Zip.text forKey:RQ_DELIVERYADDRESS_PARAM_ZIP];
    [params setValue: text_Phone.text forKey:RQ_DELIVERYADDRESS_PARAM_TELEPHONE];
    [params setValue: str_Country forKey:RQ_DELIVERYADDRESS_PARAM_COUNTRY];
    [params setValue: text_City.text forKey:RQ_DELIVERYADDRESS_PARAM_CITY];
    [params setValue: text_Address.text forKey:RQ_DELIVERYADDRESS_PARAM_ADDRESS];
    
    data_AddChangeAddress =data_AddChangeAddress?data_AddChangeAddress: [[DataRepeater alloc]initWithName:RQNAME_UPDATADELIVERYADDRESS];
    req_AddChangeAddress = req_AddChangeAddress ? req_AddChangeAddress: [[AddChangeAddressRequest alloc]init];
    data_AddChangeAddress.networkRequest = req_AddChangeAddress;
    data_AddChangeAddress.notificationName = RQNAME_UPDATADELIVERYADDRESS;
    data_AddChangeAddress.isAuth = YES;
    __weak AddShipAddressViewController *addShipAddressVC = self;
    data_AddChangeAddress.compleBlock = ^(id repeater)
    {
        [addShipAddressVC AddChangeAddress:repeater];
    };
    data_AddChangeAddress.requestModal = PushData;
    data_AddChangeAddress.requestParameters = params;
    [[DataRequestManager sharedInstance] sendRequest:data_AddChangeAddress];
}

-(void)AddChangeAddress:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        //新增地址
        self.m_AddressObject.country = str_Country;
        self.m_AddressObject.consignee = text_Consignee.text;
        self.m_AddressObject.city = text_City.text;
        self.m_AddressObject.address = text_Address.text;
        self.m_AddressObject.zip = text_Zip.text;
        self.m_AddressObject.telephone = text_Phone.text;
        self.m_AddressObject.deliveryAddressId = [[NSString stringWithFormat:@"%@",repeater.responseValue]intValue];
        //        [self showHUDSuccessMessage:repeater.errorInfo.message];
        [self.view setUserInteractionEnabled:NO];
        [self performSelector:@selector(delNotification:) withObject:@"name" afterDelay:0.5f];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self.view setUserInteractionEnabled:YES];
}

- (void)shipCountrySelected:(NSNotification*)sender
{
    NSString *string = sender.object;
    if (![NSString isEmpty:string])
    {
        str_Country = string;
    }
}


#pragma mark - rightclick
-(void)nextStepButtonClick
{
    str_CountryID = [self CountryToString:str_Country];
    
    if(![text_Consignee.text isEqualToString:m_AddressObject.consignee]||![text_City.text isEqualToString:m_AddressObject.city]||![text_Address.text isEqualToString:m_AddressObject.address]||![text_Zip.text isEqualToString:m_AddressObject.zip]||![text_Phone.text isEqualToString:m_AddressObject.telephone]||![str_Country isEqualToString:m_AddressObject.country])
    {
        if([[text_Consignee text] isEqualToString:@""]||[[text_City text] isEqualToString:@""]||[[text_Address text] isEqualToString:@""]||[[text_Zip text] isEqualToString:@""]||[[text_Phone text] isEqualToString:@""])
        {
            [self showHUDErrorMessage:LocalizedString(@"AddShipAddressViewController_HUDErrorMessage1",@"请填写收货地址")];
            return;
        }
        if([NSString isEmpty:str_CountryID])
        {
            [self showHUDErrorMessage:LocalizedString(@"AddShipAddressViewController_HUDErrorMessage2",@"请选择国家地区")];
            return;
        }
        [self RequestAddress];
    }
    else
    {
        if([[text_Consignee text] isEqualToString:@""]||[[text_City text] isEqualToString:@""]||[[text_Address text] isEqualToString:@""]||[[text_Zip text] isEqualToString:@""]||[[text_Phone text] isEqualToString:@""]||[btn_Country.titleLabel.text isEqualToString:@""])
        {
            
            [self showHUDErrorMessage:LocalizedString(@"AddShipAddressViewController_HUDErrorMessage1",@"请填写收货地址")];
            return;
        }
        if([NSString isEmpty:str_CountryID])
        {
            [self showHUDErrorMessage:LocalizedString(@"AddShipAddressViewController_HUDErrorMessage2",@"请选择国家地区")];
            return;
        }
        //没有修改的情况下
        [self performSelector:@selector(delNotification:) withObject:@"name" afterDelay:0.5f];
        
    }
}

#pragma mark - 转换国家地址id
- (NSString * ) CountryToString:(NSString*)countryString
{
    NSArray *m_Country = [GlobalObj getShipCountry];
    NSString * str = nil;
    for(ShipCountry * pro in m_Country)
    {
        NSString * name= pro.name;
        if([name isEqualToString:str_Country])
        {
            str = [NSString stringWithFormat:@"%d", pro.shipCountryId];
        }
    }
    return str;
}

#pragma mark - 选择国家事件
-(void)CountryClick:(id)sender
{
    SelectShipCountryViewController *shipCountry = [[SelectShipCountryViewController alloc] init];
    shipCountry.str_ShipCountryName = str_Country;
    CustomerNavagationBarController *shipCountryViewController = [[CustomerNavagationBarController alloc] initWithRootViewController:shipCountry];
    [self.navigationController presentModalViewController:shipCountryViewController animated:YES];
}

#pragma mark - 延时方法
-(void)delNotification:(id)sender
{
    //在提交运送和收货地址薄 判断是否编辑状态 添加状态
    if(_viewType)
    {
        //收货地址薄
        if(self.isNewAdd)
        {
            [self.mArr_AddressData addObject:self.m_AddressObject];
            NSArray *arr_NavView = self.navigationController.viewControllers;
            for (int i = 0; i < arr_NavView.count; i++)
            {
                if([[arr_NavView objectAtIndex:i] isMemberOfClass:[SelectAddressViewController class]])
                {
                    ((SelectAddressViewController*)[arr_NavView objectAtIndex:i]).IsSelect = _mArr_AddressData.count - 1;
                    [self.navigationController popToViewController:[arr_NavView objectAtIndex:i] animated:YES];
                    break;
                }
            }
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    //判断是否为新加
    if(self.isNewAdd)
    {
        [self.mArr_AddressData addObject:self.m_AddressObject];
    }
    //选择运送方式
    [self.view setUserInteractionEnabled:YES];
//    SelectShipTypeViewController *selectArea = [[[SelectShipTypeViewController alloc]init]autorelease];
//    selectArea.arr_OrdersList = arr_OrderList;
//    selectArea.str_CountryID = str_CountryID;
//    selectArea.DeliveryAddress = self.m_AddressObject;
//    selectArea.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:selectArea animated:NO];
}

#pragma mark - textview
-(id)ReturnTextview:(CGRect)frame
{
    UITextField *text = [[UITextField alloc] initWithFrame:frame];
	text.returnKeyType = UIReturnKeyNext; //just as an example
	text.font = DEFAULT_FONT(15);
    text.textColor = DEFAULT_TEXT_COLOR;
	text.delegate = self;
    text.backgroundColor = PL_COLOR_CLEAR;
    text.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return text;
}

#pragma mark - 手势
-(void)GestrueRecognizerCanncel:(UIGestureRecognizer * )recognizer
{
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    self.view.frame =CGRectMake(0, IS_IOS7 ? 64 :0.0 , self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
    
    [text_Consignee resignFirstResponder];
    [text_City resignFirstResponder];
    [text_Address resignFirstResponder];
    [text_Zip resignFirstResponder];
    [text_Phone resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - (IS_IOS7 ? 240: 286.0));//键盘高度216
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        switch (textField.tag)
        {
            case 1001:
            {
                [text_Consignee resignFirstResponder];
                [text_City becomeFirstResponder];
                break;
            }
            case 1003:
            {
                [text_City resignFirstResponder];
                [text_Address becomeFirstResponder];
                break;
            }
            case 1005:
            {
                [text_Zip resignFirstResponder];
                [text_Phone becomeFirstResponder];
                break;
            }
            case 1006:
            {
                [text_Phone resignFirstResponder];
//                NSTimeInterval animationDuration = 0.30f;
//                [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//                [UIView setAnimationDuration:animationDuration];
//                
//                //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//                self.view.frame =CGRectMake(0, IS_IOS7 ? 64 :0.0 , self.view.frame.size.width, self.view.frame.size.height);
//                [UIView commitAnimations];
                break;
            }
            default:
                break;
        }
        return NO;
    }
    return YES;
}

#pragma mark - UitextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
//    CGRect frame = textView.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - (IS_IOS7 ? 240: 286.0));//键盘高度216
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        switch (textView.tag)
        {
            case 1004:
            {
                [text_Address resignFirstResponder];
                [text_Zip becomeFirstResponder];
                break;
            }
            default:
                break;
        }
        return NO;
    }
    return YES;
}

@end
