//
//  OrderHomeViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "OrderHomeViewController.h"
#import "OrderProCell.h"
#import "UserProduct.h"
#import "JSON.h"

@interface OrderHomeViewController ()

@end

@implementation OrderHomeViewController

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
    [super viewDidLoad];
    self.title = LocalizedString(@"OrderHomeViewController_Title", @"送货车");
    self.tab_OrderStatus.backgroundColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
    [PanliHelper setExtraCellLineHidden:self.tab_Products];
    [PanliHelper setExtraCellPixelExcursion:self.tab_Products];
    orderStatusDataSource = @[LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item1", @"已到panli"),
                              LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item2", @"问题商品"),
                              LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item3", @"处理中"),
                              LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item4", @"已订购"),
                              LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item5", @"未处理"),
                              LocalizedString(@"OrderHomeViewController_orderStatusDataSource_item6", @"无效订单")];
    _currentIndex = 0;
    isAllChecked = YES;
    
    view_ProInfo = [[OrderProInfoView alloc] initWithFrame:CGRectMake(MainScreenFrame_Width, 44.0f, 310.0f, self.tab_Products.frame.size.height)];
    [self.view insertSubview:view_ProInfo belowSubview:self.toolView];
    //右滑手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [view_ProInfo addGestureRecognizer:recognizer];
    
    //左滑手势
    UISwipeGestureRecognizer *leftDirection;
    leftDirection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftDirection setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftDirection];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellCheckButtonOnClick) name:@"CELLCHECK" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkLoginWithBlock:^{
        [self getUserOrderRequestWithStatus:[self getStatusByCurrentIndex]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (OrderDisState)getStatusByCurrentIndex
{
    switch (_currentIndex)
    {
        case 0:
            return Inpanli;
            break;
            
        case 1:
            return IssueOrder;
            break;
            
        case 2:
            return Inhand;
            break;
            
        case 3:
            return YetDGOrder;
            break;
            
        case 4:
            return UntreatedOrder;
            break;
            
        case 5:
            return InvalidOrder;
            break;
            
        default:
            return Inpanli;
            break;
    }
}

#pragma mark - request and response
- (void)getUserOrderRequestWithStatus:(OrderDisState)status
{
    [self showHUDIndicatorMessage:LocalizedString(@"OrderHomeViewController_HUDIndMsg", @"正在加载...")];
    req_GetUserOrdersRequest = req_GetUserOrdersRequest ? req_GetUserOrdersRequest :[[GetUserOrdersRequest alloc] init];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[NSString stringWithFormat:@"%d",status] forKey:RQ_USERORDERS_PARAM_STATUS];
    
    //数据转发器
    rpt_GetUserOrders = rpt_GetUserOrders ? rpt_GetUserOrders : [[DataRepeater alloc] initWithName:RQNAME_USERORDERS];
    rpt_GetUserOrders.notificationName = RQNAME_USERORDERS;
    rpt_GetUserOrders.isAuth = YES;
    __weak OrderHomeViewController *orderVC = self;
    rpt_GetUserOrders.compleBlock = ^(id repeater)
    {
        [orderVC getUserOrderResponse:repeater];
    };
    rpt_GetUserOrders.requestModal = PullData;
    rpt_GetUserOrders.networkRequest = req_GetUserOrdersRequest;
    rpt_GetUserOrders.requestParameters = param;
    [[DataRequestManager sharedInstance] sendRequest:rpt_GetUserOrders];
}

- (void)getUserOrderResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self hideHUD];
        self.productDataSource = repeater.responseValue;
        [self.tab_Products reloadData];
        [self reloadBottomView];
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        [self showHUDErrorMessage:errorInfo.message];
    }
}

#pragma mark - UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tab_OrderStatus)
    {
        return orderStatusDataSource.count;
    }
    else if (tableView == self.tab_Products)
    {
        return self.productDataSource.count;
    }
    else
    {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tab_OrderStatus)
    {
        return 80.0f;
    }
    else if (tableView == self.tab_Products)
    {
        return 117.0f;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tab_OrderStatus)
    {
        static NSString *orderStatusCellIdentifier = @"orderStatusCell";
        UITableViewCell *orderStatusCell = [tableView dequeueReusableCellWithIdentifier:orderStatusCellIdentifier];
        if(orderStatusCell == nil)
        {
            orderStatusCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderStatusCellIdentifier];
            orderStatusCell.textLabel.font = DEFAULT_FONT(17.0f);
            orderStatusCell.textLabel.backgroundColor = PL_COLOR_CLEAR;
            orderStatusCell.textLabel.textColor = [PanliHelper colorWithHexString:@"#848484"];
            orderStatusCell.textLabel.textAlignment = NSTextAlignmentCenter;
            orderStatusCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //底部线条
            UIView *line_bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 80 - 1.5, tableView.frame.size.width, 1.5f)];
            line_bottom.tag = 1000;
            line_bottom.backgroundColor = [PanliHelper colorWithHexString:@"#d8d8d8"];
            [orderStatusCell addSubview:line_bottom];
            
            //右侧线条
            UIView *line_right = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 1.5, 0.0f, 1.5f, 80.0f)];
            line_right.tag = 1001;
            line_right.backgroundColor = [PanliHelper colorWithHexString:@"#d8d8d8"];
            [orderStatusCell addSubview:line_right];
        }
        orderStatusCell.textLabel.text = [orderStatusDataSource objectAtIndex:indexPath.row];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, tableView.frame.size.height)];
        orderStatusCell.backgroundView = backgroundView;
        UIView *bottomLine = (UIView*)[orderStatusCell viewWithTag:1000];
        UIView *rightLine = (UIView*)[orderStatusCell viewWithTag:1001];
        if(_currentIndex == indexPath.row)
        {
            bottomLine.hidden = NO;
            rightLine.hidden = YES;
            backgroundView.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
        }
        else
        {
            bottomLine.hidden = YES;
            rightLine.hidden = NO;
            backgroundView.backgroundColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
        }
        return orderStatusCell;
    }
    else if (tableView == self.tab_Products)
    {
        static NSString *orderProductCellIdentifier = @"orderProductCell";
        OrderProCell *orderProductCell = (OrderProCell*)[tableView dequeueReusableCellWithIdentifier:orderProductCellIdentifier];
        if(orderProductCell == nil)
        {
            orderProductCell = (OrderProCell *)[[[NSBundle mainBundle] loadNibNamed:@"OrderProCell" owner:self options:nil]lastObject];
        }
        orderProductCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UserProduct *mProduct = [self.productDataSource objectAtIndex:indexPath.row];
        [orderProductCell initWithProduct:mProduct hiddenButton:(_currentIndex != 0)];
        return orderProductCell;
    }
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self checkLoginWithBlock:^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (tableView == self.tab_OrderStatus)
        {
            //判断是否点击同一个cell 不刷新
            if(_currentIndex != indexPath.row)
            {
                _currentIndex = indexPath.row;
                [tableView reloadData];
                
                //隐藏商品详情
                CGRect rect = view_ProInfo.frame;
                if (rect.origin.x != UI_SCREEN_HEIGHT) {
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect rect = view_ProInfo.frame;
                        rect.origin.x += rect.size.width;
                        view_ProInfo.frame = rect;
                    }];
                }
                
                //是否选择的已到panli
                if (_currentIndex == 0)
                {
                    if (self.toolView.hidden)
                    {
                        [UIView animateWithDuration:0.5 animations:^{
                            CGRect tabOrderStatusFrame = self.tab_OrderStatus.frame;
                            CGRect tabOrderProductFrame = self.tab_Products.frame;
                            CGRect proInfoViewFrame = view_ProInfo.frame;
                            CGRect toolViewFrame = self.toolView.frame;
                            tabOrderStatusFrame.size.height -= toolViewFrame.size.height;
                            tabOrderProductFrame.size.height -= toolViewFrame.size.height;
                            proInfoViewFrame.size.height -= toolViewFrame.size.height;
                            toolViewFrame.origin.y -= toolViewFrame.size.height;
                            self.tab_OrderStatus.frame = tabOrderStatusFrame;
                            self.tab_Products.frame = tabOrderProductFrame;
                            view_ProInfo.frame = proInfoViewFrame;
                            self.toolView.frame = toolViewFrame;
                        } completion:^(BOOL finished) {
                            self.toolView.hidden = NO;
                        }];
                    }
                }
                else
                {
                    //判断之前是否在已到panli
                    if (!self.toolView.hidden)
                    {
                        
                        [UIView animateWithDuration:0.5 animations:^{
                            CGRect tabOrderStatusFrame = self.tab_OrderStatus.frame;
                            CGRect tabOrderProductFrame = self.tab_Products.frame;
                            CGRect proInfoViewFrame = view_ProInfo.frame;
                            CGRect toolViewFrame = self.toolView.frame;
                            tabOrderStatusFrame.size.height += toolViewFrame.size.height;
                            tabOrderProductFrame.size.height += toolViewFrame.size.height;
                            proInfoViewFrame.size.height += toolViewFrame.size.height;
                            toolViewFrame.origin.y += toolViewFrame.size.height;
                            self.tab_OrderStatus.frame = tabOrderStatusFrame;
                            self.tab_Products.frame = tabOrderProductFrame;
                            view_ProInfo.frame = proInfoViewFrame;
                            self.toolView.frame = toolViewFrame;
                        } completion:^(BOOL finished) {
                            self.toolView.hidden = YES;
                        }];
                        
                    }
                }
                switch (indexPath.row)
                {
                    case 0:
                        [self getUserOrderRequestWithStatus:Inpanli];
                        break;
                        
                    case 1:
                        [self getUserOrderRequestWithStatus:IssueOrder];
                        break;
                        
                    case 2:
                        [self getUserOrderRequestWithStatus:Inhand];
                        break;
                        
                    case 3:
                        [self getUserOrderRequestWithStatus:YetDGOrder];
                        break;
                        
                    case 4:
                        [self getUserOrderRequestWithStatus:UntreatedOrder];
                        break;
                        
                    case 5:
                        [self getUserOrderRequestWithStatus:InvalidOrder];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        else
        {
            UserProduct *mProduct = [self.productDataSource objectAtIndex:indexPath.row];
            CGRect rect = view_ProInfo.frame;
            [view_ProInfo reloadWithProdduct:mProduct];
            if (rect.origin.x == MainScreenFrame_Width)
            {
                [UIView animateWithDuration:0.5 animations:^{             
                    CGRect rect = view_ProInfo.frame;
                    rect.origin.x -= rect.size.width;
                    view_ProInfo.frame = rect;
                }];
            }
        }
    }];
}

-(IBAction)buttonOnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
            //全选、反选
        case 1001:
        {
            if (isAllChecked)
            {
                for (UserProduct *mProduct in self.productDataSource)
                {
                    mProduct.isSelected = NO;
                }
                isAllChecked = NO;
            }
            else
            {
                for (UserProduct *mProduct in self.productDataSource)
                {
                    mProduct.isSelected = YES;
                }
                isAllChecked = YES;
            }
            [self.tab_Products reloadData];
            [self reloadBottomView];
            break;
        }
            //提交运送
        case 1002:
        {
            
            break;
        }
            
        default:
            break;
    }

}

- (void)reloadBottomView
{
    if (isAllChecked)
    {
        [self.btn_Check setTitle:LocalizedString(@"OrderHomeViewController_btnCheck1", @"全选") forState:UIControlStateNormal];
        [self.btn_Check setTitle:LocalizedString(@"OrderHomeViewController_btnCheck2", @"全不选") forState:UIControlStateHighlighted];
    }
    else
    {
        [self.btn_Check setTitle:LocalizedString(@"OrderHomeViewController_btnCheck2", @"全不选") forState:UIControlStateNormal];
        [self.btn_Check setTitle:LocalizedString(@"OrderHomeViewController_btnCheck1", @"全选") forState:UIControlStateHighlighted];
    }
    
    int count = 0;
    int weight = 0;
    float amount = 0.0;
    for (UserProduct *mProduct in self.productDataSource)
    {
        if (mProduct.isSelected)
        {
            count += mProduct.count;
            weight += mProduct.weight;
            amount += mProduct.count * mProduct.price;
        }
    }

    NSString *formatCount = [NSString stringWithFormat:LocalizedString(@"OrderHomeViewController_formatCount", @"共%d件商品"),count];
    NSString *formatWeight = [NSString stringWithFormat:LocalizedString(@"OrderHomeViewController_formatWeight", @"重量共计%d克"),weight];
    NSString *formatAmount = [NSString stringWithFormat:@"￥%.2f",amount];
    
    NSInteger countLength = [NSString stringWithFormat:@"%d",count].length;
    NSInteger weightLength = [NSString stringWithFormat:@"%d",weight].length;

    //富文本
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        //数量
        NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:formatCount];
        [countString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#818181"] range:NSMakeRange(0,1)];
        [countString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#ff0200"] range:NSMakeRange(1,countLength)];
        [countString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#818181"] range:NSMakeRange( 1 + countLength,3)];
        self.lab_Count.attributedText = countString;
        
        //重量
        NSMutableAttributedString *weightString = [[NSMutableAttributedString alloc] initWithString:formatWeight];
        [weightString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#818181"] range:NSMakeRange(0,4)];
        [weightString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#ff0200"] range:NSMakeRange(4,weightLength)];
        [weightString addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#818181"] range:NSMakeRange( 4 + weightLength,1)];
        self.lab_Weight.attributedText = weightString;
        
        //价格
        self.lab_Price.text = formatAmount;
    }
    else
    {
        self.lab_Count.text = formatCount;
        self.lab_Weight.text = formatWeight;
        self.lab_Price.text = formatAmount;
    }
}

- (void)cellCheckButtonOnClick
{
    BOOL isHaveUnChecked = NO;
    for (UserProduct *mProduct in self.productDataSource)
    {
        if (!mProduct.isSelected)
        {
            isHaveUnChecked = YES;
            break;
        }
    }
    isAllChecked = !isHaveUnChecked;
    [self reloadBottomView];
}
#pragma mark - 右滑手势调用的方法
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        CGRect rect = view_ProInfo.frame;
        if (rect.origin.x != MainScreenFrame_Width) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect rect = view_ProInfo.frame;
                rect.origin.x += rect.size.width;
                view_ProInfo.frame = rect;
            }];
        }
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        CGRect rect = view_ProInfo.frame;
        if (rect.origin.x == MainScreenFrame_Width)
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect rect = view_ProInfo.frame;
                rect.origin.x -= rect.size.width;
                view_ProInfo.frame = rect;
            }];
        }
    }
}

@end
