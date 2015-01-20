//
//  LoginRequest.m
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "LoginRequest.h"
#import "UserInfo.h"
#import "BaseHttpRequest.h"
#import "NSUserDefaults+Helper.h"

@implementation LoginRequest

- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"登录";
    }
    return self;
}

/**
 * 功能描述: 数据发送
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)request:(DataRepeater *)repeater
{
    //拼接URL
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_USERLOGIN];
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    NSString * userName = [repeater.requestParameters valueForKey:RQ_LOGIN_PARAM_USERNAME];
    //设置请求头
    [self setHeader];
    //设置POST参数
    [((ASIFormDataRequest*)self.request) setPostValue:userName forKey:RQ_LOGIN_PARAM_USERNAME];
    [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:RQ_LOGIN_PARAM_PASSWORD] forKey:RQ_LOGIN_PARAM_PASSWORD];
    [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:RQ_LOGIN_PARAM_DEVICETOKEN] forKey:RQ_LOGIN_PARAM_DEVICETOKEN];
    [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:RQ_LOGIN_PARAM_LONGITUDE] forKey:RQ_LOGIN_PARAM_LONGITUDE];
    [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:RQ_LOGIN_PARAM_LATITUDE] forKey:RQ_LOGIN_PARAM_LATITUDE];
    
    
    [self.request setTimeOutSeconds:self.timeout];
    [self.request setDelegate:self];
    //跳过SSL
    [self.request setValidatesSecureCertificate:NO];
    //发送异步请求
    [self.request startAsynchronous];
}

/**
 * 功能描述: 数据接收
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)receive:(ASIHTTPRequest *)request
{
    //解析Json
    NSDictionary *jsonValue = [request.responseString JSONValue];
    
    //检验状态码
    ErrorInfo* errorInfo = [self checkResponseError:jsonValue];
    self.repeater.errorInfo = errorInfo;
    if (errorInfo.code == API_SUCCESS)
    {
        //接口响应成功
        NSDictionary* dic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        
        UserInfo *user = [[UserInfo alloc] init];
        user.userId = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"UserId"];
        user.nickName = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"NickName"];
        user.balance = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Balance"] floatValue];
        user.integration = [[PanliHelper getValue:Q_TYPE_INT_STRING inJsonDictionary:dic propertyName:@"Integration"] intValue];
        user.userGroup = [[PanliHelper getValue:Q_TYPE_INT_STRING inJsonDictionary:dic propertyName:@"UserGroup"] intValue];
        user.avatarUrl = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"AvatarUrl"];
        user.isApproved = [[PanliHelper getValue:Q_TYPE_BOOLEAN inJsonDictionary:dic propertyName:@"IsApproved"] boolValue];
        user.emailSite = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"EmailSite"];
        
        //保存用户信息
        [GlobalObj setUserInfo:user];
        
        //保存票据
        NSDictionary *headerDic = request.responseHeaders;
        NSString *credential = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:headerDic propertyName:@"Credential"];
        [NSUserDefaults saveObject:credential forKey:USER_CREDENTIAL];
        
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        ((DataRepeater*)self.repeater).responseValue = nil;
    }
    else
    {
        ((DataRepeater*)self.repeater).isResponseSuccess = NO;
        ((DataRepeater*)self.repeater).errorInfo = errorInfo;
        
        //用户未激活
        if (errorInfo.code == USER_UNACTIVE)
        {
            NSDictionary* dic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
            NSString *emailSite = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"EmailSite"];
            ((DataRepeater*)self.repeater).responseValue = emailSite;
        }
    }
    [[DataRequestManager sharedInstance] responseRequest:self.repeater];
}



- (ErrorInfo *)checkResponseError:(NSDictionary*)jsonValue
{
    //调用父类的方法检查服务器状态码，服务器响应正常再检查接口响应编码
    ErrorInfo *errorInfo = [super checkResponseError:jsonValue];
    if (errorInfo.code == SERVER_SUCCESS)
    {
        //解析成功
        NSDictionary* dic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_STATUS];
        //状态码（9位的正整数，有高位到地位，1-2：应用程序编号，3-4：服务器响应状态，5-7：API编号，8-9：接口响应状态）
        NSString *code = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:RP_PARAM_STATUS_CODE];
        //截取8-9位服务器响应状态码
        NSRange range = NSMakeRange(7, 2);
        code = [code substringWithRange:range];
        //接口响应成功
        if ([code intValue] == API_SUCCESS)
        {
            errorInfo.code = API_SUCCESS;
            errorInfo.message = LocalizedString(@"Common_ErrorInfo_API_SUCCESS",@"成功");
        }
        else if([code intValue] == 2)
        {
            errorInfo.code = 2;
            errorInfo.message = LocalizedString(@"LoginRequest_ErrorInfo_code2",@"用户名不能为空");
        }
        else if([code intValue] == 3)
        {
            errorInfo.code = 3;
            errorInfo.message = LocalizedString(@"LoginRequest_ErrorInfo_code3",@"密码不能为空");
        }
        else if([code intValue] == 5)
        {
            errorInfo.code = 5;
            errorInfo.message = LocalizedString(@"LoginRequest_ErrorInfo_code5",@"用户名或密码错误");
        }
        else if([code intValue] == USER_UNACTIVE)
        {
            errorInfo.code = USER_UNACTIVE;
            errorInfo.message = LocalizedString(@"LoginRequest_ErrorInfo_USER_UNACTIVE",@"账号未激活");
        }
        else
        {
            errorInfo.code = CODE_ERROR;
            errorInfo.message = LocalizedString(@"Common_ErrorInfo_CODE_ERROR",@"接口状态码解析错误");
        }
        return errorInfo;
    }
    else
    {
        return errorInfo;
    }
}

@end
