//
//  RatingViewController.m
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

@synthesize s1, s2, s3, s4, s5;

- (void)dealloc {
	[s1 release];
	[s2 release];
	[s3 release];
	[s4 release];
	[s5 release];
    [super dealloc];
}

-(void)setImagesDeselected:(NSString *)deselectedImage
			partlySelected:(NSString *)halfSelectedImage
			  fullSelected:(NSString *)fullSelectedImage
			   andDelegate:(id<RatingViewDelegate>)d state:(int)number
{
    
    number_Full=number;
    
	unselectedImage = [UIImage imageNamed:deselectedImage];
	partlySelectedImage = halfSelectedImage == nil ? unselectedImage : [UIImage imageNamed:halfSelectedImage];
	fullySelectedImage = [UIImage imageNamed:fullSelectedImage];
	viewDelegate = d;
	
	height=0.0; width= 0.0;
    
	if (height < [fullySelectedImage size].height) {
		height = [fullySelectedImage size].height;
	}
	if (height < [partlySelectedImage size].height) {
		height = [partlySelectedImage size].height;
	}
	if (height < [unselectedImage size].height) {
		height = [unselectedImage size].height;
	}
	if (width < [fullySelectedImage size].width) {
		width = [fullySelectedImage size].width;
	}
	if (width < [partlySelectedImage size].width) {
		width = [partlySelectedImage size].width;
	}
	if (width < [unselectedImage size].width) {
		width = [unselectedImage size].width;
	}
	
	starRating = 0;
	lastRating = 0;
    
   // height-=5;
    
	s1 = [[UIImageView alloc] initWithImage:unselectedImage];
	s2 = [[UIImageView alloc] initWithImage:unselectedImage];
	s3 = [[UIImageView alloc] initWithImage:unselectedImage];
	s4 = [[UIImageView alloc] initWithImage:unselectedImage];
	s5 = [[UIImageView alloc] initWithImage:unselectedImage];
	
	[s1 setFrame:CGRectMake(0,            0, width-10, height-10)];
	[s2 setFrame:CGRectMake(width+10,      0, width-10, height-10)];
	[s3 setFrame:CGRectMake(2 * width+20, 0, width-10, height-10)];
	[s4 setFrame:CGRectMake(3 * width+30, 0, width-10, height-10)];
	[s5 setFrame:CGRectMake(4 * width+40, 0, width-10, height-10)];
	
    width+=5;
  
	[s1 setUserInteractionEnabled:NO];
	[s2 setUserInteractionEnabled:NO];
	[s3 setUserInteractionEnabled:NO];
	[s4 setUserInteractionEnabled:NO];
	[s5 setUserInteractionEnabled:NO];
	
	[self addSubview:s1];
	[self addSubview:s2];
	[self addSubview:s3];
	[self addSubview:s4];
	[self addSubview:s5];
	
	CGRect frame = [self frame];
	frame.size.width = width * 5;
	frame.size.height = height;
	[self setFrame:frame];
    
    
}

-(void)displayRating:(float)rating
{
	[s1 setImage:unselectedImage];
	[s2 setImage:unselectedImage];
	[s3 setImage:unselectedImage];
	[s4 setImage:unselectedImage];
	[s5 setImage:unselectedImage];
	
	
	if (rating >= 1) {
		[s1 setImage:fullySelectedImage];
	}
	
	if (rating >= 2) {
		[s2 setImage:fullySelectedImage];
	}
	
	if (rating >= 3) {
		[s3 setImage:fullySelectedImage];
	}
	
	if (rating >= 4) {
		[s4 setImage:fullySelectedImage];
	}
	
	if (rating >= 5) {
		[s5 setImage:fullySelectedImage];
	}
	
    NSString * string=[NSString stringWithFormat:@"%d",number_Full];
   	starRating = rating;
	lastRating = rating;
	[viewDelegate ratingChanged:rating inid:string];
}

-(void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
	[self touchesMoved:touches withEvent:event];
}

-(void) touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
   
	int newRating = (int) (pt.x / width) + 1;

	if (newRating < 1 || newRating > 5)
		return;
	
	if (newRating != lastRating)
		[self displayRating:newRating];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self touchesMoved:touches withEvent:event];
}

-(float)rating {
	return starRating;
}

@end
