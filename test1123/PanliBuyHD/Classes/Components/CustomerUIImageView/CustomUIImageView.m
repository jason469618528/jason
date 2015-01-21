//
//  CustomUIImageView.m
//  PanliApp
//
//  Created by liubin on 13-4-20.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomUIImageView.h"
#import "UIImage+ImageScale.h"
#import "objc/runtime.h"

static char operationKey;
static char operationArrayKey;

@interface CustomUIImageView () {
    /**
     当前请求image的URL
     */
    NSURL *currentImageUrl;
}
@end


@implementation CustomUIImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame showActivity:(BOOL)activity
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (activity) {
            activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicatorView.frame = CGRectMake((self.frame.size.width-25)/2, (self.frame.size.height-25)/2, 25.0f, 25.0f);
            [activityIndicatorView startAnimating];
            [self addSubview:activityIndicatorView];
            

        }
    }
    return self;
}


- (void)setCustomImageWithURL:(NSURL *)url
{
    [self setCustomImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setCustomImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setCustomImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock dealedBlock:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock dealedBlock:(MJWebImageDealedBlock)dealedBlock
{
    [self cancelCurrentImageLoad];
    
    self.image = placeholder;
    
    if (url)
    {
        __weak UIImageView *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                                             {
                                                 if (!wself) return;
                                                 dispatch_main_sync_safe(^
                                                                         {
                                                                             __strong UIImageView *sself = wself;
                                                                             if (!sself) return;
                                                                             if (image)
                                                                             {
                                                                                 sself.image = [self imageByScalingAndCroppingForSize:self.frame.size withImage:image];
                                                                                 [sself setNeedsLayout];
                                                                                 if (activityIndicatorView != nil && activityIndicatorView.superview != nil)
                                                                                 {
                                                                                     [activityIndicatorView removeFromSuperview];
                                                                                 }
                                                                             }
                                                                             if (completedBlock && finished)
                                                                             {
                                                                                 completedBlock(image, error, cacheType);
                                                                             }
                                                                         });
                                             } dealed:dealedBlock];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setAnimationImagesWithURLs:(NSArray *)arrayOfURLs
{
    [self cancelCurrentArrayLoad];
    __weak UIImageView *wself = self;
    
    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];
    
    for (NSURL *logoImageURL in arrayOfURLs)
    {
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                                             {
                                                 if (!wself) return;
                                                 dispatch_main_sync_safe(^
                                                                         {
                                                                             __strong UIImageView *sself = wself;
                                                                             [sself stopAnimating];
                                                                             if (sself && image)
                                                                             {
                                                                                 NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                                                                                 if (!currentImages)
                                                                                 {
                                                                                     currentImages = [[NSMutableArray alloc] init];
                                                                                 }
                                                                                 [currentImages addObject:image];
                                                                                 
                                                                                 sself.animationImages = currentImages;
                                                                                 [sself setNeedsLayout];
                                                                             }
                                                                             [sself startAnimating];
                                                                         });
                                             }];
        [operationsArray addObject:operation];
    }
    
    objc_setAssociatedObject(self, &operationArrayKey, [NSArray arrayWithArray:operationsArray], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cancelCurrentImageLoad
{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)cancelCurrentArrayLoad
{
    // Cancel in progress downloader from queue
    NSArray *operations = objc_getAssociatedObject(self, &operationArrayKey);
    for (id<SDWebImageOperation> operation in operations)
    {
        if (operation)
        {
            [operation cancel];
        }
    }
    objc_setAssociatedObject(self, &operationArrayKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
        if(self.isWhiteSpace)
        {
            scaleFactor = widthFactor;
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

@end
