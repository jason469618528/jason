//
//  ShoppingHomeCell.h
//  PanliBuyHD
//
//  Created by jason on 14-6-18.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIImageView.h"
#import "ShoppingCartProduct.h"
@interface ShoppingHomeCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *img_IsSelect;
@property (strong, nonatomic) IBOutlet CustomUIImageView *img_Product;
@property (strong, nonatomic) IBOutlet UILabel *lab_ProductName;
@property (strong, nonatomic) IBOutlet UILabel *lab_SkuRemark;
@property (strong, nonatomic) IBOutlet UITextField *txt_ProductCount;
@property (strong, nonatomic) IBOutlet UILabel *lab_Price;
@property (strong, nonatomic) IBOutlet UITextView *txt_ProductRemark;

@property (nonatomic, strong) ShoppingCartProduct *mShoppingCartProduct;
@property (weak, nonatomic) IBOutlet UIButton *btn_CountMinus;
@property (weak, nonatomic) IBOutlet UIButton *btn_CountPlus;
- (void)setShopoingHomeView:(ShoppingCartProduct*)iShoppingCartProduct;
- (IBAction)countMinusPlus:(id)sender;
@end
