//
//  PushNotificationViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "PushNotificationViewController.h"
#import "GetUserConfigRequest.h"
#import "DataRepeater.h"
#import "UpdataUserConfigRequest.h"
#import "UserConfig.h"
#import "NotificationTag.h"
#import "PushNotificationCell.h"

@interface PushNotificationViewController ()
{
    NSMutableArray *arr_notifiSetting;
    
    //获取配置信息
    GetUserConfigRequest *req_GetUserConfig;
    DataRepeater *rpt_GetUserConfig;
    
    //更新配置信息
    UpdataUserConfigRequest *req_UpdaUserConfig;
    DataRepeater *rpt_UpdaUserConfig;
    
    UserConfig *mUserConfig;

}
@end

@implementation PushNotificationViewController

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
    [super viewDidLoad];
    
    self.navigationItem.title = LocalizedString(@"PushNotificationViewController_Nav_Title",@"消息设置");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    
    //读取设置数据源
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PushNotificationSetting" ofType:@"plist"];
    arr_notifiSetting = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    for (int i = 0; i < arr_notifiSetting.count; i++)
    {
        //将不可变字典替换成可变字典
        NSDictionary *dic = [arr_notifiSetting objectAtIndex:i];
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [arr_notifiSetting setObject:mutableDic atIndexedSubscript:i];
    }
    
//    //获取
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getUserConfigResponse:)
//                                                 name:RQNAME_USERCONFIG
//                                               object:nil];
//    //更新
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(updateUserConfigResponse:)
//                                                 name:RQNAME_UPDATEUSERCONFIG
//                                               object:nil];
    [self getUserConfigRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request and response
-(void)getUserConfigRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"PushNotificationViewController_HUDIndMsg1",@"正在加载...")];
    req_GetUserConfig = req_GetUserConfig ? req_GetUserConfig : [[GetUserConfigRequest alloc]init];
    
    rpt_GetUserConfig = rpt_GetUserConfig ? rpt_GetUserConfig : [[DataRepeater alloc]initWithName:RQNAME_USERCONFIG];
    rpt_GetUserConfig.notificationName = RQNAME_USERCONFIG;
    rpt_GetUserConfig.requestModal = PullData;
    rpt_GetUserConfig.networkRequest = req_GetUserConfig;
    rpt_GetUserConfig.isAuth = YES;
    __weak __typeof(self) weakSelf= self;
    rpt_GetUserConfig.compleBlock = ^(id repeater){
        [weakSelf getUserConfigResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_GetUserConfig];
}

-(void)getUserConfigResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        mUserConfig = repeater.responseValue;
        for (int i = 0; i < mUserConfig.notifications.count; i++)
        {
            NotificationTag *mNotificationTag = [mUserConfig.notifications objectAtIndex:i];
            
            int type = mNotificationTag.type;
            BOOL enable = mNotificationTag.enable;
            
            if(type == ArrivedPanli)
            {
                NSMutableDictionary *dic = [arr_notifiSetting objectAtIndex:0];
                [dic setValue:[NSNumber numberWithBool:enable] forKey:@"isReceive"];
            }
            else if(type == ShipDeliveryed)
            {
                NSMutableDictionary *dic = [arr_notifiSetting objectAtIndex:1];
                [dic setValue:[NSNumber numberWithBool:enable] forKey:@"isReceive"];
            }
            else if(type == TuanMessage)
            {
                NSMutableDictionary *dic = [arr_notifiSetting objectAtIndex:2];
                [dic setValue:[NSNumber numberWithBool:enable] forKey:@"isReceive"];
            }
            else if(type == CustomerMessage)
            {
                NSMutableDictionary *dic = [arr_notifiSetting objectAtIndex:3];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isReceive"];
            }
            else if(type == NoDisturb)
            {
                NSMutableDictionary *dic = [arr_notifiSetting objectAtIndex:4];
                [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isReceive"];
            }
        }
        
        //保存到本地plist
        NSString *plistPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"PushNoificationSetting.plist"];
        [arr_notifiSetting writeToFile:plistPath atomically:YES];
        
        [self.tab_pushNotification reloadData];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
        
    }
}

-(void)updateUserConfigRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"PushNotificationViewController_HUDIndMsg2",@"正在提交...")];
    
    req_UpdaUserConfig = req_UpdaUserConfig ? req_UpdaUserConfig : [[UpdataUserConfigRequest alloc]init];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dic in arr_notifiSetting)
    {
        NSMutableDictionary *tempDic = [NSMutableDictionary new];
        NSString *tag = [dic objectForKey:@"id"];
        BOOL isReceive = [[dic valueForKey:@"isReceive"] boolValue];
        switch ([tag intValue])
        {
            case 0:
            {
                [tempDic setValue:@"ArrivedPanli" forKey:@"Type"];
                [tempDic setValue:@"2" forKey:@"Enable"];
                [tempDic setValue:(isReceive ? @"true" : @"false") forKey:@"Enable"];
                break;
            }
            case 1:
            {
                [tempDic setValue:@"ShipDeliveryed" forKey:@"Type"];
                [tempDic setValue:@"3" forKey:@"Enable"];
                [tempDic setValue:(isReceive ? @"true" : @"false") forKey:@"Enable"];
                break;
            }
            case 2:
            {
                [tempDic setValue:@"TuanMessage" forKey:@"Type"];
                [tempDic setValue:@"5" forKey:@"Enable"];
                [tempDic setValue:(isReceive ? @"true" : @"false") forKey:@"Enable"];
                
                break;
            }
            case 3:
            {
                //2014-8-11 modify by liubin(去掉拒收客户短信)
                [tempDic setValue:@"CustomerMessage" forKey:@"Type"];
                [tempDic setValue:@"4" forKey:@"Enable"];
                [tempDic setValue:@"true" forKey:@"Enable"];
                break;
            }
            case 4:
            {
                //2014-8-11 modify by liubin(去掉免打扰)
                [tempDic setValue:@"NoDisturb" forKey:@"Type"];
                [tempDic setValue:@"6" forKey:@"Enable"];
                [tempDic setValue:@"false" forKey:@"Enable"];
                break;
            }
                
            default:
                break;
        }
        [arr addObject:tempDic];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mUserConfig.dateCreatedUtc forKey:@"DateCreatedUtc"];
    [dic setValue:mUserConfig.lastUpdateDateUtc forKey:@"LastUpdateDateUtc"];
    
    NSString *localBeginString = mUserConfig.noDisturbBeginHour >= 10 ? [NSString stringWithFormat:@"%d:00",mUserConfig.noDisturbBeginHour] : [NSString stringWithFormat:@"%0d:00",mUserConfig.noDisturbBeginHour];
    NSString *localEndString = mUserConfig.noDisturbEndHour >= 10 ? [NSString stringWithFormat:@"%d:00",mUserConfig.noDisturbEndHour] : [NSString stringWithFormat:@"%0d:00",mUserConfig.noDisturbEndHour];
    
    //2014-8-11 modify by liubin(去掉免打扰)
    localBeginString = @"00:00";
    localEndString = @"24:00";
    NSString *utcBeginString = [PanliHelper getUTCFormateLocalDate:localBeginString formatterString:@"HH:mm"];
    NSString *utcEndString = [PanliHelper getUTCFormateLocalDate:localEndString formatterString:@"HH:mm"];
    
    [dic setValue:[NSString stringWithFormat:@"%d",[utcBeginString intValue]] forKey:@"NoDisturbBeginHour"];
    [dic setValue:[NSString stringWithFormat:@"%d",[utcEndString intValue]] forKey:@"NoDisturbEndHour"];
    [dic setValue:arr forKey:@"Notifications"];
    
    //拼接json
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *string = [jsonWriter stringWithObject:dic];
    
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    
    [parms setValue:string forKey:RQ_UPDATEUSERCONFIG_PARAM_USERCONFIG];
    rpt_UpdaUserConfig = rpt_UpdaUserConfig ? rpt_UpdaUserConfig : [[DataRepeater alloc]initWithName:RQNAME_UPDATEUSERCONFIG];
    rpt_UpdaUserConfig.notificationName = RQNAME_UPDATEUSERCONFIG;
    rpt_UpdaUserConfig.requestModal = PushData;
    rpt_UpdaUserConfig.networkRequest = req_UpdaUserConfig;
    rpt_UpdaUserConfig.requestParameters = parms;
    rpt_UpdaUserConfig.isAuth = YES;
    
    __weak __typeof(self) weakSelf= self;
    rpt_GetUserConfig.compleBlock = ^(id repeater){
        [weakSelf updateUserConfigResponse:repeater];
    };
    
    [[DataRequestManager sharedInstance] sendRequest:rpt_GetUserConfig];
}


-(void)updateUserConfigResponse:(NSNotification*)sender
{
    DataRepeater *repeater = sender.object;
    if(repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"PushNotificationViewController_HUDSucMsg",@"修改成功")];
        //保存到本地plist
        NSString *plistPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"PushNoificationSetting.plist"];
        [arr_notifiSetting writeToFile:plistPath atomically:YES];
    }
    else
    {
        //重新读取plist
        SAFE_RELEASE(arr_notifiSetting);
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PushNotificationSetting" ofType:@"plist"];
        arr_notifiSetting = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        for (int i = 0; i < arr_notifiSetting.count; i++)
        {
            //将不可变字典替换成可变字典
            NSDictionary *dic = [arr_notifiSetting objectAtIndex:i];
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [arr_notifiSetting setObject:mutableDic atIndexedSubscript:i];
        }
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}

#pragma mark - tableview datasource and delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_notifiSetting.count-2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pushNotificationCell"];
    
    if(cell == nil)
    {
        cell = (PushNotificationCell *)[[[NSBundle mainBundle] loadNibNamed:@"PushNotificationCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableDictionary *pushData = [arr_notifiSetting objectAtIndex:indexPath.section];
    [cell setDataWithDictionary:pushData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 15.0f)];
    view.backgroundColor = PL_COLOR_CLEAR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == arr_notifiSetting.count-3)
    {
        return 50.0f;
    }
    else
    {
        return 0.01f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == arr_notifiSetting.count-3)
    {
        //读取开始时间和结束时间
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300.0f, 50.0f)];
        UILabel *lab_remark = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, MainScreenFrame_Height - 320.0f, 40.0f)];
        lab_remark.backgroundColor = PL_COLOR_CLEAR;
        lab_remark.numberOfLines = 2;
        lab_remark.textColor = [PanliHelper colorWithHexString:@"#949494"];
        lab_remark.font = DEFAULT_FONT(13);
        lab_remark.text = [GlobalObj isNotification] ? @"" : LocalizedString(@"PushNotificationViewController_labRemark",@"现在无法及时提醒哦,可在ios的\"设置\"-\"通知中心\"找到\"Panli代购\",开启后即可重新接收通知");
        [footerView addSubview:lab_remark];
        return footerView;
    }
    else
    {
        return nil;
    }
}

- (void)savePushConfig
{
    [self updateUserConfigRequest];
}

@end
