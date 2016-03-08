//
//  SearchHomeViewController.h
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SearchHomeViewController : BaseViewController
@property (nonatomic, strong) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *btn_Name;
- (IBAction)btnNameClick:(id)sender;
@end
