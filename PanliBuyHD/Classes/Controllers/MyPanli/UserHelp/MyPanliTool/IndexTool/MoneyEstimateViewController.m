//
//  MoneyEstimateViewController.m
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MoneyEstimateViewController.h"
#import "EstimateListViewController.h"
#import "SelectAddressViewController.h"
#import "CustomerNavagationBarController.h"
#import "SelectShipCountryViewController.h"
#define NUMBERS @".0123456789\n"
#define NUMBERSWEIGHT @"0123456789\n"
@interface MoneyEstimateViewController ()

@end

@implementation MoneyEstimateViewController

#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    [self viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"MoneyEstimateViewController_Nav_Title",@"费用估算");
    UIImageView * bg_Main=[[UIImageView alloc]initWithImage:[UIImage imageNamed:IS_568H ? @"bg_More_ConView_h568": @"bg_More_ConView"]];
    bg_Main.frame=CGRectMake(0.0f, 0.0f, 320,MainScreenFrame_Width-UI_NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:bg_Main];
    [bg_Main release];
    
       
    //收货区域
    UILabel *lab_Area = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 80, 17)];
    lab_Area.text = LocalizedString(@"MoneyEstimateViewController_labArea",@"收货区域:");
    lab_Area.backgroundColor = PL_COLOR_CLEAR;
    lab_Area.font = DEFAULT_FONT(16);
    [self.view addSubview:lab_Area];
    [lab_Area release];
    
    
    
    btn_Area = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Area.frame = CGRectMake(110, 30, 190, 38);
    [btn_Area setImage:[UIImage imageNamed:@"btn_SelectArea"] forState:UIControlStateNormal];
    [btn_Area setImage:[UIImage imageNamed:@"btn_SelectArea_on"] forState:UIControlStateHighlighted];
    [btn_Area addTarget:self action:@selector(selectAreaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Area];
    
    

    UIImageView * icon_Own=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_EstimateOwn"]];
    icon_Own.frame=CGRectMake(12, 35, 18,22.5);
    [self.view addSubview:icon_Own];
    [icon_Own release];
    
    //商品价格
    UILabel *lab_Price = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 80, 17)];
    lab_Price.text = LocalizedString(@"MoneyEstimateViewController_labPrice",@"商品价格:");
    lab_Price.backgroundColor = PL_COLOR_CLEAR;
    lab_Price.font = DEFAULT_FONT(16);
    [self.view addSubview:lab_Price];
    [lab_Price release];
    
    UIImageView * icon_Money=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_EstimateMoney"]];
    icon_Money.frame=CGRectMake(12, 95, 18,22.5);
    [self.view addSubview:icon_Money];
    [icon_Money release];
    
    txt_Price = [self GetTextField:CGRectMake(110, 90, 169, 38)];
    [txt_Price setBackground:[UIImage imageNamed:@"bg_Esmate_TextField"]];
    [self.view addSubview:txt_Price];
    
    
    UILabel *lab_Yuan = [[UILabel alloc]initWithFrame:CGRectMake(285, 100, 20, 17)];
    lab_Yuan.text = LocalizedString(@"MoneyEstimateViewController_labYuan",@"元");
    lab_Yuan.backgroundColor = PL_COLOR_CLEAR;
    lab_Yuan.font = DEFAULT_FONT(16);
    [self.view addSubview:lab_Yuan];
    [lab_Yuan release];
    
    //商品重量
    UILabel *lab_Weight = [[UILabel alloc]initWithFrame:CGRectMake(30, 160, 80, 17)];
    lab_Weight.text = LocalizedString(@"MoneyEstimateViewController_labWeight",@"商品重量:");
    lab_Weight.backgroundColor = PL_COLOR_CLEAR;
    lab_Weight.font = DEFAULT_FONT(16);
    [self.view addSubview:lab_Weight];
    [lab_Weight release];
    
    UIImageView * icon_OrderState_weight = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_EstimateWeightn"]];
    icon_OrderState_weight.frame = CGRectMake(12, 155, 18,22.5);
    [self.view addSubview:icon_OrderState_weight];
    [icon_OrderState_weight release];
    
    txt_Weight = [self GetTextField:CGRectMake(110, 150, 169, 38)];
    txt_Weight.keyboardType = UIKeyboardTypeNumberPad;
    [txt_Weight setBackground:[UIImage imageNamed:@"bg_Esmate_TextField"]];
    [self.view addSubview:txt_Weight];

    UILabel *lab_G = [[UILabel alloc]initWithFrame:CGRectMake(285, 160, 20, 17)];
    lab_G.text = @"g";
    lab_G.backgroundColor = PL_COLOR_CLEAR;
    lab_G.font = DEFAULT_FONT(16);
    [self.view addSubview:lab_G];
    [lab_G release];
    
    //设置手势
    UITapGestureRecognizer * recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    recognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
    //开始估算
    UIButton *btn_CostEstimate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_CostEstimate.frame = CGRectMake(45, 220, 240, 46);
    [btn_CostEstimate setImage:[UIImage imageNamed:@"btn_StarEstimate"] forState:UIControlStateNormal];
    [btn_CostEstimate setImage:[UIImage imageNamed:@"btn_StarEstimate_on"] forState:UIControlStateHighlighted];
    [btn_CostEstimate addTarget:self action:@selector(StarEstimateClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_CostEstimate];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shipCountrySelected:)
                                                 name:@"SHIPCOUNTRYSELECTED"
                                               object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (str_Country && ![NSString isEmpty:str_Country])
    {
        [btn_Area setTitle:str_Country forState:UIControlStateNormal];
        [btn_Area setTitleColor:PL_COLOR_GRAY forState:UIControlStateNormal];
        CGSize maxSize = CGSizeMake(320.0f, 30.0f);
        CGSize scSize = [str_Country sizeWithFont:DEFAULT_FONT(15) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        float leftInset = (320 - scSize.width)/2;
        [btn_Area setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -leftInset*2, 0.0f, 0.0f)];
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!str_Country && [NSString isEmpty:str_Country])
    {
        [btn_Area setTitle:LocalizedString(@"MoneyEstimateViewController_btnArea",@"点击选择运送国家") forState:UIControlStateNormal];
        [btn_Area setTitleColor:PL_COLOR_GRAY forState:UIControlStateNormal];
        NSString *defaultCountry = LocalizedString(@"MoneyEstimateViewController_defaultCountry",@"点击选择运送国家");
        CGSize maxSize = CGSizeMake(320.0f, 30.0f);
        CGSize scSize = [defaultCountry sizeWithFont:DEFAULT_FONT(15) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        float leftInset = (320 - scSize.width)/2;
        [btn_Area setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -leftInset*2, 0.0f, 0.0f)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UitextField
-(UITextField*)GetTextField:(CGRect)frame
{
    UITextField *textField = [[[UITextField alloc]initWithFrame:frame]autorelease];
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.font = DEFAULT_FONT(15);
    textField.delegate = self;
    
    UIImageView *left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    left.frame = CGRectMake(5, 2, 17, 17);
    UIView *leftView = [[UIView alloc]init];
    [leftView addSubview:left];
    textField.leftView = leftView;
    textField.leftView.frame = CGRectMake(0, 0, 17, 17);
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [left release];
    [leftView release];
    
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    textField.textColor = PL_COLOR_GRAY;
    return textField;
}

#pragma mark - UitextFieldelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 256.0 - (IS_IOS7 ? 0.0f : 64.0f));//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame =CGRectMake(0, IS_IOS7 ? 64 :0.0 , self.view.frame.size.width, self.view.frame.size.height);
     [UIView commitAnimations];
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if([string isEqualToString:@"\n"])
//    {
//        [txt_Price resignFirstResponder];
//        [txt_Weight resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if([string isEqualToString:@"\n"])
    {
        [txt_Price resignFirstResponder];
        [txt_Weight resignFirstResponder];
        return NO;
    }

    if(textField == txt_Price)
    {
       NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString : @""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle :LocalizedString(@"MoneyEstimateViewController_AlertView1_Title",@"提示")
                                                            message :LocalizedString(@"MoneyEstimateViewController_AlertView1_Msg",@"请输入数字!")
                                                            delegate:nil
                                                   cancelButtonTitle:LocalizedString(@"Common_Btn_Sure", @"确定")
                                                   otherButtonTitles:nil];
            [alert show];
            [alert release];
            return NO;
        }
    }
    
    if(textField == txt_Weight)
        {
                NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSWEIGHT] invertedSet];
                NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString : @""];
                BOOL basicTest = [string isEqualToString:filtered];
                if(!basicTest)
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle :LocalizedString(@"MoneyEstimateViewController_AlertView2_Title",@"提示")
                                                                    message :LocalizedString(@"MoneyEstimateViewController_AlertView2_Msg",@"请输入数字(不能有小数点)!")
                                                                    delegate:nil
                                                           cancelButtonTitle:LocalizedString(@"Common_Btn_Sure", @"确定")
                                                           otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    return NO;
                }
            
        }
    
    //其他的类型不需要检测，直接写入
    return YES;
}
#pragma mark - 手势
-(void)handleBackgroundTap:(UITapGestureRecognizer * )sender
{
    [txt_Price resignFirstResponder];
    [txt_Weight resignFirstResponder];
}

#pragma mark - 开始估算
-(void)StarEstimateClick
{
    
    if(![NSString isEmpty:str_Country ]&&![NSString isEmpty:txt_Price.text ]&&![NSString isEmpty:txt_Weight.text])
    {
        EstimateListViewController *vList = [[[EstimateListViewController alloc]init]autorelease];
        vList.shipCountryId = str_Country;
        vList.price = txt_Price.text;
        vList.weight = txt_Weight.text;
        [self.navigationController pushViewController:vList animated:YES];
    }
    else
    {
        [self showHUDErrorMessage:LocalizedString(@"MoneyEstimateViewController_HUDErrMsg",@"请输入完整信息")];
        
    }
    
}
#pragma mark - 选择国家
-(void)selectAreaClick
{
    SelectShipCountryViewController *shipCountry = [[[SelectShipCountryViewController alloc] init] autorelease];
    shipCountry.str_ShipCountryName = str_Country;
    CustomerNavagationBarController *shipCountryViewController = [[[CustomerNavagationBarController alloc] initWithRootViewController:shipCountry] autorelease];
    [self.navigationController presentModalViewController:shipCountryViewController animated:YES];
}

-(void)shipCountrySelected:(NSNotification*)sender
{
    NSString *string = sender.object;
    if (![NSString isEmpty:string])
    {
        str_Country = string;
    }
    
}
@end
