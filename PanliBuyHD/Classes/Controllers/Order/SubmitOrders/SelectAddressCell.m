//
//  SelectAddressCell.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "SelectAddressCell.h"

#define DEFAULT_COLOR [PanliHelper colorWithHexString:@"#6e6e6e"]
#define DEFAULT_ADDRESS_FONT DEFAULT_FONT(13.0f)

#define LEFT_MARGIN 20.0f

@implementation SelectAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    // Initialization code
    self.backgroundColor = PL_COLOR_CLEAR;
    
    //是否选中大背景
    self.left_img_IsMain = [[UIImageView alloc] initWithFrame:CGRectMake(37.0f + LEFT_MARGIN, 10, 270.0f, 158.5f)];
    self.left_img_IsMain.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:self.left_img_IsMain];
    
    self.right_img_IsMain = [[UIImageView alloc] initWithFrame:CGRectMake(37.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 10.0f, 270.0f, 158.5f)];
    self.right_img_IsMain.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:self.right_img_IsMain];
    
    //图标
    left_icon_IsSelectFlag = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f + LEFT_MARGIN, 10, 18, 18)];
    left_icon_IsSelectFlag.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView  addSubview:left_icon_IsSelectFlag];
    
    right_icon_IsSelectFlag = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 10.0f, 270.0f, 158.5f)];
    right_icon_IsSelectFlag.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:right_icon_IsSelectFlag];
    
    left_lab_Consignee = [[UILabel alloc]initWithFrame:CGRectMake(10, 10.0f, 125.0f, 18.0f)];
    left_lab_Consignee.textColor = DEFAULT_COLOR;
    left_lab_Consignee.backgroundColor = PL_COLOR_CLEAR;
    left_lab_Consignee.font = DEFAULT_BOLD_FONT(17.0f);
    left_lab_Consignee.textAlignment = UITextAlignmentLeft;
    [self.left_img_IsMain addSubview:left_lab_Consignee];
    
    right_lab_Consignee = [[UILabel alloc] initWithFrame:CGRectMake(10, 10.0f, 125.0f, 18.0f)];
    right_lab_Consignee.textColor = DEFAULT_COLOR;
    right_lab_Consignee.backgroundColor = PL_COLOR_CLEAR;
    right_lab_Consignee.font = DEFAULT_BOLD_FONT(17.0f);
    right_lab_Consignee.textAlignment = UITextAlignmentLeft;
    [self.right_img_IsMain addSubview:right_lab_Consignee];
    
    left_lab_Phone = [[UILabel alloc]initWithFrame:CGRectMake(125.0f, 10.0f, 135.0f, 18.0f)];
    left_lab_Phone.textColor = DEFAULT_COLOR;
    left_lab_Phone.backgroundColor = PL_COLOR_CLEAR;
    left_lab_Phone.font = DEFAULT_BOLD_FONT(17.0f);
    left_lab_Phone.textAlignment = UITextAlignmentRight;
    [self.left_img_IsMain addSubview:left_lab_Phone];
    
    right_lab_Phone = [[UILabel alloc]initWithFrame:CGRectMake(125.0f, 10.0f, 135.0f, 18.0f)];
    right_lab_Phone.textColor = DEFAULT_COLOR;
    right_lab_Phone.backgroundColor = PL_COLOR_CLEAR;
    right_lab_Phone.font = DEFAULT_BOLD_FONT(17.0f);
    right_lab_Phone.textAlignment = UITextAlignmentRight;
    [self.right_img_IsMain addSubview:right_lab_Phone];
    
    left_lab_CountryAndCity = [[UILabel alloc]initWithFrame:CGRectMake(10, 42.0f, 250.0f, 14.0f)];
    left_lab_CountryAndCity.textColor = DEFAULT_COLOR;
    left_lab_CountryAndCity.backgroundColor = PL_COLOR_CLEAR;
    left_lab_CountryAndCity.font = DEFAULT_ADDRESS_FONT;
    left_lab_CountryAndCity.textAlignment = UITextAlignmentLeft;
    [self.left_img_IsMain addSubview:left_lab_CountryAndCity];
    
    right_lab_CountryAndCity = [[UILabel alloc]initWithFrame:CGRectMake(10, 42.0f, 250.0f, 14.0f)];
    right_lab_CountryAndCity.textColor = DEFAULT_COLOR;
    right_lab_CountryAndCity.backgroundColor = PL_COLOR_CLEAR;
    right_lab_CountryAndCity.font = DEFAULT_ADDRESS_FONT;
    right_lab_CountryAndCity.textAlignment = UITextAlignmentLeft;
    [self.right_img_IsMain addSubview:right_lab_CountryAndCity];
    
    left_lab_AddressAndZip = [[UILabel alloc]initWithFrame:CGRectMake(10, 64.0f, 250, 30.0f)];
    left_lab_AddressAndZip.textColor = DEFAULT_COLOR;
    left_lab_AddressAndZip.backgroundColor = PL_COLOR_CLEAR;
    left_lab_AddressAndZip.font = DEFAULT_ADDRESS_FONT;
    left_lab_AddressAndZip.numberOfLines = 2;
    [self.left_img_IsMain addSubview:left_lab_AddressAndZip];
    
    right_lab_AddressAndZip = [[UILabel alloc]initWithFrame:CGRectMake(10, 64.0f, 250, 30.0f)];
    right_lab_AddressAndZip.textColor = DEFAULT_COLOR;
    right_lab_AddressAndZip.backgroundColor = PL_COLOR_CLEAR;
    right_lab_AddressAndZip.font = DEFAULT_ADDRESS_FONT;
    right_lab_AddressAndZip.numberOfLines = 2;
    [self.right_img_IsMain addSubview:right_lab_AddressAndZip];
    
    left_btn_Confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn_Confirm.frame = CGRectMake(46.0f + LEFT_MARGIN, 126.0f, 138.0f, 32.5f);
    [left_btn_Confirm setImage:[UIImage imageNamed:@"btn_AddressHome_confirm"] forState:UIControlStateNormal];
    [left_btn_Confirm setImage:[UIImage imageNamed:@"btn_AddressHome_confirm_on"] forState:UIControlStateHighlighted];
    left_btn_Confirm.hidden = YES;
    left_btn_Confirm.tag = 5001;
    [left_btn_Confirm addTarget:self action:@selector(selectAddressLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:left_btn_Confirm];
    
    right_btn_Confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    right_btn_Confirm.frame = CGRectMake(46.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 126.0f, 138.0f, 32.5f);
    [right_btn_Confirm setImage:[UIImage imageNamed:@"btn_AddressHome_confirm"] forState:UIControlStateNormal];
    [right_btn_Confirm setImage:[UIImage imageNamed:@"btn_AddressHome_confirm_on"] forState:UIControlStateHighlighted];
    right_btn_Confirm.hidden = YES;
    right_btn_Confirm.tag = 5001;
    [right_btn_Confirm addTarget:self action:@selector(selectAddressRightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:right_btn_Confirm];
    
    left_btn_Edit = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_btn_Edit setImage:[UIImage imageNamed:@"btn_Addresshome_Edit"] forState:UIControlStateNormal];
    [left_btn_Edit setImage:[UIImage imageNamed:@"btn_Addresshome_Edit_on"] forState:UIControlStateHighlighted];
    left_btn_Edit.hidden = YES;
    left_btn_Edit.tag = 5002;
    [left_btn_Edit addTarget:self action:@selector(selectAddressLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:left_btn_Edit];
    
    right_btn_Edit = [UIButton buttonWithType:UIButtonTypeCustom];
    [right_btn_Edit setImage:[UIImage imageNamed:@"btn_Addresshome_Edit"] forState:UIControlStateNormal];
    [right_btn_Edit setImage:[UIImage imageNamed:@"btn_Addresshome_Edit_on"] forState:UIControlStateHighlighted];
    right_btn_Edit.hidden = YES;
    right_btn_Edit.tag = 5002;
    [right_btn_Edit addTarget:self action:@selector(selectAddressRightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:right_btn_Edit];
    
    left_btn_Delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_btn_Delete setImage:[UIImage imageNamed:@"btn_Addresshome_delete"] forState:UIControlStateNormal];
    [left_btn_Delete setImage:[UIImage imageNamed:@"btn_Addresshome_delete_on"] forState:UIControlStateHighlighted];
    left_btn_Delete.hidden = YES;
    left_btn_Delete.tag = 5003;
    [left_btn_Delete addTarget:self action:@selector(selectAddressLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:left_btn_Delete];
    
    right_btn_Delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [right_btn_Delete setImage:[UIImage imageNamed:@"btn_Addresshome_delete"] forState:UIControlStateNormal];
    [right_btn_Delete setImage:[UIImage imageNamed:@"btn_Addresshome_delete_on"] forState:UIControlStateHighlighted];
    right_btn_Delete.hidden = YES;
    right_btn_Delete.tag = 5003;
    [right_btn_Delete addTarget:self action:@selector(selectAddressRightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:right_btn_Delete];
    
    left_img_Logo = [[UIImageView alloc] initWithFrame:CGRectMake(223.0f + LEFT_MARGIN, 123.0f, 75.0f, 40.5f)];
    left_img_Logo.image = [UIImage imageNamed:@"icon_SetAddress_Logo"];
    left_img_Logo.hidden = YES;
    left_img_Logo.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:left_img_Logo];
    
    right_img_Logo = [[UIImageView alloc] initWithFrame:CGRectMake(223.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 123.0f, 75.0f, 40.5f)];
    right_img_Logo.image = [UIImage imageNamed:@"icon_SetAddress_Logo"];
    right_img_Logo.hidden = YES;
    right_img_Logo.backgroundColor = PL_COLOR_CLEAR;
    [self.contentView addSubview:right_img_Logo];

}

-(void)SendLeftDisplayData:(DeliveryAddress*)deliveryAddress isSelect:(BOOL)isSelect isIndex:(int)index iViewType:(int)viewType
{
    
    //0. 提交运送 1. 收货地址更改
    if(!viewType)
    {
        left_img_Logo.hidden = YES;
        left_icon_IsSelectFlag.hidden = NO;
        left_btn_Edit.frame = CGRectMake(207.0f + LEFT_MARGIN, 126.0f, 49.0f, 32.5f);
        //判断是否选中
        if(isSelect)
        {
            self.left_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress_on"];
            left_icon_IsSelectFlag.image = [UIImage imageNamed:@"icon_IsPatch_on"];
            self.left_img_IsMain.frame = CGRectMake(37.0f + LEFT_MARGIN, 10, 270.0f, 158.5f);
            
            left_btn_Confirm.hidden = NO;
            left_btn_Edit.hidden = NO;
            left_btn_Delete.hidden = NO;
        }
        else
        {
            self.left_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress"];
            left_icon_IsSelectFlag.image = [UIImage imageNamed:@"icon_IsPatch"];
            self.left_img_IsMain.frame = CGRectMake(37.0f + LEFT_MARGIN, 10, 270.0f, 109.0f);
            
            left_btn_Confirm.hidden = YES;
            left_btn_Edit.hidden = YES;
            left_btn_Delete.hidden = YES;
        }
    }
    else
    {
        left_btn_Confirm.hidden = YES;
        left_icon_IsSelectFlag.hidden = YES;
        left_img_Logo.hidden = NO;
        left_icon_IsSelectFlag.hidden = NO;
        left_btn_Edit.hidden = NO;
        left_btn_Delete.hidden = NO;
        self.left_img_IsMain.frame = CGRectMake(25.0f + LEFT_MARGIN, 10, 270.0f, 158.5f);
        self.left_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress_on"];
        left_btn_Edit.frame = CGRectMake(27.0f + LEFT_MARGIN, 126.0f, 49.0f, 32.5f);
    }
    
    left_btn_Delete.frame = CGRectMake(left_btn_Edit.frame.origin.x + 49.0f, 126.0f, 49.0f, 32.5f);
    
    left_icon_IsSelectFlag.frame = CGRectMake(8.0f + LEFT_MARGIN, (self.left_img_IsMain.frame.size.height - 13.0f)/2 , 22.5f, 23.0f);
    
    NSString *str_CountryAndCity = [NSString stringWithFormat:@"%@ %@",deliveryAddress.country,deliveryAddress.city];
    NSString *str_AddressAndZip = [NSString stringWithFormat:@"%@ %@",deliveryAddress.address,deliveryAddress.zip];
    
    left_lab_Consignee.text = [NSString stringWithFormat:@"%@",deliveryAddress.consignee];
    left_lab_Phone.text = [NSString stringWithFormat:@"%@",deliveryAddress.telephone];
    left_lab_CountryAndCity.text = str_CountryAndCity;
    left_lab_AddressAndZip.text = str_AddressAndZip;
    
    indexFlag = index;
}

-(void)SendRightDisplayData:(DeliveryAddress*)deliveryAddress isSelect:(BOOL)isSelect isIndex:(int)index iViewType:(int)viewType
{
    
    //0. 提交运送 1. 收货地址更改
    if(!viewType)
    {
        right_img_Logo.hidden = YES;
        right_icon_IsSelectFlag.hidden = NO;
        right_btn_Edit.frame = CGRectMake(207.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 126.0f, 49.0f, 32.5f);
        //判断是否选中
        if(isSelect)
        {
            self.right_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress_on"];
            right_icon_IsSelectFlag.image = [UIImage imageNamed:@"icon_IsPatch_on"];
            self.right_img_IsMain.frame = CGRectMake(37.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 10, 270.0f, 158.5f);
            
            right_btn_Confirm.hidden = NO;
            right_btn_Edit.hidden = NO;
            right_btn_Delete.hidden = NO;
        }
        else
        {
            self.right_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress"];
            right_icon_IsSelectFlag.image = [UIImage imageNamed:@"icon_IsPatch"];
            self.right_img_IsMain.frame = CGRectMake(37.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 10, 270.0f, 109.0f);
            
            right_btn_Confirm.hidden = YES;
            right_btn_Edit.hidden = YES;
            right_btn_Delete.hidden = YES;
        }
    }
    else
    {
        right_btn_Confirm.hidden = YES;
        right_icon_IsSelectFlag.hidden = YES;
        right_img_Logo.hidden = NO;
        right_icon_IsSelectFlag.hidden = NO;
        right_btn_Edit.hidden = NO;
        right_btn_Delete.hidden = NO;
        self.right_img_IsMain.frame = CGRectMake(25.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 10, 270.0f, 158.5f);
        self.right_img_IsMain.image = [UIImage imageNamed:@"bg_Submit_SetAddress_on"];
        right_btn_Edit.frame = CGRectMake(27.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, 126.0f, 49.0f, 32.5f);
    }
    
    right_btn_Delete.frame = CGRectMake(right_btn_Edit.frame.origin.x + 49.0f, 126.0f, 49.0f, 32.5f);
    
    right_icon_IsSelectFlag.frame = CGRectMake(8.0f + LEFT_MARGIN + self.left_img_IsMain.frame.size.width + 40, (self.right_img_IsMain.frame.size.height - 13.0f)/2 , 22.5f, 23.0f);
    
    NSString *str_CountryAndCity = [NSString stringWithFormat:@"%@ %@",deliveryAddress.country,deliveryAddress.city];
    NSString *str_AddressAndZip = [NSString stringWithFormat:@"%@ %@",deliveryAddress.address,deliveryAddress.zip];
    
    right_lab_Consignee.text = [NSString stringWithFormat:@"%@",deliveryAddress.consignee];
    right_lab_Phone.text = [NSString stringWithFormat:@"%@",deliveryAddress.telephone];
    right_lab_CountryAndCity.text = str_CountryAndCity;
    right_lab_AddressAndZip.text = str_AddressAndZip;
    
    indexFlag = index;
}

-(void)hideRight
{

    [right_lab_Consignee setHidden:YES];
    [right_lab_Phone setHidden:YES];
    [right_lab_CountryAndCity setHidden:YES];
    [right_lab_AddressAndZip setHidden:YES];
    [right_icon_IsSelectFlag setHidden:YES];
    [self.right_img_IsMain setHidden:YES];
    [right_btn_Edit setHidden:YES];
    [right_btn_Delete setHidden:YES];
    [right_btn_Confirm setHidden:YES];
    [right_img_Logo setHidden:YES];
}

-(void)resetRight
{
    
    [right_lab_Consignee setHidden:NO];
    [right_lab_Phone setHidden:NO];
    [right_lab_CountryAndCity setHidden:NO];
    [right_lab_AddressAndZip setHidden:NO];
    [right_icon_IsSelectFlag setHidden:NO];
    [self.right_img_IsMain setHidden:NO];
    [right_btn_Edit setHidden:YES];
    [right_btn_Delete setHidden:YES];
    [right_btn_Confirm setHidden:YES];
    [right_img_Logo setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)selectAddressLeftClick:(UIButton *)sender {
    int type = (int)sender.tag - 5000;
    
    if([_selectAddressDelegate respondsToSelector:@selector(selectAddressType:btnTag:)])
    {
        [_selectAddressDelegate selectAddressType:type btnTag:indexFlag * 2];
    }
}

- (void)selectAddressRightClick:(UIButton *)sender {
    int type = (int)sender.tag - 5000;
    
    if([_selectAddressDelegate respondsToSelector:@selector(selectAddressType:btnTag:)])
    {
        [_selectAddressDelegate selectAddressType:type btnTag:indexFlag * 2 + 1];
    }
}
@end
