//
//  ViewController.h
//  ChatDemo
//
//  Created by jason on 16/3/30.
//  Copyright © 2016年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    dispatch_queue_t refreshQueue;
}
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

