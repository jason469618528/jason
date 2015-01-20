//
//  ShipExpressRequest.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipExpressRequest.h"
#import "ExpressInfo.h"

@implementation ShipExpressRequest


- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"运单物流";
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
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_USERSHIPEXPRESS];
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
        
        NSArray* arr = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        NSMutableArray *expressArr = [[NSMutableArray alloc] init];
        
        for(NSDictionary * dic in arr)
        {
            
            ExpressInfo * expressInfo = [[ExpressInfo alloc] init];
            expressInfo.content = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Content"];
            expressInfo.time = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Time"];
            [expressArr addObject: expressInfo];
            [expressInfo release];
        }
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        //设置响应数据
        ((DataRepeater*)self.repeater).responseValue = expressArr;
        [expressArr release];
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
        else if ([code intValue] == 4)
        {
            errorInfo.code = 4;
            errorInfo.message = LocalizedString(@"ShipExpressRequest_ErrorInfo_code4",@"无效的物流地址");
        }
        else if ([code intValue] == 5)
        {
            errorInfo.code = 5;
            errorInfo.message = LocalizedString(@"ShipExpressRequest_ErrorInfo_code5",@"无效的物流编号");
        }
        else if ([code intValue] == 6)
        {
            errorInfo.code = 6;
            errorInfo.message = LocalizedString(@"ShipExpressRequest_ErrorInfo_code6",@"EMS无法查询");
        }
        else if ([code intValue] == 7)
        {
            errorInfo.code = 7;
            errorInfo.message = LocalizedString(@"ShipExpressRequest_ErrorInfo_code7",@"DHL无法查询");
        }
        else if ([code intValue] == 8)
        {
            errorInfo.code = 8;
            errorInfo.message = LocalizedString(@"ShipExpressRequest_ErrorInfo_code8",@"Air无法查询");
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
