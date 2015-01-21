//
//  ShipDetailRequest.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipDetailRequest.h"
#import "ShipDetail.h"

@implementation ShipDetailRequest


- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"运单详情";
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
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_USERSHIPDETAIL];
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
        
        NSDictionary *dic_Ship = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        
        ShipDetail * shipDetail = [[ShipDetail alloc] init];
        
        
        shipDetail.productsWeight = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ProductsWeight"]intValue];
        shipDetail.totalProductPrice= [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"TotalProductPrice"] floatValue] ;
        
        shipDetail.orderId = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"OrderId"];
        shipDetail.logisticsId = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"LogisticsId"] intValue];
        shipDetail.expressUrl= [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ExpressUrl"];
        shipDetail.shipType=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipType"];
        shipDetail.status=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"Status"] intValue];
        shipDetail.userScore=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"UserScore"] intValue];
        shipDetail.custodyPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"CustodyPrice"] floatValue];
        shipDetail.couponPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"CouponPrice"] floatValue];
        shipDetail.shipDeliveryName=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipDeliveryName"];
        shipDetail.packageCode=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"PackageCode"];
        
        
        shipDetail.shipPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipPrice"]floatValue];
        shipDetail.servicePrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ServicePrice"]floatValue];
        shipDetail.giftPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"GiftPrice"]floatValue];
        shipDetail.entryPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"EntryPrice"]floatValue];
        shipDetail.promotionPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"PromotionPrice"]floatValue];
        shipDetail.totalWeight=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"TotalWeight"]intValue];
        shipDetail.giftContent=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"GiftContent"];
        shipDetail.consignee=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"Consignee"];
        shipDetail.telePhone=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"Telephone"];
        shipDetail.postcode=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"Postcode"];
        
        shipDetail.shipArea=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipArea"];
        shipDetail.shipCountry=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipCountry"];
        shipDetail.shipAddress=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipAddress"];
        shipDetail.shipCity=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipCity"];
        shipDetail.shipRemark=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ShipRemark"];
        shipDetail.dealDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"DealDate"];
        shipDetail.confimDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"ConfimDate"];
        shipDetail.createDate=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"CreateDate"];
        shipDetail.totalPrice=[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"TotalPrice"];
        shipDetail.hasVoted=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"HasVoted"]floatValue];
        
        shipDetail.canCaneOrder=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"CanCancleOrder"]floatValue];
        shipDetail.custodyPrice=[[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:dic_Ship propertyName:@"CustomService"]intValue];
        
        
        NSArray *tempArr = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:dic_Ship propertyName:@"UserProducts"];
        
        NSMutableArray *mArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in tempArr)
        {
            UserProduct *mUserProduct = [[UserProduct alloc] init];
            //基类
            mUserProduct.productName = [dic objectForKey:@"ProductName"];
            mUserProduct.productUrl = [dic objectForKey:@"ProductUrl"];
            mUserProduct.freight = [[dic objectForKey:@"Freight"]floatValue];
            mUserProduct.thumbnail = [dic objectForKey:@"Thumbnail"];
            mUserProduct.price = [[dic objectForKey:@"Price"]floatValue];
            mUserProduct.description = [dic objectForKey:@"Description"];
            mUserProduct.image = [dic objectForKey:@"Image"];
            //子类
            mUserProduct.userProductId = [[dic objectForKey:@"UserProductId"] intValue];
            mUserProduct.count = [[dic objectForKey:@"Count"]intValue];
            mUserProduct.weight = [[dic objectForKey:@"Weight"]intValue];
            mUserProduct.weightDate = [dic objectForKey:@"WeightDate"];
            mUserProduct.remark = [dic objectForKey:@"Remark"];
            mUserProduct.userProductStatus = [[dic objectForKey:@"UserProductStatus"] intValue];
            mUserProduct.isGroup = [[dic objectForKey:@"IsGroup"] boolValue];
            mUserProduct.isPiece = [[dic objectForKey:@"IsPiece"]boolValue];
            mUserProduct.isForbidden = [[dic objectForKey:@"IsForbidden"]boolValue];
            mUserProduct.isLightOverWeight = [[dic objectForKey:@"IsLightOverweight"]boolValue];
            mUserProduct.isHeavyOverWeight = [[dic objectForKey:@"IsHeavyOverweight"]boolValue];
            mUserProduct.canReturns = [[dic objectForKey:@"CanReturns"]boolValue];
            mUserProduct.canDeliver = [[dic objectForKey:@"CanDeliver"] boolValue];
            mUserProduct.isYellovWarning = [[dic objectForKey:@"IsYellowWarning"] boolValue];
            mUserProduct.isRedWarning = [[dic objectForKey:@"IsRedWarning"]boolValue];
            mUserProduct.expressUrl = [dic objectForKey:@"ExpressUrl"];
            mUserProduct.expressNo = [dic objectForKey:@"ExpressNo"];
            mUserProduct.skuRemark = [NSString isEmpty:[dic objectForKey:@"SkuRemark"]] ? @"": [dic objectForKey:@"SkuRemark"];;
            [mArr addObject:mUserProduct];
            [mUserProduct release];
        }
        
        shipDetail.userProducts = mArr;
        [mArr release];
        
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        //设置响应数据
        ((DataRepeater*)self.repeater).responseValue = shipDetail;
        [shipDetail release];
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
        else if ([code intValue] == 3)
        {
            errorInfo.code = 3;
            errorInfo.message = LocalizedString(@"ShipDetailRequest_ErrorInfo_code3",@"无效的运单编号");
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
