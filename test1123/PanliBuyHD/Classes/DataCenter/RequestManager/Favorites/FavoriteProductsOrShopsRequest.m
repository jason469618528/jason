//
//  FavoriteProductsOrShopsRequest.m
//  PanliBuyHD
//
//  Created by guo on 14-10-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "FavoriteProductsOrShopsRequest.h"
#import "FavoriteProducts.h"
#import "FavoriteShops.h"

@implementation FavoriteProductsOrShopsRequest
- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"获取商品或店铺";
    }
    
    return self;
}

/**
 *  功能描述：发送数据请求
 *  输入参数：repeater 数据转发器对象
 *  输出参数：N/A
 *  返回值 ： N/A
 */
- (void)request:(DataRepeater *)repeater
{
    type = [repeater.requestParameters objectForKey:@"type"];
    
    //网络请求URL
    NSString *urlStr = [BASE_URL stringByAppendingString:@"Favorites/FavoriteOrShopList.json"];
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    //设置请求头
    [self.request addRequestHeader:RQ_PUBLIC_PARAM_VERSION value:CLIENT_VERSION];
    [self.request addRequestHeader:RQ_PUBLIC_PARAM_USERBILL value:[GlobalObj getCredential]];
    
    //设置请求参数
    for (NSString *key in repeater.requestParameters.allKeys)
    {
        [((ASIFormDataRequest*)self.request) setPostValue:[repeater.requestParameters valueForKey:key] forKey:key];
    }
    [self.request setTimeOutSeconds:self.timeout];
    [self.request setDelegate:self];
    //跳过SSL
    self.request.validatesSecureCertificate = NO;
    //开始异步请求
    [self.request startAsynchronous];
    
}

/**
 *  功能描述：数据接收
 *  输入参数：request 网络请求对象
 *  输出参数：N/A
 *  返回值 ：N/A
 */
- (void)receive:(ASIHTTPRequest *)request
{
    //解析 JSON
    NSDictionary *jsonValue = [request.responseString JSONValue];
    
    //检验状态码
    ErrorInfo *errorInfo = [self checkResponseError:jsonValue];
    self.repeater.errorInfo = errorInfo;
    if (errorInfo.code == API_SUCCESS)
    {
        if ([type isEqualToString:@"F"])
        {
            //接口响应成功
            NSDictionary *dic = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
            NSMutableArray *productsArray = [[NSMutableArray alloc] init];
            for (NSDictionary * productsDic in dic)
            {
                FavoriteProducts *mProducts = [[FavoriteProducts alloc] init];
                mProducts.price = [[productsDic objectForKey:@"Price"] floatValue];
                mProducts.productName = [productsDic objectForKey:@"ProductName"];
                mProducts.productUrl = [productsDic objectForKey:@"ProductUrl"];
                mProducts.shopName = [productsDic objectForKey:@"ShopName"];
                mProducts.siteName = [productsDic objectForKey:@"SiteName"];
                mProducts.thumbnail = [productsDic objectForKey:@"Thumbnail"];
                mProducts.favoriteID = [[productsDic objectForKey:@"FavoriteID"] intValue];
                mProducts.isFavorite = YES;
                [productsArray addObject:mProducts];
            }
            
            ((DataRepeater *)self.repeater).isResponseSuccess = YES;
            ((DataRepeater *)self.repeater).responseValue = productsArray;
            
            NSLog(@"解析 收藏的商品 数据结束了");
            [[DataRequestManager sharedInstance] responseRequest:self.repeater];
            
        }
        else if ([type isEqualToString:@"S"])
        {
            //接口响应成功
            NSDictionary *dic = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
            NSMutableArray *shopsArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *shopDic in dic)
            {
                FavoriteShops *mShops = [[FavoriteShops alloc] init];
                mShops.shopUrl = [shopDic objectForKey:@"ShopUrl"];
                mShops.shopName = [shopDic objectForKey:@"ShopName"];
                mShops.keeperName = [shopDic objectForKey:@"Keeper"];
                mShops.credit = [[shopDic objectForKey:@"Credit"] intValue];
                mShops.logo = [shopDic objectForKey:@"Logo"];
                mShops.positiveRatio = [[shopDic objectForKey:@"PositiveRatio"] floatValue];
                mShops.instruction = [shopDic objectForKey:@"Instruction"];
                mShops.favoriteID = [[shopDic objectForKey:@"FavoriteID"] intValue];
                mShops.siteName = [shopDic objectForKey:@"SiteName"];
                mShops.isFavorite = YES;
                [shopsArray addObject:mShops];
            }
            ((DataRepeater *)self.repeater).isResponseSuccess = YES;
            ((DataRepeater *)self.repeater).responseValue = shopsArray;
            
            NSLog(@"解析 收藏的店铺 数据结束了");
            [[DataRequestManager sharedInstance] responseRequest:self.repeater];
        }
    }
    else
    {
        ((DataRepeater*)self.repeater).isResponseSuccess = NO;
        ((DataRepeater*)self.repeater).errorInfo = errorInfo;
        [[DataRequestManager sharedInstance] responseRequest:self.repeater];
    }
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
