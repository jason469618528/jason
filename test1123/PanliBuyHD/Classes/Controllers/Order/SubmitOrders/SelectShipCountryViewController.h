//
//  SelectShipCountryViewController.h
//  PanliApp
//
//  Created by jason on 13-5-14.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 选择运送区域
 * 创 建 人: 刘彬
 * 创建日期: 2013-05-15
 **************************************************/
#import "BaseViewController.h"
#import "ShipCountry.h"
#import "GetShipCountryRequest.h"
#import <CoreLocation/CoreLocation.h>

@interface SelectShipCountryViewController : BaseViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    UISearchBar *bar_searchShipCountry;
    UITableView *shipCountryTableView;
    UITableView *searchTableView;
    
    //保存所有区域信息（NSDictionary形式，用于索引）
    NSMutableDictionary *shipCountryDic;
    
    //保存所有区域信息（NSArray形式，用于搜索）
    NSArray *shipCountryArrayForSearch;
    
    //搜索结果提示区域信息
    NSMutableArray *shipCountryResultArray;
    
    DataRepeater *dataRepeater;
    //请求运送区域
    GetShipCountryRequest *req_ShipCountry;
    
    CLLocationManager *locationManager;
}

@property (nonatomic, copy) NSString *str_ShipCountryName;

@end
