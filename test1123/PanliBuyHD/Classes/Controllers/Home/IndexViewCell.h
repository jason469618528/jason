//
//  IndexViewCell.h
//  PanliBuyHD
//
//  Created by jason on 15-1-21.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIButton.h"
#import "indexCategory.h"
@protocol indexViewDelegate <NSObject>

- (void)indexViewDelegate:(indexCategory*)category;

@end

@interface IndexViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CustomUIButton *btn_Left;
@property (weak, nonatomic) IBOutlet CustomUIButton *btn_Mid;
@property (weak, nonatomic) IBOutlet CustomUIButton *btn_Right;
@property (strong, nonatomic) IBOutlet UILabel *lab_Left;
@property (strong, nonatomic) IBOutlet UILabel *lab_Mid;
@property (strong, nonatomic) IBOutlet UILabel *lab_Right;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,weak) id<indexViewDelegate> delegate;
- (void)reloadIndeCellArray:(NSArray*)arr;
@end
