//
//  JavaScriptCoreViewController.h
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/20.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSExport <JSExport>
JSExportAs(calculateForJS,- (void)handleFactorialCalculateWithNumber:(NSNumber *)number);
- (void)pushViewController:(NSString *)view title:(NSString *)title;
@end
@interface JavaScriptCoreViewController : UIViewController <UIWebViewDelegate,TestJSExport>
@property (strong, nonatomic) JSContext *context;

@end
