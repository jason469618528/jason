//
//  SelectCountryViewController.m
//  PanliApp
//
//  Created by jason on 13-5-14.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SelectShipCountryViewController.h"


@interface SelectShipCountryViewController ()

@end

#define KEY_LOCATE @"定位"
#define KEY_HOT @"常用"
@implementation SelectShipCountryViewController
@synthesize str_ShipCountryName = _str_ShipCountryName;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(bar_searchShipCountry);
    SAFE_RELEASE(shipCountryTableView);
    SAFE_RELEASE(searchTableView);
    SAFE_RELEASE(shipCountryDic);
    SAFE_RELEASE(shipCountryArrayForSearch);
    SAFE_RELEASE(shipCountryResultArray);
    SAFE_RELEASE(_str_ShipCountryName);
    SAFE_RELEASE(dataRepeater);
    SAFE_RELEASE(req_ShipCountry);
    SAFE_RELEASE(locationManager);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:NO];
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#e8e8ed"];
    self.navigationItem.title = LocalizedString(@"SelectShipCountryViewController_Nav_Title",@"国家列表");
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //返回
    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
    [btn_nav_back addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
    btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
    UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
    self.navigationItem.leftBarButtonItem = btn_Left;
    [btn_Left release];

    //搜索框
    bar_searchShipCountry = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height + 20.0f, 40)];
    bar_searchShipCountry.barStyle = UIBarStyleBlackTranslucent;
    bar_searchShipCountry.autocorrectionType = UITextAutocorrectionTypeNo;
    bar_searchShipCountry.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bar_searchShipCountry.keyboardType =  UIKeyboardTypeDefault;
    bar_searchShipCountry.placeholder = LocalizedString(@"SelectShipCountryViewController_barSearchShipCountry",@"请输入国家或地区名");
    bar_searchShipCountry.delegate = self;
    [self.view addSubview:bar_searchShipCountry];
    
    //区域列表
    shipCountryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, MainScreenFrame_Height + 20.0f, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 40) style:UITableViewStyleGrouped];
    shipCountryTableView.dataSource = self;
    shipCountryTableView.delegate = self;
    [self.view addSubview:shipCountryTableView];    
    
    //初始化搜索提示框tableview
    searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 40.0f, MainScreenFrame_Height + 20.0f, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 40) style:UITableViewStylePlain];
    //searchTableView.backgroundColor = [UIColor redColor];
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    searchTableView.hidden = YES;
    [self.view addSubview:searchTableView];
    
    [self setShipCountry];
    
    //初始化定位
    locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShipCountry
{
    shipCountryArrayForSearch = [[GlobalObj getShipCountry] retain];
    if (shipCountryArrayForSearch && shipCountryArrayForSearch.count > 0)
    {
        shipCountryDic = [NSMutableDictionary new];
        for (ShipCountry* sc in shipCountryArrayForSearch)
        {
            @try
            {
                //添加到字母栏目
                NSString* firstPinYin = [sc.initial substringWithRange:NSMakeRange(0, 1)];
                firstPinYin = [firstPinYin uppercaseString];
                NSMutableArray* scArray = [shipCountryDic objectForKey:firstPinYin];
                if (!scArray || [scArray isKindOfClass:[NSNull class]]) {
                    scArray = [[NSMutableArray new] autorelease];
                }
                [scArray addObject:sc];
                [shipCountryDic setObject:scArray forKey:firstPinYin];
                //热门城市
                if (sc.isCommon)
                {
                    NSMutableArray* hotArray = [shipCountryDic objectForKey:KEY_HOT];
                    if (!hotArray || [hotArray isKindOfClass:[NSNull class]]) {
                        hotArray = [[NSMutableArray new] autorelease];
                    }
                    [hotArray addObject:sc];
                    [shipCountryDic setObject:hotArray forKey:KEY_HOT];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
        }
        ShipCountry *mShipCountry = [[ShipCountry alloc] init];
        mShipCountry.name = LocalizedString(@"SelectShipCountryViewController_mShipCountry1",@"正在定位中...");
        mShipCountry.code = @"Locationing";
        [shipCountryDic setObject:[NSArray arrayWithObjects:mShipCountry, nil] forKey:KEY_LOCATE];
        [mShipCountry release];
        [shipCountryTableView reloadData];
    }
    else
    {
        [self shipCountryRequest];
    }
    
}

#pragma mark - searchbar delegate

//点击输入框取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [bar_searchShipCountry setShowsCancelButton:NO animated:YES];
    searchTableView.hidden = YES;
    [bar_searchShipCountry resignFirstResponder];
}

//点击输入框开始输入
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [bar_searchShipCountry setShowsCancelButton:YES animated:YES];
    searchTableView.hidden = NO;
}

//输入事件
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    @try {
        if (shipCountryResultArray)
        {
            [shipCountryResultArray release];
        }
        shipCountryResultArray = [[NSMutableArray alloc]init];
        //提取搜索结果
        if (shipCountryArrayForSearch) {
            for (ShipCountry* sc in shipCountryArrayForSearch) {
                if ([sc.name hasPrefix:searchText]) {
                    [shipCountryResultArray addObject:sc];
                }
                else if ([sc.initial hasPrefix:[searchText lowercaseString]])
                {
                    [shipCountryResultArray addObject:sc];
                }
            }
        }
        
        [searchTableView reloadData];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}


#pragma mark - tableview datasource and delegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == shipCountryTableView)
    {
        NSArray* keys = [shipCountryDic allKeys];
        keys = [keys sortedArrayUsingComparator:compareBlock];
        return keys;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == shipCountryTableView)
    {
        NSArray* keys = [shipCountryDic allKeys];
        keys = [keys sortedArrayUsingComparator:compareBlock];
        for (int index = 0; index < [keys count]; index++)
        {
            if ([title isEqualToString:[keys objectAtIndex:index]])
            {
                return index;
            }
        }
        return 0;
    }
    else
    {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == searchTableView)
    {
        return nil;
    }
    else if(tableView == shipCountryTableView)
    {
        @try
        {
            NSArray* keys = [shipCountryDic allKeys];
            keys = [keys sortedArrayUsingComparator:compareBlock];
            return [keys objectAtIndex:section];
        }
        @catch (NSException *exception)
        {
            return nil;
        }
        @finally
        {
            
        }
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == searchTableView) {
        return 1;
    }
    else if (tableView == shipCountryTableView)
    {
        return [[shipCountryDic allKeys]count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == shipCountryTableView)
    {
        @try
        {
            NSArray* keys = [shipCountryDic allKeys];
            keys = [keys sortedArrayUsingComparator:compareBlock];
            NSArray* cityArray = [shipCountryDic objectForKey:[keys objectAtIndex:section]];
            return [cityArray count];
        }
        @catch (NSException *exception)
        {
            return 0;
        }
        @finally
        {
            
        }
    }
    else if (tableView == searchTableView)
    {
        
        @try
        {
            if (shipCountryResultArray)
            {
                return [shipCountryResultArray count];
            }
            else
            {
                return 0;
            }
        }
        @catch (NSException *exception)
        {
            return 0;
        }
        @finally
        {
            
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == shipCountryTableView) {
        @try {
            static NSString *cityCell = @"cityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCell]; 
            }
            
            NSArray* keys = [shipCountryDic allKeys];
            keys = [keys sortedArrayUsingComparator:compareBlock];
            NSMutableArray* scArray = [shipCountryDic objectForKey:[keys objectAtIndex:indexPath.section]];
            ShipCountry* sc = [scArray objectAtIndex:scArray.count - (indexPath.row + 1)];
            cell.textLabel.text = sc.name;
            if ([sc.code isEqualToString:@"Locationing"])
            {
                UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                activityIndicatorView.frame = CGRectMake(200.0f, 12.0f, 20.0f, 20.0f);
                [activityIndicatorView startAnimating];
                [cell.contentView addSubview:activityIndicatorView];
                [activityIndicatorView release];
                cell.userInteractionEnabled = NO;
            }
            else if([sc.code isEqualToString:@"LocationFail"])
            {
                cell.userInteractionEnabled = NO;
            }
            else
            {
                cell.userInteractionEnabled = YES;
            }
            return cell;
        }
        @catch (NSException *exception) {
            return nil;
        }
        @finally {
            
        }
    }
    else if (tableView == searchTableView) {
        @try {
            static NSString *cityCell = @"hintCityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCell];
            }
            ShipCountry* sc = [shipCountryResultArray objectAtIndex:indexPath.row];
            cell.textLabel.text = sc.name;
            return cell;
        }
        @catch (NSException *exception) {
            return nil;
        }
        @finally {
            
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == shipCountryTableView)
    {
        @try
        {
            NSArray* keys = [shipCountryDic allKeys];
            keys = [keys sortedArrayUsingComparator:compareBlock];
            NSString* key = [keys objectAtIndex:indexPath.section];            
            NSArray* scArray = [shipCountryDic objectForKey:key];
            ShipCountry* sc = [scArray objectAtIndex: scArray.count - (indexPath.row + 1)];
            self.str_ShipCountryName = sc.name;
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
    }
    else if (tableView == searchTableView)
    {
        
        ShipCountry* sc = [shipCountryResultArray objectAtIndex:indexPath.row];
        self.str_ShipCountryName = sc.name;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHIPCOUNTRYSELECTED" object:self.str_ShipCountryName];
    [self BackClick];
}

NSComparisonResult (^compareBlock)(id, id) = ^NSComparisonResult(id obj1, id obj2) {
    if ([obj1 isKindOfClass:[NSString class]]&&[obj2 isKindOfClass:[NSString class]]) {
        NSString* str1 = obj1;
        NSString* str2 = obj2;
        if ([str1 isEqualToString:KEY_LOCATE]) {
            return NSOrderedAscending;
        }
        else if ([str1 isEqualToString:KEY_HOT]) {
            if ([str2 isEqualToString:KEY_LOCATE]) {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }
        else
        {
            if ([str2 isEqualToString:KEY_LOCATE]||[str2 isEqualToString:KEY_HOT]) {
                return NSOrderedDescending;
            }
            else
            {
                unichar firstPY1 = [str1 characterAtIndex:0];
                unichar firstPY2 = [str2 characterAtIndex:0];
                if (firstPY1 > firstPY2) {
                    return NSOrderedDescending;
                }
                else
                {
                    return NSOrderedAscending;
                }
            }
        }
    }
    return NSOrderedSame;
};

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == searchTableView)
    {
        [bar_searchShipCountry resignFirstResponder];
    }
}

#pragma mark - request and response
-(void)shipCountryRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"SelectShipCountryViewController_HUDIndMsg",@"正在加载...")];
    req_ShipCountry = [[GetShipCountryRequest alloc]init];
    dataRepeater = [[DataRepeater alloc]initWithName:RQNAME_GETCOUNTRY];
    dataRepeater.notificationName = RQNAME_GETCOUNTRY;
    dataRepeater.isAuth = YES;
    dataRepeater.compleBlock = ^(id repeater)
    {
        [self GetShipCountryResponse:repeater];
    };
    dataRepeater.requestModal = PullData;
    dataRepeater.networkRequest = req_ShipCountry;
    [[DataRequestManager sharedInstance] sendRequest:dataRepeater];
    
}

-(void)GetShipCountryResponse:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        shipCountryArrayForSearch = [[GlobalObj getShipCountry] retain];
        if (shipCountryArrayForSearch && shipCountryArrayForSearch.count > 0)
        {
            shipCountryDic = [NSMutableDictionary new];
            for (ShipCountry* sc in shipCountryArrayForSearch)
            {
                //添加到字母栏目
                @try
                {
                    NSString* firstPinYin = [sc.initial substringWithRange:NSMakeRange(0, 1)];
                    firstPinYin = [firstPinYin uppercaseString];
                    NSMutableArray* scArray = [shipCountryDic objectForKey:firstPinYin];
                    if (!scArray || [scArray isKindOfClass:[NSNull class]]) {
                        scArray = [NSMutableArray new];
                    }
                    [scArray addObject:sc];
                    [shipCountryDic setObject:scArray forKey:firstPinYin];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
            }
            
            [shipCountryTableView reloadData];
        }
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];

    }
}

#pragma mark - 获取gps
//获取gps
- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation
{    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"failed with error: %@", error);
             return;
         }
         if(placemarks.count > 0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             if(placemark.ISOcountryCode != NULL || placemark.country)
             {
                 for (ShipCountry *mShipCountry in shipCountryArrayForSearch)
                 {
                     if ([mShipCountry.code isEqualToString:placemark.ISOcountryCode] || [mShipCountry.name isEqualToString:placemark.country])
                     {
                         [shipCountryDic setObject:[NSArray arrayWithObjects:mShipCountry, nil] forKey:KEY_LOCATE];
                         [shipCountryTableView reloadData];
                         break;
                     }
                 }
             }
         }
     }];
    [geocoder release];
}

- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error
{
    ShipCountry *mShipCountry = [[ShipCountry alloc] init];
    mShipCountry.name = LocalizedString(@"SelectShipCountryViewController_mShipCountry2",@"定位失败");
    mShipCountry.code = @"LocationFail";
    [shipCountryDic setObject:[NSArray arrayWithObjects:mShipCountry, nil] forKey:KEY_LOCATE];
    [mShipCountry release];
    [shipCountryTableView reloadData];
}

/**
 *返回按钮
 */
- (void)BackClick
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
