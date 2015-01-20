//
//  BaseHttpRequest.m
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "InternationalControl.h"


@implementation BaseHttpRequest

@synthesize request = _request;
@synthesize repeater = _repteater;
@synthesize timeout = _timeout;
@synthesize threadId = _threadId;

- (id)init
{
    self = [super init];
    if (self) {
        tag = @"网络请求基类";
        _timeout = TIMEOUT_S;
    }
    return self;
}

/**
 * 功能描述: 发送http请求
 * 输入参数: _render 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)sendRequest:(DataRepeater *)_repeater
{
    self.repeater = _repeater;
    @try
    {
        //子类实现
        [self request:_repeater];
    }
    @catch (NSException *exception)
    {
        DLOG(@"[Exception]%@",exception);
        if ([self.repeater isKindOfClass:[DataRepeater class]])
        {
            ((DataRepeater*)self.repeater).isResponseSuccess = NO;
            ((DataRepeater*)self.repeater).errorInfo = [ErrorInfo initWithCode:-1 message:LocalizedString(@"BaseHttpRequest_ErrorInfo_codeMinus1",@"参数解析错误")];
            [[DataRequestManager sharedInstance] responseRequest:self.repeater];
        }
    }
    @finally
    {
        
    }
    
}


- (ErrorInfo *)checkResponseError:(NSDictionary*)jsonValue
{
    ErrorInfo *errorInfo = nil;
    //解析错误
    if (jsonValue == nil)
    {
        errorInfo = [[ErrorInfo alloc] init];
        errorInfo.code = -1;
        errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_codeMinus2",@"请求服务器失败,请重试");
        return errorInfo;
    }
    else
    {
        //解析成功
        NSDictionary* dic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_STATUS];
        /**
         *状态码
         *（9位的正整数，有高位到地位，1-2：应用程序编号，3-4：服务器响应状态，5-7：API编号，8-9：接口响应状态）
         */
        NSString *code = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:RP_PARAM_STATUS_CODE];
        //截取3-4位服务器响应状态码
        NSRange range = NSMakeRange(2, 2);
        code = [code substringWithRange:range];
        errorInfo = [[ErrorInfo alloc] init];
        //用户未激活
        if ([code intValue] == USER_UNACTIVE)
        {
            errorInfo.code = USER_UNACTIVE;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_USER_UNACTIVE",@"账号未激活,请立即激活.");
        }
        //客户端版本太低
        else if ([code intValue] == VERSION_LOW)
        {
            errorInfo.code = VERSION_LOW;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_VERSION_LOW",@"客户端版本需要更新,是否立即更新?");
        }
        //客户端版本错误
        else if ([code intValue] == VERSION_ERROR)
        {
            errorInfo.code = VERSION_ERROR;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_VERSION_ERROR",@"客户端与当前服务器不匹配,请立即更新.");
        }
        //配置文件版本过低
        else if ([code intValue] == CONFIG_LOW)
        {
            errorInfo.code = CONFIG_LOW;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_CONFIG_LOW",@"客户端配置文件需要更新,是否立即更新.");
        }
        else if ([code intValue] == UNAUTHORIZED)
        {
            errorInfo.code = UNAUTHORIZED;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_UNAUTHORIZED",@"未经过授权认证,请重新登录.");
        }
        else if ([code intValue] == SERVER_ERROR)
        {
            errorInfo.code = SERVER_ERROR;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_SERVER_ERROR",@"服务器响应错误,请重试.");
        }
        else if ([code intValue] == SERVER_SUCCESS)
        {
            errorInfo.code = SERVER_SUCCESS;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_SERVER_SUCCESS",@"服务器响应正常");
        }
        else
        {
            errorInfo.code = CODE_ERROR;
            errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_CODE_ERROR",@"服务器状态码解析错误，请重试。");
        }
        return errorInfo;
    }
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    @try
    {
        //子类实现
        [self receive:request];
    }
    @catch (NSException *exception)
    {
        DLOG(@"[Exception]%@",exception);
        if ([self.repeater isKindOfClass:[DataRepeater class]])
        {
            ((DataRepeater*)self.repeater).isResponseSuccess = NO;
            ((DataRepeater*)self.repeater).errorInfo = [ErrorInfo initWithCode:-1 message:LocalizedString(@"BaseHttpRequest_ErrorInfo_codeMinus3",@"返回值解析错误")];
            [[DataRequestManager sharedInstance] responseRequest:self.repeater];
        }
    }
    @finally
    {
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError* error = request.error;
    ErrorInfo* errorInfo = [[ErrorInfo alloc]init];
    if (error.code == 1)
    {
        errorInfo.code = NETWORK_ERROR;
        errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_NETWORK_ERROR",@"服务器无法连接或网络异常");
    }
    else if (error.code == 2)
    {
        errorInfo.code = TIMEOUT_ERROR;
        errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_TIMEOUT_ERROR",@"请求超时，请重试");
    }
    else
    {
        errorInfo.code = SERVER_EXCEPTION;
        errorInfo.message = LocalizedString(@"BaseHttpRequest_ErrorInfo_SERVER_EXCEPTION",@"服务器响应错误，请重试");
    }
    
    if ([self.repeater isKindOfClass:[DataRepeater class]]) {
        ((DataRepeater*)self.repeater).isResponseSuccess = NO;
        ((DataRepeater*)self.repeater).errorInfo = errorInfo;
        [[DataRequestManager sharedInstance] responseRequest:self.repeater];
    }
}

- (void)request:(DataRepeater *)repeater
{
    //子类实现
}

- (void)receive:(ASIHTTPRequest *)request
{
    //子类实现
}

- (void)setHeader
{
    //设置请求头
    [self.request addRequestHeader:RQ_PUBLIC_PARAM_VERSION value:CLIENT_VERSION];
    
    if ([[InternationalControl userLanguage] isEqualToString:@"zh-Hans"])
    {
        [self.request addRequestHeader:RQ_PUBLIC_PARAM_LANGUAGE value:@"Simple"];
    }
    else if([[InternationalControl userLanguage] isEqualToString:@"zh-Hant"])
    {
        [self.request addRequestHeader:RQ_PUBLIC_PARAM_LANGUAGE value:@"Traditional"];
    }
    else
    {
        [self.request addRequestHeader:RQ_PUBLIC_PARAM_LANGUAGE value:@"Simple"];
    }
    if (self.repeater.isAuth)
    {
        //设置请求头
        [self.request addRequestHeader:RQ_PUBLIC_PARAM_USERBILL value:[GlobalObj getCredential]];
    }
}

-(void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
