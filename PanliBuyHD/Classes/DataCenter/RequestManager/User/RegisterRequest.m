//
//  RegisterRequest.m
//  PanliApp
//
//  Created by jason on 13-7-17.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"用户注册";
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
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_REGISTER];
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    //设置请求头
    [self setHeader];
    
    //设置请求参数
    for (NSString *key in repeater.requestParameters.allKeys)
    {
        [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:key] forKey:key];
    }
    
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
        NSDictionary* dic_result = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        NSString *emailSite = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_result propertyName:@"emailSite"];
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        ((DataRepeater*)self.repeater).responseValue = emailSite;
        //设置响应数据
    }
    else
    {
        ((DataRepeater*)self.repeater).isResponseSuccess = NO;
        ((DataRepeater*)self.repeater).errorInfo = errorInfo;
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
        else if ([code intValue] == 21)
        {
            errorInfo.code = 21;
            errorInfo.message = LocalizedString(@"RegisterRequest_ErrorInfo_code21",@"无效的邮箱地址");
        }
        else if ([code intValue] == 22)
        {
            errorInfo.code = 22;
            errorInfo.message = LocalizedString(@"RegisterRequest_ErrorInfo_code22",@"邮箱已存在");
        }
        else if ([code intValue] == 23)
        {
            errorInfo.code = 23;
            errorInfo.message = LocalizedString(@"RegisterRequest_ErrorInfo_code23",@"昵称只能是2-8个汉字或4-16个字符");
        }
        else if ([code intValue] == 24)
        {
            errorInfo.code = 24;
            errorInfo.message = LocalizedString(@"RegisterRequest_ErrorInfo_code24",@"用户名已存在");
        }
        else if ([code intValue] == 26)
        {
            errorInfo.code = 26;
            errorInfo.message = LocalizedString(@"RegisterRequest_ErrorInfo_code26",@"激活邮件发送失败,请再次注册或联系客服");
        }
        else if ([code intValue] == 99)
        {
            errorInfo.code = 99;
            errorInfo.message = LocalizedString(@"Common_ErrorInfo_Long99",@"未知错误，请重试");
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
