//
//  AppDelegate.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataRequestManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    DataRequestManager *dataRequestManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
