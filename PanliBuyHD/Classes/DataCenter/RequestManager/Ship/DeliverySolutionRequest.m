//
//  DeliverySolutionRequest.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DeliverySolutionRequest.h"
#import "DeliverySolution.h"
#import "Delivery.h"
#import "Product.h"
#import "UserProduct.h"
@implementation DeliverySolutionRequest


- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"运送方案";
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
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_DELIVERYSOLUTION];
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
        NSArray*  arr = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        
        NSMutableArray *mArr_Sulution = [[NSMutableArray alloc]initWithCapacity:arr.count];
        
        for(NSDictionary *dic in arr)
        {
            DeliverySolution *sulution = [[DeliverySolution alloc] init];
            sulution.deliveryGourpId = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"DeliveryGourpId"];
            sulution.shipItems = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:dic propertyName:@"ShipItems"];
            sulution.isHidden = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"IsHidden"]boolValue];
            sulution.totalShipPrice = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"TotalShipPrice"] floatValue];
            sulution.totalServicePrice = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"TotalServicePrice"] floatValue];
            sulution.totalCustodyPrice = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"TotalCustodyPrice"] floatValue];
            sulution.hasForbidden = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"HasForbidden"] boolValue];
            sulution.hasOverWeight = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"HasOverWeight"] boolValue];
            sulution.orderValue = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic propertyName:@"OrderValue"] intValue];
            
            
            NSArray *arr_Delivery = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:dic propertyName:@"DeliveryInfo"];
            NSMutableArray *mArr  = [[NSMutableArray alloc] initWithCapacity:arr_Delivery.count];
            
            for (NSDictionary *dic2 in arr_Delivery)
            {
                Delivery *m_Delivery = [[Delivery alloc]init];
                m_Delivery.deliveryName = [dic2 objectForKey:@"DeliveryName"];
                NSArray *arr_ShipItems = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:dic2 propertyName:@"ShipItems"];
                NSMutableArray *marr_ShipItems = [[NSMutableArray alloc] initWithCapacity:arr_ShipItems.count];
                
                for (NSDictionary *dic1 in arr_ShipItems)
                {
                    UserProduct *mUserProduct = [[UserProduct alloc]init];
                    //基类
                    mUserProduct.productName = [dic1 objectForKey:@"ProductName"];
                    mUserProduct.productUrl = [dic1 objectForKey:@"ProductUrl"];
                    mUserProduct.freight = [[dic1 objectForKey:@"Freight"]floatValue];
                    mUserProduct.thumbnail = [dic1 objectForKey:@"Thumbnail"];
                    mUserProduct.price = [[dic1 objectForKey:@"Price"]floatValue];
                    mUserProduct.description = [dic1 objectForKey:@"Description"];
                    mUserProduct.proId = [[dic1 objectForKey:@"ID"]integerValue];
                    mUserProduct.image = [dic1 objectForKey:@"Image"];
                    //子类
                    mUserProduct.userProductId = [[dic1 objectForKey:@"UserProductId"] intValue];
                    mUserProduct.count = [[dic1 objectForKey:@"Count"]intValue];
                    mUserProduct.weight = [[dic1 objectForKey:@"Weight"]intValue];
                    mUserProduct.weightDate = [dic1 objectForKey:@"WeightDate"];
                    mUserProduct.remark = [dic1 objectForKey:@"Remark"];
                    mUserProduct.userProductStatus = [[dic1 objectForKey:@"UserProductStatus"] intValue];
                    mUserProduct.isGroup = [[dic1 objectForKey:@"IsGroup"] boolValue];
                    mUserProduct.isPiece = [[dic1 objectForKey:@"IsPiece"]boolValue];
                    mUserProduct.isForbidden = [[dic1 objectForKey:@"IsForbidden"]boolValue];
                    mUserProduct.isLightOverWeight = [[dic1 objectForKey:@"IsLightOverweight"]boolValue];
                    mUserProduct.isHeavyOverWeight = [[dic1 objectForKey:@"IsHeavyOverweight"]boolValue];
                    mUserProduct.canReturns = [[dic1 objectForKey:@"CanReturns"]boolValue];
                    mUserProduct.canDeliver = [[dic1 objectForKey:@"CanDeliver"] boolValue];
                    mUserProduct.isYellovWarning = [[dic1 objectForKey:@"IsYellowWarning"] boolValue];
                    mUserProduct.isRedWarning = [[dic1 objectForKey:@"IsRedWarning"]boolValue];
                    mUserProduct.expressUrl = [dic1 objectForKey:@"ExpressUrl"];
                    mUserProduct.expressNo = [dic1 objectForKey:@"ExpressNo"];
                    mUserProduct.status = [[dic1 objectForKey:@"Status"] intValue];
                    [marr_ShipItems addObject:mUserProduct];
                    [mUserProduct release];
                }
                
                m_Delivery.shipItems = marr_ShipItems;
                [marr_ShipItems release];
                
                m_Delivery.deliveryId = [[dic2 objectForKey:@"DeliveryId"] intValue];
                m_Delivery.deliveryDate = [dic2 objectForKey:@"DeliveryDate"];
                m_Delivery.shipSendType = [[dic2 objectForKey:@"ShipSendType"] intValue];
                
                m_Delivery.totalProductPrice = [[dic2 objectForKey:@"TotalProductPrice"]floatValue];
                m_Delivery.custodyPrice = [[dic2 objectForKey:@"CustodyPrice"]floatValue];
                m_Delivery.servicePrice = [[dic2 objectForKey:@"ServicePrice"] floatValue];
                m_Delivery.shipPrice = [[dic2 objectForKey:@"ShipPrice"]floatValue];
                m_Delivery.originalServicePrice = [[dic2 objectForKey:@"OriginalServicePrice"]floatValue];
                m_Delivery.originalShipPrice = [[dic2 objectForKey:@"OriginalShipPrice"]floatValue];
                m_Delivery.enterPrice = [[dic2 objectForKey:@"EnterPrice"] floatValue];
                
                m_Delivery.weight = [[dic2 objectForKey:@"Weight"]floatValue];
                m_Delivery.isVWeight = [[dic2 objectForKey:@"IsVWeight"]boolValue];
                m_Delivery.isLightOverweight = [[dic2 objectForKey:@"IsLightOverweight"] boolValue];
                m_Delivery.isHeavyOverweight = [[dic2 objectForKey:@"IsHeavyOverweight"]boolValue];
                m_Delivery.isForbidden = [[dic2 objectForKey:@"IsForbidden"] boolValue];
                [mArr addObject:m_Delivery];
                [m_Delivery release];
            }
            
            sulution.deliveryInfo = mArr;
            [mArr_Sulution addObject:sulution];
            [sulution release];
            [mArr release];
            
        }
        
        
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        
        //设置响应数据
        ((DataRepeater*)self.repeater).responseValue = mArr_Sulution;
        [mArr_Sulution release];
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
        else if ([code intValue] == 12)
        {
            errorInfo.code = 12;
            errorInfo.message = LocalizedString(@"DeliverySolutionRequest_ErrorInfo_code12",@"获取运送方案失败");
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
