//
//  ShipOrdersRequest.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipOrdersRequest.h"
#import "ShipOrder.h"


@implementation ShipOrdersRequest

- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"我的运单";
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
    NSString *url = [BASE_URL stringByAppendingString:@"Ship/GetUserShipOrders.json"];
    
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
        NSMutableArray *shipArr = [[NSMutableArray alloc] init];
        
        for(NSDictionary * dic in arr)
        {
            
            ShipOrder * shipOrders = [[ShipOrder alloc] init];
            
            shipOrders.orderId = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"OrderId"];
            shipOrders.logisticsId = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"LogisticsId"] intValue];
            shipOrders.expressUrl= [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ExpressUrl"];
            shipOrders.shipType=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipType"];
            shipOrders.status=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Status"] intValue];
            shipOrders.userScore=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"UserScore"] intValue];
            shipOrders.custodyPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"CustodyPrice"] floatValue];
            shipOrders.couponPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"CouponPrice"] floatValue];
            shipOrders.shipDeliveryName=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipDeliveryName"];
            shipOrders.packageCode=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"PackageCode"];
            
            
            shipOrders.shipPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipPrice"]floatValue];
            shipOrders.servicePrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ServicePrice"]floatValue];
            shipOrders.giftPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"GiftPrice"]floatValue];
            shipOrders.entryPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"EntryPrice"]floatValue];
            shipOrders.promotionPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"PromotionPrice"]floatValue];
            shipOrders.totalWeight=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"TotalWeight"]intValue];
            shipOrders.giftContent=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"GiftContent"];
            shipOrders.consignee=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Consignee"];
            shipOrders.telePhone=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Telephone"];
            shipOrders.postcode=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"Postcode"];
            
            shipOrders.shipArea=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipArea"];
            shipOrders.shipCountry=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipCountry"];
            shipOrders.shipAddress=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipAddress"];
            shipOrders.shipCity=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipCity"];
            shipOrders.shipRemark=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ShipRemark"];
            shipOrders.dealDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"DealDate"];
            shipOrders.confimDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"ConfimDate"];
            shipOrders.createDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"CreateDate"];
            shipOrders.totalPrice=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"TotalPrice"];
            shipOrders.hasVoted=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"HasVoted"]floatValue];
            
            
            shipOrders.canCaneOrder=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"CanCancleOrder"]floatValue];
            shipOrders.custodyPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"CustomService"]intValue];
            
            shipOrders.haveUnreadMessage = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"HaveUnreadMessage"]boolValue];
            shipOrders.haveRead = NO;
            [shipArr addObject:shipOrders];
            [shipOrders release];
        }
        
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        //设置响应数据
        ((DataRepeater*)self.repeater).responseValue = shipArr;
        [shipArr release];
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
        else if ([code intValue] == 2)
        {
            errorInfo.code = 2;
            errorInfo.message = LocalizedString(@"ShipOrdersRequest_ErrorInfo_code2",@"运单状态无效");
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
