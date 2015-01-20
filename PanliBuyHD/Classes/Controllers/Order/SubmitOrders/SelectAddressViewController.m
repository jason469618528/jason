//
//  SelectAddressViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "ShipCountry.h"
#import "AddShipAddressViewController.h"

@interface SelectAddressViewController ()

@end

@implementation SelectAddressViewController

@synthesize arr_OrderList;
@synthesize str_CountID;
@synthesize viewType;
@synthesize IsSelect;
@synthesize mArr_UserAddress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.tab_Address)
    {
        [self.tab_Address reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#e8e8e8"];
    
    //默认选中第一个
    IsSelect = 0;
    
    //右边按钮
    UIButton *btn_NewAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_NewAddress setImage:[UIImage imageNamed:@"btn_navbar_add"] forState:UIControlStateNormal];
    [btn_NewAddress setImage:[UIImage imageNamed:@"btn_navbar_add_on"] forState:UIControlStateHighlighted];
    btn_NewAddress.frame = CGRectMake(0.0f, 0.0f, 50.5f, 26.5f);
    btn_NewAddress.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -13.0f) : UIEdgeInsetsZero;
    [btn_NewAddress addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_NewAddress];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    if(!viewType)
    {
        self.navigationItem.title = LocalizedString(@"SelectAddressViewController_Nav_Title1",@"1/3填写收货地址");
    }
    else
    {
        self.navigationItem.title = LocalizedString(@"SelectAddressViewController_Nav_Title2",@"收货地址薄");
    }
    
    self.tab_Address.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:self.tab_Address];
    [self.view addSubview:self.tab_Address];
    
    UIView *view_Footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenFrame_Height - 300.0f, 7.5f)];
    view_Footer.backgroundColor = PL_COLOR_CLEAR;
    self.tab_Address.tableFooterView = view_Footer;
    
    
    
    //请求收货地址
    if(self.mArr_UserAddress == nil || self.mArr_UserAddress.count <= 0)
    {
        //请求地址通知
        [self RequestAddress];
        
    }
    
    //判断是否有国家列表
    if([GlobalObj getShipCountry].count <= 0)
    {
        //请求运送区域        
        [self RequestShipCountry];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - selectAddress Delegate
- (void)selectAddressType:(int)type btnTag:(int)selectIndex
{
    //type 1为确定 2为编辑 3为删除
    switch (type) {
        case 1:
        {
            //确定配送到此地址
            if([NSString isEmpty:str_CountID])
            {
                [self showHUDErrorMessage:LocalizedString(@"SelectAddressViewController_HUDErrMsg",@"请选择国家地区")];
                return;
            }
//            DeliveryAddress *m_Delivery = [mArr_UserAddress objectAtIndex:IsSelect];
//            SelectShipTypeViewController *selectArea = [[[SelectShipTypeViewController alloc]init]autorelease];
//            selectArea.arr_OrdersList = arr_OrderList;
//            selectArea.str_CountryID = str_CountID;
//            selectArea.DeliveryAddress = m_Delivery;
//            selectArea.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:selectArea animated:YES];
            break;
        }
        case 2:
        {
            //编辑
            AddShipAddressViewController *v_Address = [[AddShipAddressViewController alloc]init];
            DeliveryAddress *m_Delivery = [mArr_UserAddress objectAtIndex:selectIndex];
            v_Address.m_AddressObject = m_Delivery;
            v_Address.viewType = viewType;
            v_Address.isNewAdd = NO;
            v_Address.arr_OrderList = self.arr_OrderList;
            v_Address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:v_Address animated:YES];
            break;
        }
        case 3:
        {
            //删除
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LocalizedString(@"SelectAddressViewController_AlertView_Title",@"Panli提醒")
                                                                message:LocalizedString(@"SelectAddressViewController_AlertView_Msg",@"确定要删除该地址?")
                                                               delegate:self
                                                      cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消")
                                                      otherButtonTitles:LocalizedString(@"Common_Btn_Sure", @"确定"), nil];
            [alertView show];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self deleteRequest];
    }
}

#pragma mark - delete request response
- (void)deleteRequest
{
    self.view.userInteractionEnabled = NO;
    [self showHUDIndicatorMessage:LocalizedString(@"SelectAddressViewController_HUDIndMsg1",@"正在删除...")];
    req_Delete = req_Delete ? req_Delete : [[DeleteUserAddressRequest alloc] init];
    rpt_Delete = rpt_Delete ? rpt_Delete: [[DataRepeater alloc]initWithName:RQNAME_USER_DELETEDELIVERYADDRESS];
    NSMutableDictionary *parms = [[NSMutableDictionary alloc] init];
    
    DeliveryAddress *m_Delivery = [mArr_UserAddress objectAtIndex:IsSelect];
    [parms setValue:[NSString stringWithFormat:@"%d",m_Delivery.deliveryAddressId] forKey:RQ_USER_DELETEDELIVERYADDRESS_PARM_ADDRESSID];
    
    rpt_Delete.notificationName = RQNAME_USER_DELETEDELIVERYADDRESS;
    rpt_Delete.isAuth = YES;
    __weak SelectAddressViewController *selectAddressVC = self;
    rpt_Delete.compleBlock = ^(id repeater)
    {
        [selectAddressVC deleteCountryResponse:repeater];
    };
    rpt_Delete.requestModal = PullData;
    rpt_Delete.networkRequest = req_Delete;
    rpt_Delete.requestParameters = parms;
    [[DataRequestManager sharedInstance] sendRequest:rpt_Delete];
}

- (void)deleteCountryResponse:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"SelectAddressViewController_HUDSucMsg",@"删除成功")];
        [self.mArr_UserAddress removeObjectAtIndex:IsSelect];
        [self.tab_Address reloadData];
        if(self.mArr_UserAddress.count <= 0)
        {
            [self addAddress];
        }
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    self.view.userInteractionEnabled = YES;
}

#pragma mark - 转换国家地址id
-(void)Switch:(NSString*)str_Country
{
    NSString *country = [self CountryToString:str_Country];
    if([NSString isEmpty:country])
    {
        [self showHUDErrorMessage:LocalizedString(@"SelectAddressViewController_HUDErrMsg",@"请选择国家地区")];
        self.str_CountID = nil;
    }
    else
    {
        self.str_CountID = country;
    }
}
-(NSString * ) CountryToString:(NSString*)countryString
{
    
    NSArray *m_Country = [GlobalObj getShipCountry];
    NSString * str = nil;
    for(ShipCountry * pro in m_Country)
    {
        NSString * name= pro.name;
        if([name isEqualToString:countryString])
        {
            str=[NSString stringWithFormat:@"%d", pro.shipCountryId];
        }
    }
    return str;
}

#pragma mark - UitableviewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.viewType)
    {
        return  158.5f + 7.5f;
    }
    else
    {
        if(IsSelect == indexPath.row * 2 || IsSelect == indexPath.row * 2 + 1)
        {
            return 158.5f + 7.5f;
        }
        else
        {
            return 109.0f + 7.5f;
        }
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mArr_UserAddress.count/2 + mArr_UserAddress.count%2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"addressCell";
    SelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[SelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectAddressDelegate = self;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = PL_COLOR_CLEAR;
    }
    
    NSArray *array = nil;
    if (mArr_UserAddress.count >= indexPath.row*2+2)
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*2, 2)];
        array = [mArr_UserAddress objectsAtIndexes:indexSet];
    }
    else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*2, 1)];
        array = [mArr_UserAddress objectsAtIndexes:indexSet];
    }
    
    DeliveryAddress *leftDelivery = [array objectAtIndex:0];
    DeliveryAddress *rightDelivery = array.count > 1 ? [array objectAtIndex:1] : nil;
    
    
    cell.left_img_IsMain.tag = 8000+indexPath.row*2;
    cell.left_img_IsMain.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellviewTaped:)];
    [cell.left_img_IsMain addGestureRecognizer:tapRecognizer];
    
    if(IsSelect == indexPath.row * 2 || IsSelect == indexPath.row * 2 + 1)
    {
        if (IsSelect % 2 == 0) {
            [cell SendLeftDisplayData:leftDelivery isSelect:YES isIndex:(int)indexPath.row iViewType:self.viewType];
            if (rightDelivery != nil) {
                [cell resetRight];
                [cell SendRightDisplayData:rightDelivery isSelect:NO isIndex:(int)indexPath.row iViewType:self.viewType];
            }
            else
            {
                [cell hideRight];
            }
        }
        else{
            [cell SendLeftDisplayData:leftDelivery isSelect:NO isIndex:(int)indexPath.row iViewType:self.viewType];
            if (rightDelivery != nil) {
                [cell resetRight];
                [cell SendRightDisplayData:rightDelivery isSelect:YES isIndex:(int)indexPath.row iViewType:self.viewType];
            }
            else
            {
                [cell hideRight];
            }
        }
        
        if(IsSelect == 0)
        {
            [self Switch:leftDelivery.country];
        }
    }
    else
    {
        [cell SendLeftDisplayData:leftDelivery isSelect:NO isIndex:(int)indexPath.row iViewType:self.viewType];
        if (rightDelivery != nil) {
            [cell resetRight];
            [cell SendRightDisplayData:rightDelivery isSelect:NO isIndex:(int)indexPath.row iViewType:self.viewType];
        }
        else
        {
            [cell hideRight];
        }
    }
    
    if (rightDelivery != nil)
    {
        cell.right_img_IsMain.tag=8000+indexPath.row*2+1;
        cell.right_img_IsMain.userInteractionEnabled = YES;
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellviewTaped:)];
        [cell.right_img_IsMain addGestureRecognizer:tapRecognizer];
    }

    return cell;
}

//#pragma mark - UitableviewDelegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DeliveryAddress *m_Delivery = [mArr_UserAddress objectAtIndex:indexPath.row];
//    iDeliveryAddressID = m_Delivery.deliveryAddressId;
//    
//    if(IsSelect != indexPath.row)
//    {
//        [self Switch:m_Delivery.country];
//    }
//    IsSelect = indexPath.row;
//    [tableView reloadData];
//}

-(void)cellviewTaped:(UITapGestureRecognizer *)recognizer
{
    NSInteger tag=[recognizer view].tag-8000;
    DeliveryAddress *m_Delivery = (DeliveryAddress*)[mArr_UserAddress objectAtIndex:tag];
    
    if(IsSelect != tag)
    {
        [self Switch:m_Delivery.country];
    }
    IsSelect = tag;
    [self.tab_Address reloadData];
}

#pragma mark - 新增地址
-(void)addButtonClick
{
    AddShipAddressViewController *v_Address = [[AddShipAddressViewController alloc] init];
    v_Address.mArr_AddressData = mArr_UserAddress;
    v_Address.arr_OrderList = self.arr_OrderList;
    v_Address.viewType = viewType;
    v_Address.isNewAdd = YES;
    v_Address.m_AddressObject = [[DeliveryAddress alloc] init];
    [self.navigationController pushViewController:v_Address animated:YES];
}

#pragma mark - 请求地址
-(void)RequestAddress
{
    [self showHUDIndicatorMessage:LocalizedString(@"SelectAddressViewController_HUDIndMsg2",@"正在加载收货地址...")];
    req_GetAddress = req_GetAddress?req_GetAddress: [[GetDeliyAddressRequest alloc]init];
    data_GetAddress = data_GetAddress?data_GetAddress: [[DataRepeater alloc]initWithName:RQNAME_GETDELIVERYADDRESS];
    data_GetAddress.notificationName = RQNAME_GETDELIVERYADDRESS;
    data_GetAddress.isAuth = YES;
    __weak SelectAddressViewController *selectAddressVC = self;
    data_GetAddress.compleBlock = ^(id repeater)
    {
        [selectAddressVC getAddress:repeater];
    };
    data_GetAddress.requestModal = PullData;
    data_GetAddress.networkRequest = req_GetAddress;
    [[DataRequestManager sharedInstance] sendRequest:data_GetAddress];
}
-(void)getAddress:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        self.mArr_UserAddress = repeater.responseValue;
        if(self.mArr_UserAddress.count <= 0)
        {
            [self performSelector:@selector(addAddress) withObject:self afterDelay:0.5];
        }
        [self.tab_Address reloadData];
    }
    [self hideHUD];
}

- (void)addAddress
{
    AddShipAddressViewController *v_Address = [[AddShipAddressViewController alloc] init];
    v_Address.mArr_AddressData = mArr_UserAddress;
    v_Address.arr_OrderList = self.arr_OrderList;
    v_Address.viewType = viewType;
    v_Address.isNewAdd = YES;
    v_Address.m_AddressObject = [[DeliveryAddress alloc] init];
    [self.navigationController pushViewController:v_Address animated:YES];
}

#pragma mark - 请求运送区域
-(void)RequestShipCountry
{
    [self showHUDIndicatorMessage:LocalizedString(@"SelectAddressViewController_HUDIndMsg3",@"正在加载...")];
    req_ShipCountry = req_ShipCountry?req_ShipCountry:[[GetShipCountryRequest alloc] init];
    rpt_ShipCountry = rpt_ShipCountry ?rpt_ShipCountry: [[DataRepeater alloc]initWithName:RQNAME_GETCOUNTRY];
    rpt_ShipCountry.notificationName = RQNAME_GETCOUNTRY;
    rpt_ShipCountry.isAuth = YES;
    __weak SelectAddressViewController *selectAddressVC = self;
    rpt_ShipCountry.compleBlock = ^(id repeater)
    {
        [selectAddressVC GetShipCountryResponse:repeater];
    };
    rpt_ShipCountry.requestModal = PullData;
    rpt_ShipCountry.networkRequest = req_ShipCountry;
    [[DataRequestManager sharedInstance] sendRequest:rpt_ShipCountry];
}

-(void)GetShipCountryResponse:(DataRepeater *)repeater
{
    [self hideHUD];
    if(repeater.isResponseSuccess)
    {
        DLOG(@"获取运送区域成功");
    }
    else
    {
        DLOG(@"获取运送区域失败");
    }
}


@end
