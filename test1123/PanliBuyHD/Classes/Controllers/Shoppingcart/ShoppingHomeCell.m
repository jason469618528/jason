//
//  ShoppingHomeCell.m
//  PanliBuyHD
//
//  Created by jason on 14-6-18.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "ShoppingHomeCell.h"
#import "UserInfo.h"
@implementation ShoppingHomeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setShopoingHomeView:(ShoppingCartProduct*)iShoppingCartProduct
{
    self.mShoppingCartProduct = iShoppingCartProduct;
    
    //圆孤 线条
    [self.txt_ProductRemark.layer setBorderWidth:1.2f];
    [self.txt_ProductRemark.layer setBorderColor:[PanliHelper colorWithHexString:@"#888888"].CGColor];
    self.txt_ProductRemark.layer.cornerRadius = 6.0f;
    
    [self.img_Product.layer setBorderWidth:1.2f];
    [self.img_Product.layer setBorderColor:[PanliHelper colorWithHexString:@"#d0d0d0"].CGColor];
    self.img_Product.layer.cornerRadius = 3.0f;
    
    [self.txt_ProductCount.layer setBorderWidth:1.2f];
    [self.txt_ProductCount.layer setBorderColor:[PanliHelper colorWithHexString:@"#888888"].CGColor];
    self.txt_ProductCount.layer.cornerRadius = 3.0f;
    
    //是否选中
    if (iShoppingCartProduct.isSelected)
    {
        self.img_IsSelect.image = [UIImage imageNamed:@"btn_padSC_isSelect_on"];
    }
    else
    {
        self.img_IsSelect.image = [UIImage imageNamed:@"btn_padSC_isSelect"];
    }
    
    self.lab_SkuRemark.font = DEFAULT_FONT(17.0f);
    //重新计算商品名的长度、高度
    self.lab_ProductName.font = DEFAULT_FONT(17.0f);
    NSString *str_ProductName = iShoppingCartProduct.productName;
    CGSize size_ProductName = [str_ProductName sizeWithFont:DEFAULT_FONT(17.0f) constrainedToSize:CGSizeMake(276.0f, 38.0f) lineBreakMode:NSLineBreakByCharWrapping];
    self.lab_ProductName.frame = CGRectMake(223.0f, 15.0f, size_ProductName.width, size_ProductName.height + 1);
    self.lab_ProductName.text = str_ProductName;
    
    
    [self.img_Product setCustomImageWithURL:[NSURL URLWithString:iShoppingCartProduct.thumbnail]];
    
    //判断vip价格
    UserInfo *mUser = [GlobalObj getUserInfo];
    float price = self.mShoppingCartProduct.price;
    switch (mUser.userGroup)
    {
        case NormalUser:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:0];
            break;
        }
        case GoldCard:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:self.mShoppingCartProduct.vipPrice1];
            break;
        }
        case PlatinumCard:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:self.mShoppingCartProduct.vipPrice2];
            break;
        }
        case DiamondCard:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:self.mShoppingCartProduct.vipPrice3];
            break;
        }
        case CrownCars:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:self.mShoppingCartProduct.vipPrice4];
            break;
        }
        default:
        {
            price = [PanliHelper getMinPriceWithCostPrice:self.mShoppingCartProduct.price
                                           promotionPrice:self.mShoppingCartProduct.promotionPrice
                                                 vipPrice:0];
            break;
        }
    }
    self.lab_Price.text = [NSString stringWithFormat:@"%.2f",price];
    
    self.lab_SkuRemark.text = iShoppingCartProduct.skuRemark;
    self.txt_ProductCount.text = [NSString stringWithFormat:@"%d",iShoppingCartProduct.buyNum];
    self.txt_ProductRemark.text = iShoppingCartProduct.remark;
}

#pragma mark - UitextFieldDegatele
static float offsetFlag = 0.0f;
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    float offset = 0.0;
    CGRect rect = self.frame;
    UITableView *tableView = (UITableView *)self.superview;
    if (![tableView isMemberOfClass:[UITableView class]])
    {
        tableView = (UITableView *)tableView.superview;
    }
    offsetFlag = tableView.contentOffset.y;
    
    float y = MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT - 352 - rect.size.height;
    if (y < (rect.origin.y + rect.size.height))
    {
        offset = (rect.origin.y + rect.size.height) - y;
        [UIView animateWithDuration:0.25 animations:^{
            [tableView setContentOffset:CGPointMake(0.0f, offset)];
        }completion:^(BOOL finished){
        }];
    }
    if(self.txt_ProductCount == textField)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CART_COUNT_KEYBOARDSHOW" object:nil];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    UITableView *tableView = (UITableView *)self.superview;
    if (![tableView isMemberOfClass:[UITableView class]])
    {
        tableView = (UITableView *)tableView.superview;
    }
    if (offsetFlag != 0)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [tableView setContentOffset:CGPointMake(0.0, offsetFlag)];
            
        }completion:^(BOOL finished){
            
        }];
    }
    int count =  [self.txt_ProductCount.text intValue];
    //只有当数量修改过且跟原来的数量不相同的时候且数量大于0才发送修改通知
    if(count > 0 && count != self.mShoppingCartProduct.buyNum)
    {
       //发送修改通知+
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
        [param setObject:self.mShoppingCartProduct.productUrl forKey:@"url"];
        [param setObject:self.mShoppingCartProduct forKey:@"modifiedProduct"];
        [param setObject:self.mShoppingCartProduct.skuComsId forKey:@"skuComsIds"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_SHOPPINGCART_PRODUCT_COUNT" object:param];
    }
    self.txt_ProductCount.text = [NSString stringWithFormat:@"%d",self.mShoppingCartProduct.buyNum];
    
    if(self.txt_ProductCount == textField)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CART_COUNT_KEYBOARDHIDE" object:nil];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.txt_ProductCount == textField)
    {
        if([string isEqualToString:@"\n"])
        {
            [self.txt_ProductCount resignFirstResponder];
            return NO;
        }
    }
    return YES;
}
#pragma mark - UitextViewDegatele
static float offsetViewFlag = 0.0f;
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    float offset = 0.0;
    CGRect rect = self.frame;
    UITableView *tableView = (UITableView *)self.superview;
    if (![tableView isMemberOfClass:[UITableView class]])
    {
        tableView = (UITableView *)tableView.superview;
    }
    offsetViewFlag = tableView.contentOffset.y;
    float y = MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT - 352 - rect.size.height;
    if (y < (rect.origin.y + rect.size.height))
    {
        offset = (rect.origin.y + rect.size.height) - y;
        [UIView animateWithDuration:0.25 animations:^{
            [tableView setContentOffset:CGPointMake(0.0f, offset)];
        }completion:^(BOOL finished){
        }];
    }
    if(self.txt_ProductRemark == textView)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CART_COUNT_KEYBOARDSHOW" object:nil];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    UITableView *tableView = (UITableView *)self.superview;
    if (![tableView isMemberOfClass:[UITableView class]])
    {
        tableView = (UITableView *)tableView.superview;
    }
    if (offsetViewFlag != 0)
    {
        [UIView animateWithDuration:0.25 animations:^{
            [tableView setContentOffset:CGPointMake(0.0, offsetViewFlag)];
        }completion:^(BOOL finished){
        }];
    }
    //备注修改逻辑
    if(![self.txt_ProductRemark.text isEqualToString:self.mShoppingCartProduct.remark])
    {
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:self.txt_ProductRemark.text forKey:@"Remark"];
        [param setObject:self.mShoppingCartProduct.productUrl forKey:@"url"];
        [param setObject:self.mShoppingCartProduct forKey:@"modifiedProduct"];
        [param setObject:self.mShoppingCartProduct.skuComsId forKey:@"skuComsIds"];
        //发送修改通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_SHOPPINGCART_PRODUCT_REMARK" object:param];
    }
    if(self.txt_ProductRemark == textView)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CART_COUNT_KEYBOARDHIDE" object:nil];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(self.txt_ProductRemark == textView)
    {
        if([text isEqualToString:@"\n"])
        {
            [self.txt_ProductRemark resignFirstResponder];
            return NO;
        }
    }
    return YES;
}
#pragma mark - btnCLick event
- (IBAction)countMinusPlus:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if(btn.tag == 1001)
    {
        if(self.mShoppingCartProduct.buyNum > 0)
        {
            self.mShoppingCartProduct.buyNum--;
        }
        
        if(self.mShoppingCartProduct.buyNum == 0)
        {
            self.mShoppingCartProduct.buyNum = 1;
            return;
        }
    }
    else
    {
        self.mShoppingCartProduct.buyNum++;
    }
    int count =  [self.txt_ProductCount.text intValue];
    //只有当数量修改过且跟原来的数量不相同的时候且数量大于0才发送修改通知
    if(count > 0 && count != self.mShoppingCartProduct.buyNum)
    {
        //发送修改通知+
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:[NSString stringWithFormat:@"%d",self.mShoppingCartProduct.buyNum] forKey:@"count"];
        [param setObject:self.mShoppingCartProduct.productUrl forKey:@"url"];
        [param setObject:self.mShoppingCartProduct forKey:@"modifiedProduct"];
        [param setObject:self.mShoppingCartProduct.skuComsId forKey:@"skuComsIds"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_SHOPPINGCART_PRODUCT_COUNT" object:param];
    }
    self.txt_ProductCount.text = [NSString stringWithFormat:@"%d",self.mShoppingCartProduct.buyNum];
}

@end
