//
//  EstimateListViewController.m
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "EstimateListViewController.h"
#import "EstimateListCell.h"
#import "ShipCountry.h"
#import "DataRequestManager.h"
@interface EstimateListViewController ()

@end

@implementation EstimateListViewController

@synthesize type;
@synthesize shipCountryId;
@synthesize price;
@synthesize weight;

#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(arr_Estimatrs);
    SAFE_RELEASE(tab_Estimates);
    SAFE_RELEASE(req_Estimates);
    SAFE_RELEASE(data_Estimates);
    SAFE_RELEASE(type);
    SAFE_RELEASE(shipCountryId);
    SAFE_RELEASE(price);
    SAFE_RELEASE(weight);
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    [self viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"EstimateListViewController_Nav_Title",@"估算结果");
    UIImageView * bg_Top=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_Esmate_Top"]];
    bg_Top.frame=CGRectMake(10, 20, 301,50);
    [self.view addSubview:bg_Top];
    [bg_Top release];
    
    //运送国家
    UILabel *lab_Own = [[UILabel alloc]initWithFrame:CGRectMake(30, 25, 200, 17)];
    lab_Own.text = shipCountryId;
    lab_Own.backgroundColor = PL_COLOR_CLEAR;
    lab_Own.font = DEFAULT_FONT(13);
    [self.view addSubview:lab_Own];
    [lab_Own release];
    
    //运单重量
    NSString *str_Weight = [NSString stringWithFormat:LocalizedString(@"EstimateListViewController_strWeight",@"%@克运单,"),weight];
    UILabel *lab_Weight = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 200, 17)];
    lab_Weight.text = str_Weight;
    lab_Weight.backgroundColor = PL_COLOR_CLEAR;
    lab_Weight.font = DEFAULT_FONT(13);
    [self.view addSubview:lab_Weight];
    [lab_Weight release];
    
    //商品总价
    CGSize size = [str_Weight sizeWithFont:DEFAULT_FONT(13)
                           constrainedToSize:CGSizeMake(200, 17)
                               lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *lab_Price = [[UILabel alloc]initWithFrame:CGRectMake(size.width+40, 40, 200, 17)];
    lab_Price.text = [NSString stringWithFormat:LocalizedString(@"EstimateListViewController_labPrice",@"商品价值%@元"),price];
    lab_Price.backgroundColor = PL_COLOR_CLEAR;
    lab_Price.font = DEFAULT_FONT(13);
    [self.view addSubview:lab_Price];
    [lab_Price release];
    
    tab_Estimates = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, MainScreenFrame_Width, MainScreenFrame_Height - 80 - UI_NAVIGATION_BAR_HEIGHT)style:UITableViewStylePlain];
    tab_Estimates.delegate = self;
    tab_Estimates.dataSource = self;
    tab_Estimates.backgroundColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_Estimates];
    [self.view addSubview:tab_Estimates];
    [self StarEstimate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UitableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_Estimatrs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"shoppingCell";
    
    EstimateListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[EstimateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView setSeparatorColor:PL_COLOR_CLEAR];
    }
    
    SendType *mSendType = (SendType*)[arr_Estimatrs objectAtIndex:indexPath.row];
    [cell SetData:mSendType productPrice:[price floatValue]];
   
    
    return cell;
}

#pragma mark - 请求结果
-(void)StarEstimate
{
    [self showHUDIndicatorMessage:LocalizedString(@"EstimateListViewController_HUDIndMsg",@"正在加载...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *str_Country = [self CountryToString:shipCountryId];
    [params setValue:LocalizedString(@"EstimateListViewController_params",@"代购") forKey:RQ_ESTIMATES_PARM_TYPE];
    [params setValue:str_Country forKey:RQ_ESTIMATES_PARM_SHIPCOUNTRYID];
    [params setValue:price forKey:RQ_ESTIMATES_PARM_PRICE];
    [params setValue:weight forKey:RQ_ESTIMATES_PARM_WEIGHT];

    data_Estimates = data_Estimates ? data_Estimates : [[DataRepeater alloc]initWithName:RQNAME_ESTIMATES];
    req_Estimates = req_Estimates ? req_Estimates : [[EstimatesRequest alloc]init];
    data_Estimates.networkRequest = req_Estimates;
    data_Estimates.requestModal = PullData;
    data_Estimates.requestParameters = params;
    [params release];
    data_Estimates.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_Estimates.compleBlock = ^(id repeater){
        [weakSelf StarEstimateData:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_Estimates];
}
-(void)StarEstimateData:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        arr_Estimatrs = [repeater.responseValue retain];
        [tab_Estimates reloadData];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}
#pragma mark - 转换国家地址id
-(NSString * ) CountryToString:(NSString*)countryString
{
    
    NSArray *m_Country = [GlobalObj getShipCountry];
    
    
    NSString * str = nil;
    
    for(ShipCountry * pro in m_Country)
    {
        
        NSString * name= pro.name;
        
        if([name isEqualToString:shipCountryId])
        {
            str=[NSString stringWithFormat:@"%d", pro.shipCountryId];
        }
        
    }
    
    
    return str;
    
}

@end
