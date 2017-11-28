//
//  HomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"
#import "DataRepeater.h"
#import "UIImage+UIImageScale.h"
#import "HomeViewModel.h"
#import "AppDelegate.h"
#import "DTTextEditorTestController.h"

#define nb_Weak(s) __weak typeof(s) weself = s

static NSString const *TestString = @"sadfasdf";

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tab_Main;
@property(strong, nonatomic) NSMutableArray *marr_Data;

@property (nonatomic, strong) HomeViewModel *viewModel;
@end

@implementation HomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"首页";
//    *TestString = @"123";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    self.marr_Data = [NSMutableArray array];
    
    //GCD
    NSArray *arr_Image = @[@"http://img0.bdstatic.com/img/image/6446027056db8afa73b23eaf953dadde1410240902.jpg",
                           @"http://e.hiphotos.baidu.com/image/w%3D230/sign=6a4132c09252982205333ec0e7cb7b3b/b17eca8065380cd7bd41aceaa344ad345982815d.jpg",
                           @"http://img0.bdstatic.com/img/image/c6774aeee9cc323de700edcf4f2a40781409804177.jpg",
                           @"http://img0.bdstatic.com/img/image/2043d07892fc42f2350bebb36c4b72ce1409212020.jpg",
                           @"http://d.hiphotos.baidu.com/image/w%3D230/sign=12d2ba1bc45c1038247ec9c18210931c/e61190ef76c6a7ef35991227fffaaf51f3de6670.jpg",
                           @"http://f.hiphotos.baidu.com/image/w%3D230/sign=c43473826e81800a6ee58e0d813433d6/d31b0ef41bd5ad6ec8a8eee783cb39dbb6fd3c6d.jpg",
                           @"http://img0.bdstatic.com/img/image/f46ce32bc44e3f46285ef487689088111408331743.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D230/sign=ed49463a37fae6cd0cb4ac623fb20f9e/f9198618367adab4308fbc4e89d4b31c8701e464.jpg",
                           @"http://h.hiphotos.baidu.com/image/w%3D230/sign=a0226c1540a7d933bfa8e3709d4ad194/8ad4b31c8701a18b2847444e9c2f07082838fe07.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/77094b36acaf2edd93f23ba08d1001e939019373.jpg"];
    
    __weak typeof(HomeViewController*) weself = self;
    
    
    for(NSString *str_ImageUrl in arr_Image)
    {
            dispatch_async (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                NSURL *url = [NSURL URLWithString:str_ImageUrl];
                //加载图片
                NSData* imageData = [NSData dataWithContentsOfURL: url];
                if(imageData != nil)
                {
                    UIImage *image = [UIImage imageWithData:imageData];
                    image = [image scaleToSize:CGSizeMake(MainScreenFrame_Width, MainScreenFrame_Width)];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        if (image != nil)
                        {
                            //有图片添加到数组并刷新列表
                            [weself.marr_Data addObject:image];
                            [weself.tab_Main reloadData];
                        }
                        else
                        {
                            NSLog(@"没有图片");
//                            [weself.marr_Data addObject:nil];
                        }
                    });
                }
                else
                {
                    NSLog(@"No data could get downloaded the URL.");
                }
            });
    }
    
    //NSPredicate NSRegularExpression
    NSMutableArray *arr_Priedicate = [NSMutableArray arrayWithArray:@[@"1",@"123",@"1234",@"12"]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"3"];
    [arr_Priedicate filterUsingPredicate:predicate];
    NSLog(@"%@",arr_Priedicate);
    
    
    [self.viewModel.homeCommand.executionSignals subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [[self.viewModel.homeCommand.executionSignals takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [self.viewModel.homeCommand execute:@"parmas"];

}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage *)image
{
    targetSize.width = targetSize.width*2;
    targetSize.height = targetSize.height*2;
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(NO)
        {
//            scaleFactor = widthFactor;
        }
        else
        {
            if (widthFactor > heightFactor)
                scaleFactor = widthFactor; // scale to fit height
            else
                scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (targetHeight > scaledHeight)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (targetWidth < scaledWidth)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.marr_Data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [self.marr_Data objectAtIndex:indexPath.row];
    return image.size.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    HomeCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = (HomeCell*)[[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] firstObject];
    }
    UIImage *image = [self.marr_Data objectAtIndex:indexPath.row];
    [cell setDisplayImage:image];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIImage *image = [self.marr_Data objectAtIndex:indexPath.row];
    DTTextEditorTestController *detailVC = [[DTTextEditorTestController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#define ArticleContentHtmlPTag (@"<p style='font-size:0.1px;color:#fff;font-family:Arial;line-height:5px;vertical-align: middle;'> . </p>")

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    
    NSString * searchStr = @"计算机*呢是你@是你是是是#说你想说的到<img src='图片1' />计算机*呢是你@是你是是是#说你想说的到<img src='图片2' />";
    NSString * regExpStr = @"<img.+?src=[\"'](.+?)[\"'].*?>";
    NSString * replacement = @"ha";
    // 创建 NSRegularExpression 对象,匹配 正则表达式
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    NSArray *matchs = [regExp matchesInString:searchStr options:kNilOptions range:NSMakeRange(0, searchStr.length)];
    NSString *changeString = searchStr;
    for (NSTextCheckingResult* b in matchs)
    {
        NSString *str1 = [searchStr substringWithRange:b.range];
        changeString =  [changeString stringByReplacingOccurrencesOfString:str1 withString:[NSString stringWithFormat:@"%@%@%@",ArticleContentHtmlPTag,str1,ArticleContentHtmlPTag]];
        NSLog(@"%@",searchStr);
    }
    NSString *resultStr = searchStr;
    // 替换匹配的字符串为 searchStr
    resultStr = [regExp stringByReplacingMatchesInString:searchStr
                                                 options:NSMatchingReportProgress
                                                   range:NSMakeRange(0, searchStr.length)
                                            withTemplate:replacement];
    NSLog(@"\\nsearchStr = %@\\nresultStr = %@",searchStr,resultStr);
    
    [self convert:searchStr];
    
}

- (NSString *) convert:(NSString *)input
{
    //a pattern for urls - use whatever suits
      //construct a pattern which matches emphPat OR urlPat
      //emphPat is first so its two groups are numbered 1 & 2 in the resulting match
        NSString * regExpStr = @"<img.+?src=[\"'](.+?)[\"'].*?>";
      //build the re
      NSError *error = nil;
    NSRegularExpression *re = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    
      //check for error - omitted
      //get all the matches - includes both urls and text to be emphasised
      NSArray *matches = [re matchesInString:input options:0 range:NSMakeRange(0, input.length)];
      NSInteger offset = 0;//will track the change in size
      NSMutableString *output = input.mutableCopy;//mutuable copy of input to modify to produce output
      for (NSTextCheckingResult *aMatch in matches)
      {
          NSString *str1 = [input substringWithRange:aMatch.range];
          NSRange first = [aMatch rangeAtIndex:1];
          if (first.location!= NSNotFound)
          {
              //the first group has been matched => that is the emphPat (which contains the first two groups)
              //determine the replacement string
              NSString *replacement = [re replacementStringForResult:aMatch inString:output offset:offset template:[NSString stringWithFormat:@"%@%@%@",ArticleContentHtmlPTag,str1,ArticleContentHtmlPTag]];
              NSRange whole = aMatch.range;//original range of the match
              whole.location += offset;//add in the offset to allow for previous replacements
              offset += replacement.length - whole.length;//modify the offset to allow for the length change caused by this replacement
              //perform the replacement
              [output replaceCharactersInRange:whole withString:replacement];
          }
      }
      return output;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}
//设置为允许旋转
- (BOOL) shouldAutorotate {
    return NO;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;  
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //    return  UIInterfaceOrientationPortrait;
    return UIInterfaceOrientationPortrait;
}

#pragma mark - getter
- (HomeViewModel*)viewModel {
    if(_viewModel == nil) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}


@end
