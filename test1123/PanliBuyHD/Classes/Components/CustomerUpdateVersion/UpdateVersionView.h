//
//  UpdateVersionView.h
//  PanliApp
//
//  Created by jason on 13-11-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateVersionViewDelegate <NSObject>

@optional
- (void)guideViewWillRemove;

@end

@interface UpdateVersionView : UIView

@property (nonatomic, assign) id<UpdateVersionViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame shadowLayerImage:(UIImage *)shadowImage;

- (id)initUpdateVersionBgMain:(UIImage*)bgMain MainFrame:(CGRect)MainRect bgTitle:(UIImage*)bgTitle titleFrame:(CGRect)titleFrame;

- (id)initWithFrame:(CGRect)frame ButtonFrame:(CGRect)btnFrame backgroundImageName:(NSString *)imageName;
@end
