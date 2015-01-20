//
//  CustomUIButton.m
//  PanliApp
//
//  Created by liubin on 13-4-20.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomUIButton.h"
#import "UIImage+ImageScale.h"
#import "objc/runtime.h"

static char operationKey;
@interface CustomUIButton () {
    /**
     当前image的URL
     */
    NSURL *currentImageUrl;
    
    /**
     当前背景image的URL
     */
    NSURL *currentBGImageUrl;
}
@end

@implementation CustomUIButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self setCustomImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self setCustomImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setCustomImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}
- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setCustomImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)setCustomImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    
    [self setImage:placeholder forState:state];
    
    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                                             {
                                                 if (!wself) return;
                                                 dispatch_main_sync_safe(^
                                                                         {
                                                                             __strong UIButton *sself = wself;
                                                                             if (!sself) return;
                                                                             if (image)
                                                                             {
                                                                                 [sself setImage:[self imageByScalingAndCroppingForSize:self.frame.size withImage:image] forState:state];
                                                                                 [sself setImage:[self imageByScalingAndCroppingForSize:self.frame.size withImage:image] forState:UIControlStateHighlighted];
                                                                             }
                                                                             else
                                                                             {
                                                                                 [sself setImage:placeholder forState:state];
                                                                                 [sself setImage:placeholder forState:UIControlStateHighlighted];
                                                                             }
                                                                             if (completedBlock && finished)
                                                                             {
                                                                                 completedBlock(image, error, cacheType);
                                                                             }
                                                                         });
                                             }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    
    [self setBackgroundImage:placeholder forState:state];
    
    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                                             {
                                                 if (!wself) return;
                                                 dispatch_main_sync_safe(^
                                                                         {
                                                                             __strong UIButton *sself = wself;
                                                                             if (!sself) return;
                                                                             if (image)
                                                                             {
                                                                                 [sself setBackgroundImage:[self imageByScalingAndCroppingForSize:self.frame.size withImage:image] forState:state];
                                                                                 
                                                                             }
                                                                             if (completedBlock && finished)
                                                                             {
                                                                                 completedBlock(image, error, cacheType);
                                                                             }
                                                                         });
                                             }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
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
