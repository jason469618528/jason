//
//  MsgProductDetailViewController.m
//  PanliApp
//
//  Created by jason on 13-6-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MsgProductDetailViewController.h"
#import "UserProduct.h"
#import "CustomUIImageView.h"
#import "CustomerExceptionView.h"
@interface MsgProductDetailViewController ()

@end

@implementation MsgProductDetailViewController
@synthesize str_ProductId = _str_ProductId;

#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_str_ProductId);
    SAFE_RELEASE(req_GetProduct);
    SAFE_RELEASE(data_GetProduct);
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册获取消息详细通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getProductDetail:)
//                                                 name:RQNAME_GETUSERPRODUCT
//                                               object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
//    [self viewDidLoadWithBackButtom:YES];
    
    self.navigationItem.title = LocalizedString(@"MsgProductDetailViewController_Nav_Title", @"商品信息");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#d8d8d8"];
    
    //scrollview
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    mainScrollView.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeee"];
    mainScrollView.canCancelContentTouches = NO;
    mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    mainScrollView.clipsToBounds = NO;
    mainScrollView.pagingEnabled = NO;
    mainScrollView.scrollEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.bounces = YES;
//    mainScrollView.contentSize = CGSizeMake(MainScreenFrame_Width, 640 - 49 - 55 + REMARKVIEWHEIGHT + 50);
    [self.view addSubview:mainScrollView];
    [mainScrollView release];
    
    [self getProductDetail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loaddataandview
- (void)loadDataAndView:(UserProduct*)mProduct
{
    NSString *str_SkuRemark = [NSString stringWithFormat:@"%@",mProduct.skuRemark];

    CGSize skuSize = [str_SkuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(150.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize singleLineSize = [str_SkuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(150.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    //按钮默认背景
    UIImage *img_propertyBtnBackground = [UIImage imageNamed:@"bg_Message_ProductDetail@2x.png"];
    img_propertyBtnBackground = [img_propertyBtnBackground stretchableImageWithLeftCapWidth:floorf(img_propertyBtnBackground.size.width/2) topCapHeight:floorf(img_propertyBtnBackground.size.height/2)];
    //背景图
    UIImageView *bg_Main = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 291, 412.5 + skuSize.height - singleLineSize.height)];
    [bg_Main setImage:img_propertyBtnBackground];
    [mainScrollView addSubview:bg_Main];
    [bg_Main release];
    
      //图片
    CustomUIImageView *img_Product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(40, 18, 240, 140)];
    img_Product.layer.masksToBounds=YES;
    img_Product.layer.cornerRadius = 6.0f;
    img_Product.layer.borderColor = [PanliHelper colorWithHexString:@"#f8f8f5"].CGColor;
    img_Product.layer.borderWidth = 0.5f;
    [mainScrollView addSubview:img_Product];
    [img_Product setCustomImageWithURL:[NSURL URLWithString:mProduct.image]
                      placeholderImage:[UIImage imageNamed:@"default_240X200"]];
    [img_Product release];
    
    //商品名
    UILabel *lab_ProductName = [[UILabel alloc]initWithFrame:CGRectMake(30, 160, 260, 80)];
    lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#1e2121"];
    lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
    lab_ProductName.numberOfLines = 2;
    lab_ProductName.text = mProduct.productName;
    lab_ProductName.font = DEFAULT_FONT(16);
    [mainScrollView addSubview:lab_ProductName];
    [lab_ProductName release];
    
    
    NSArray *arr_Title = [[NSArray alloc]initWithObjects:
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item1", @"下单时间"),
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item2", @"商品价格"),
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item3", @"购买数量"),
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item4", @"商品款式"),
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item5", @"商品状态"),
                          LocalizedString(@"MsgProductDetailViewController_arrTitle_item6", @"商品备注"), nil];
    NSArray *arr_Data =  [[NSArray alloc]initWithObjects:
                          [PanliHelper timestampToDateString:mProduct.orderDate formatterString:@"yyyy-MM-dd HH:mm:ss"],
                          [NSString stringWithFormat:@"%.2f",mProduct.price],
                          [NSString stringWithFormat:@"x%d",mProduct.count],
                          [NSString stringWithFormat:@"%@",mProduct.skuRemark],
                          [NSString stringWithFormat:@"%@",[self getStatus:mProduct.status]],
                          [NSString stringWithFormat:@"%@",[NSString isEmpty:mProduct.remark]?LocalizedString(@"MsgProductDetailViewController_mProduct_none", @"无"):mProduct.remark], nil];
    
    for (int i = 0;i < arr_Title.count; i++)
    {
        //Title
        UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(65,i*30+237, 300, 20)];
        lab_Title.tag = 1001+i;
        lab_Title.textColor = [PanliHelper colorWithHexString:@"#8d8d8d"];
        lab_Title.text = [NSString stringWithFormat:@"%@:",[arr_Title objectAtIndex:i]];
        lab_Title.backgroundColor = PL_COLOR_CLEAR;
        lab_Title.font = DEFAULT_FONT(15);
        [mainScrollView addSubview:lab_Title];
        [lab_Title release];
        
        //背景图(icon)
        UIImageView *bg_State = [[UIImageView alloc] initWithFrame:CGRectMake(35,i*30+237+2, 17, 17)];
        bg_State.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_Message_Product%d",i]];
        [mainScrollView addSubview:bg_State];
        [bg_State release];

        //TextData
        UILabel *lab_Data = [[UILabel alloc]initWithFrame:CGRectMake(140, 237+i*30, 150, 20)];
        lab_Data.backgroundColor = PL_COLOR_CLEAR;
        lab_Data.textColor = [PanliHelper colorWithHexString:@"#93c737"];
        lab_Data.text = [NSString stringWithFormat:@"%@",[arr_Data objectAtIndex:i]];
        lab_Data.font = DEFAULT_FONT(14);
        [mainScrollView addSubview:lab_Data];
        [lab_Data release];
        
        //背景图线
        UIImageView *bg_Line = [[UIImageView alloc] initWithFrame:CGRectMake(35.0f,i*30+232, 250.0f, 2.0f)];
        bg_Line.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
        [mainScrollView addSubview:bg_Line];
        [bg_Line release];
        
        if(i == 3)
        {
            lab_Data.numberOfLines = 0;
            lab_Data.frame = CGRectMake(140, 237+i*30, skuSize.width, skuSize.height);
            lab_Data.textColor = [PanliHelper colorWithHexString:@"#4e4e4f"];
        }
        else if(i == 4)
        {
            lab_Data.frame = CGRectMake(140, 237+i*30 + skuSize.height -singleLineSize.height, 250.0f, 20);
            bg_Line.frame = CGRectMake(35.0f,i*30+232 + skuSize.height - singleLineSize.height, 250.0f, 2.0f);
            lab_Title.frame = CGRectMake(65,i*30+237 + skuSize.height -singleLineSize.height , 300, 20);
            bg_State.frame = CGRectMake(35,i*30+237+2 + skuSize.height - singleLineSize.height, 17, 17);
            lab_Data.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
        }
        else if(i == 5)
        {
            lab_Data.frame = CGRectMake(140, 237+i*30 + skuSize.height -singleLineSize.height, 250.0f, 20);
            bg_Line.frame = CGRectMake(35.0f,i*30+232 + skuSize.height - singleLineSize.height, 250.0f, 2.0f);
            lab_Title.frame = CGRectMake(65,i*30+237 + skuSize.height -singleLineSize.height , 300, 20);
            bg_State.frame = CGRectMake(35,i*30+237+2 + skuSize.height - singleLineSize.height, 17, 17);
        }
}
    SAFE_RELEASE(arr_Title);
    SAFE_RELEASE(arr_Data);
    UILabel *lable = (UILabel *)[mainScrollView viewWithTag:1004];
    mainScrollView.contentSize = CGSizeMake(MainScreenFrame_Width,skuSize.height  + lable.frame.origin.y + 80);
}
#pragma mark - request
-(void)getProductDetail
{
    [self showHUDIndicatorMessage:LocalizedString(@"MsgProductDetailViewController_HUDIndMsg", @"正在加载...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_str_ProductId forKey:RQ_GETUSERPRODUCT_PARM_PRODUCTID];
    req_GetProduct = req_GetProduct?req_GetProduct: [[GetUserProductRequest alloc] init];
    data_GetProduct = data_GetProduct?data_GetProduct:[[DataRepeater alloc]initWithName:RQNAME_GETUSERPRODUCT];
    data_GetProduct.requestParameters = params;
    data_GetProduct.notificationName = RQNAME_GETUSERPRODUCT;
    data_GetProduct.requestModal = PushData;
    data_GetProduct.networkRequest = req_GetProduct;
    [params release];
    
    data_GetProduct.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_GetProduct.compleBlock = ^(id repeater){
        [weakSelf getProductDetail:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_GetProduct];
}
-(void)getProductDetail:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        NSArray *arr_Product = repeater.responseValue;
        if(arr_Product != nil && arr_Product.count > 0)
        {
            UserProduct *mProduct = (UserProduct*)[arr_Product objectAtIndex:0];
            [self loadDataAndView:mProduct];
        }
    }
    else
    {
        if(repeater.errorInfo.code == NETWORK_ERROR)
        {
            
            CustomerExceptionView *exceptionView = [[CustomerExceptionView alloc]init];
            exceptionView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
            exceptionView.image = [UIImage imageNamed:@"icon_None_NetWork"];
            exceptionView.title = LocalizedString(@"MsgProductDetailViewController_exceptionView", @"网络不给力");
            exceptionView.detail = @"";
            [exceptionView setNeedsDisplay];
            [exceptionView setHidden:NO];
            [self.view addSubview:exceptionView];
            [exceptionView release];

        }
        else
        {
            [self showHUDErrorMessage:repeater.errorInfo.message];
        }
    }
}
- (NSString *)getStatus:(int)status
{
    switch (status)
    {
        case -1:
        {
            return LocalizedString(@"MsgProductDetailViewController_status1", @"无需展示状态");
            break;
        }
        case 11:
        {
            return LocalizedString(@"MsgProductDetailViewController_status2", @"拼单失败");
            break;
        }
        case 1:
        {
            return LocalizedString(@"MsgProductDetailViewController_status3", @"未处理");
            break;
        }
        case 2:
        {
            return LocalizedString(@"MsgProductDetailViewController_status4", @"处理中");
            break;
        }
        case 3:
        {
            return LocalizedString(@"MsgProductDetailViewController_status5", @"订购中");
            break;
        }
        case 4:
        {
            return LocalizedString(@"MsgProductDetailViewController_status6", @"已订购");
            break;
        }
        case 5:
        {
            return LocalizedString(@"MsgProductDetailViewController_status7", @"无货");
            break;
        }
        case 6:
        {
            return LocalizedString(@"MsgProductDetailViewController_status8", @"无效商品");
            break;
        }
        case 7:
        {
            return LocalizedString(@"MsgProductDetailViewController_status9", @"问题商品");
            break;
        }
        case 8:
        {
            return LocalizedString(@"MsgProductDetailViewController_status10", @"退换货处理中");
            break;
        }
        case 9:
        {
            return LocalizedString(@"MsgProductDetailViewController_status11", @"联系卖家中");
            break;
        }
        case 10:
        {
            return LocalizedString(@"MsgProductDetailViewController_status12", @"已到panli");
            break;
        }
        default:
        {
            return @"";
            break;
        }
    }
}


@end
