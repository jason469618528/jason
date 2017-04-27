//
//  ViewController.h
//  JSPatch_demo
//
//  Created by huangjian on 17/2/7.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^test)();

@interface ViewController : UIViewController


- (void)block:(void(^)())testaaa;

@end

