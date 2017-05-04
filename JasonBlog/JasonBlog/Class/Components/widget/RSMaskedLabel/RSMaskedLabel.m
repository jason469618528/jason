//
//  RSMaskedLabel.m
//  JasonBlog
//
//  Created by huangjian on 17/4/28.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "RSMaskedLabel.h"

@interface RSMaskedLabel()
- (void) RS_commonInit;
- (void) RS_drawBackgroundInRect:(CGRect)rect;
    @end

@implementation RSMaskedLabel
    {
        UIColor* maskedBackgroundColor;
    }
    
- (id)initWithFrame:(CGRect)frame
    {
        if ((self = [super initWithFrame:frame]))
        [self RS_commonInit];
        return self;
    }
    
- (id)initWithCoder:(NSCoder *)aDecoder
    {
        if ((self = [super initWithCoder:aDecoder]))
        [self RS_commonInit];
        return self;
    }
    
- (UIColor*) backgroundColor
    {
        return maskedBackgroundColor;
    }
    
- (void) setBackgroundColor:(UIColor *)backgroundColor
    {
        maskedBackgroundColor = backgroundColor;
        [self setNeedsDisplay];
    }
    
- (void)RS_commonInit
    {
        maskedBackgroundColor = [super backgroundColor];
        [super setTextColor:[UIColor whiteColor]];
        [super setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
    }
    
- (void)setTextColor:(UIColor *)textColor
    {
        // text color needs to be white for masking to work
    }
    
- (void)drawRect:(CGRect)rect
    {
        // Render into a temporary bitmap context at a max of 8 bits per component for subsequent CGImageMaskCreate operations
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        
        [super drawRect:rect];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGImageRef image = CGBitmapContextCreateImage(context);
        UIGraphicsEndImageContext();
        
        // Revert to normal graphics context for the rest of the rendering
        context = UIGraphicsGetCurrentContext();
        
        CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)));
        
        // create a mask from the normally rendered text
        CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(image), CGImageGetHeight(image), CGImageGetBitsPerComponent(image), CGImageGetBitsPerPixel(image), CGImageGetBytesPerRow(image), CGImageGetDataProvider(image), CGImageGetDecode(image), CGImageGetShouldInterpolate(image));
        
        CFRelease(image); image = NULL;
        
        // wipe the slate clean
        CGContextClearRect(context, rect);
        
        CGContextSaveGState(context);
        CGContextClipToMask(context, rect, mask);
        
        if (self.layer.cornerRadius != 0.0f) {
            CGPathRef path = CGPathCreateWithRoundedRect(rect, self.layer.cornerRadius, self.layer.cornerRadius, nil);
            CGContextAddPath(context, path);
            CGContextClip(context);
            CGPathRelease(path);
        }
        
        CFRelease(mask); mask = NULL;
        
        [self RS_drawBackgroundInRect:rect];
        
        CGContextRestoreGState(context);
    }
    
- (void)RS_drawBackgroundInRect:(CGRect)rect
    {
        // this is where you do whatever fancy drawing you want to do!
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [maskedBackgroundColor set];
        CGContextFillRect(context, rect);
    }


@end
