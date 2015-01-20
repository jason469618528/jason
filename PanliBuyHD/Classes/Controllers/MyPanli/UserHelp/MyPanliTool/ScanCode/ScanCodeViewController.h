//
//  ScanCodeViewController.h
//  PanliApp
//
//  Created by jason on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ZBarSDK.h"
#import "ZBarReaderView.h"

@interface ScanCodeViewController : BaseViewController<ZBarReaderViewDelegate>

{
    UILabel *lab_ScanData;
    UIImageView * bg_Line;
}
@property (nonatomic, retain) ZBarReaderView * readerView;
@end
