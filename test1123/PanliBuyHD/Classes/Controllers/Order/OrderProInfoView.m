//
//  OrderProInfoView.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "OrderProInfoView.h"

@implementation OrderProInfoView

+ (OrderProInfoView *)instanceWithFrame:(CGRect)frame
{
    OrderProInfoView *view = (OrderProInfoView *)[[NSBundle mainBundle] loadNibNamed:@"OrderProInfoView" owner:nil options:nil][0];
    view.frame = frame;
    return view;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PanliHelper colorWithHexString:@"#FFFFFF"];
        
        //商品图片
        img_product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 80.0f, 80.0f)];
        [img_product.layer setBorderWidth:1.0f];
        [img_product.layer setBorderColor:[PanliHelper colorWithHexString:@"#c8c9c6"].CGColor];
        [self addSubview:img_product];
        
        //商品类型
        img_type = [[UIImageView alloc] initWithFrame:CGRectMake(62.0f, 62.0f, 28.0f, 28.0f)];
        [self addSubview:img_type];
        
        //商品名称
        lab_proName = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 10.0f, 200.0f, 40.0f)];
        lab_proName.backgroundColor = PL_COLOR_CLEAR;
        lab_proName.textColor = [PanliHelper colorWithHexString:@"#858585"];
        lab_proName.textAlignment = UITextAlignmentLeft;
        lab_proName.font = DEFAULT_FONT(14.0f);
        lab_proName.numberOfLines = 2;
        [self addSubview:lab_proName];
        
        //商品价格
        lab_price = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 80.0f, 90.0f, 20.0f)];
        lab_price.backgroundColor = PL_COLOR_CLEAR;
        lab_price.textColor = [PanliHelper colorWithHexString:@"#ff6800"];
        lab_price.textAlignment = UITextAlignmentLeft;
        lab_price.font = DEFAULT_FONT(15.0f);
        [self addSubview:lab_price];
        
        //数量
        lab_count = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 80.0f, 100.0f, 20.0f)];
        lab_count.backgroundColor = PL_COLOR_CLEAR;
        lab_count.textColor = [PanliHelper colorWithHexString:@"#999999"];
        lab_count.textAlignment = UITextAlignmentRight;
        lab_count.font = DEFAULT_FONT(15.0f);
        [self addSubview:lab_count];
        
        //代购进度
        UIView *scheduleView = [self getTitleViewWithFrame:CGRectMake(0.0f, 110.0f, self.frame.size.width, 33.0f) Image:[UIImage imageNamed:@"icon_order_jd"] title:LocalizedString(@"OrderProInfoView_scheduleView", @"代购进度")];
        [self addSubview:scheduleView];
        
        tab_schedule = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 143.0f, self.frame.size.width, 130.0f) style:UITableViewStylePlain];
        tab_schedule.backgroundColor = PL_COLOR_CLEAR;
        tab_schedule.delegate = self;
        tab_schedule.dataSource = self;
        tab_schedule.scrollEnabled = NO;
        tab_schedule.separatorColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        [PanliHelper setExtraCellLineHidden:tab_schedule];
        [self addSubview:tab_schedule];
        
        //国内物流
        UIView *transFlowView = [self getTitleViewWithFrame:CGRectMake(0.0f, 273.0f, self.frame.size.width, 33.0f) Image:[UIImage imageNamed:@"icon_order_wl"] title:LocalizedString(@"OrderProInfoView_transFlowView", @"国内物流")];
        [self addSubview:transFlowView];
        
        tab_transFlow = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 306.0f, self.frame.size.width, 130.0f) style:UITableViewStylePlain];
        tab_transFlow.backgroundColor = PL_COLOR_CLEAR;
        tab_transFlow.delegate = self;
        tab_transFlow.dataSource = self;
        tab_transFlow.scrollEnabled = NO;
        tab_transFlow.separatorColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        [PanliHelper setExtraCellLineHidden:tab_transFlow];
        [self addSubview:tab_transFlow];
        
        //商品备注
        UIView *remakView = [self getTitleViewWithFrame:CGRectMake(0.0f, 436.0f, self.frame.size.width, 33.0f) Image:[UIImage imageNamed:@"icon_order_bz"] title:LocalizedString(@"OrderProInfoView_remakView", @"商品备注")];
        [self addSubview:remakView];
        
        txt_remark = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 469.0f, self.frame.size.width-20, 33.0f)];
        txt_remark.editable = NO;
        txt_remark.textColor = [PanliHelper colorWithHexString:@"#a8a8a8"];
        [self addSubview:txt_remark];
    }
    return self;
}

- (UIView *)getTitleViewWithFrame:(CGRect)frame Image:(UIImage *)icon title:(NSString *)title
{
    UIView *titleView = [[UIView alloc] initWithFrame:frame];
    titleView.backgroundColor = [PanliHelper colorWithHexString:@"#ececec"];
    
    UIImageView *img_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 9.0f, 16.0f, 15.0f)];
    img_icon.image = icon;
    [titleView addSubview:img_icon];
    
    UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 8.0f, 100.0f, 20.0f)];
    lab_title.backgroundColor = PL_COLOR_CLEAR;
    lab_title.textColor = [PanliHelper colorWithHexString:@"#707070"];
    lab_count.textAlignment = UITextAlignmentRight;
    lab_title.text = title;
    lab_title.font = DEFAULT_FONT(15.0f);
    [titleView addSubview:lab_title];
    return titleView;
}

//1
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

//2
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)reloadWithProdduct:(UserProduct *)mProduct
{
    self.mProduct = mProduct;
    lab_proName.text = mProduct.productName;
    lab_price.text = [NSString stringWithFormat:@"￥%.2f",mProduct.price];
    lab_count.text = [NSString stringWithFormat:LocalizedString(@"OrderProInfoView_labCount", @"X%d（%d克）"),mProduct.count,mProduct.weight];
    [img_product setCustomImageWithURL:[NSURL URLWithString:mProduct.thumbnail]];
    //是否拼单购
    if (mProduct.isPiece)
    {
        [img_type setImage:[UIImage imageNamed:@"img_order_group"]];
    }
    else if (mProduct.isGroup)
    {
        [img_type setImage:[UIImage imageNamed:@"img_order_join"]];
    }
    else
    {
        [img_type setImage:nil];
    }
    
    txt_remark.text = mProduct.skuRemark;

}

#pragma mark - UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 0;
            break;
        case 1:
            return 0;
            break;
        case 2:
            return 0;
            break;
    
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
