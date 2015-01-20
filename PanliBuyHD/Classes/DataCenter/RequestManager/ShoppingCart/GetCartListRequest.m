//
//  GetCartListRequest.m
//  PanliApp
//
//  Created by jason on 13-5-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "GetCartListRequest.h"
#import "ShoppingCartProduct.h"
#import "ShoppingCartProductList.h"
@implementation GetCartListRequest
- (id)init
{
    self = [super init];
    if (self)
    {
        tag = @"获取购物车";
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
    NSString *url = [BASE_URL stringByAppendingString:RQNAME_SHOPCART_LIST];
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    //设置请求头
    [self setHeader];
    
    [self.request setTimeOutSeconds:self.timeout];
    [self.request setRequestMethod:@"GET"];
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
    
    //检验状态码;
    ErrorInfo* errorInfo = [self checkResponseError:jsonValue];
    self.repeater.errorInfo = errorInfo;
    if (errorInfo.code == API_SUCCESS)
    {
        //接口响应成功
        NSArray *dic = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:jsonValue propertyName:RP_PARAM_RESULT];
        
        
        NSMutableArray *marr = [[NSMutableArray alloc]init];
        
        for(NSDictionary *prid in dic)
        {
            ShoppingCartProduct *m_Cart = [[ShoppingCartProduct alloc]init];
            //基类
            m_Cart.productName = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"ProductName"];
            m_Cart.productUrl = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"ProductUrl"];
            m_Cart.freight = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Freight"] floatValue];
            m_Cart.thumbnail = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Thumbnail"];
            m_Cart.price = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Price"]floatValue];
            m_Cart.description = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Description"];
            m_Cart.image = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Image"];
            
            //子类
            m_Cart.buyNum = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"BuyNum"] intValue];
            m_Cart.dateCreated = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"DateCreated"];
            
            m_Cart.isAction = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"IsAction"] boolValue];
            m_Cart.isCombinationMeal = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"IsCombinationMeal"] boolValue];
            m_Cart.itemId = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"ItemId"];
            m_Cart.remark = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"Remark"];
            m_Cart.vipPrice1 = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"VIPPrice1"] floatValue];
            m_Cart.vipPrice2 = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"VIPPrice2"] floatValue];
            m_Cart.vipPrice3 = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"VIPPrice3"] floatValue];
            m_Cart.vipPrice4 = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"VIPPrice4"] floatValue];
            m_Cart.isFreightFee = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"IsFreightFee"] boolValue];
            m_Cart.isBook = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"IsBook"] boolValue];
            m_Cart.cateGoryName = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"CategoryName"];
            m_Cart.subCategoryName = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"SubCategoryName"];
            m_Cart.shopName = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"ShopName"];
            m_Cart.shopUrl = [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"ShopUrl"];
            m_Cart.promotionPrice = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"PromotionPrice"]floatValue];
            m_Cart.promotionExpriedSeconds = [[PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"PromotionExpriedSeconds"] intValue];
            m_Cart.skuRemark =  [NSString isEmpty:[prid objectForKey:@"SkuRemark"]] ? @"": [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"SkuRemark"];
            m_Cart.skuComsId = [NSString isEmpty:[prid objectForKey:@"SkuComsId"]] ? @"": [PanliHelper getValue:Q_TYPE_STRING inJsonDictionary:prid propertyName:@"SkuComsId"];
            m_Cart.isSelected = YES;
            [marr addObject:m_Cart];
        }
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < marr.count; i++)
        {
            
            ShoppingCartProduct *mCart = (ShoppingCartProduct *)[marr objectAtIndex:i];
            NSMutableArray *marr_Product = [[NSMutableArray alloc] init];
            ShoppingCartProductList *mscp = [[ShoppingCartProductList alloc] init];
            
            mscp.shopName = mCart.shopName;
            
            if (![marr_Product containsObject:mCart])
            {
                [marr_Product addObject:mCart];
            }
            
            for (int j = 0; j < marr.count; j++)
            {
                ShoppingCartProduct *mCartTwo = (ShoppingCartProduct *)[marr objectAtIndex:j];
                if (j != i)
                {
                    if ([mCart.shopName isEqualToString:mCartTwo.shopName])
                    {
                        if (![marr_Product containsObject:mCartTwo])
                        {
                            [marr_Product addObject:mCartTwo];
                        }
                        
                    }
                }
            }
            
            
            
            mscp.marr_ProductList = marr_Product;
            mscp.shopFreight = mCart.freight;
            mscp.isSelected = YES;
            
            
            BOOL isHave = NO;
            for (ShoppingCartProductList *ccc in list)
            {
                if ([ccc.shopName isEqualToString:mscp.shopName])
                {
                    isHave = YES;
                }
            }
            if (!isHave)
            {
                [list addObject:mscp];
            }
            
        }
        
        ((DataRepeater*)self.repeater).isResponseSuccess = YES;
        //设置响应数据
        ((DataRepeater*)self.repeater).responseValue = list;
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
            errorInfo.message = LocalizedString(@"Common_ErrorInfo_API_Failure",@"失败");
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
