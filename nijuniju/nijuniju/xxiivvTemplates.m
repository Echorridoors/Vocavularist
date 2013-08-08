//
//  xxiivvViewController.m
//  nijuniju
//
//  Created by Devine Lu Linvega on 2013-08-06.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation xxiivvViewController (Modules)


- (void) templateStart
{
	screen = [[UIScreen mainScreen] bounds];
	screenMargin = screen.size.width/8;
	
	[self templateInterface];
	
	self.transparentView.frame = screen;
	self.blurContainerView.frame = screen;
	self.blurContainerView.hidden = NO;
	self.blurContainerView.alpha = 0.5;
	
	CAGradientLayer *bgLayer = [self greyGradient];
	bgLayer.frame = screen;
	[self.blurTarget.layer insertSublayer:bgLayer atIndex:0];
	
	self.blurTarget.backgroundColor = [UIColor whiteColor];
	
	self.blurTarget.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height-screenMargin);
	self.blurTargetGlyph.frame = CGRectMake(screenMargin, screenMargin, screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
	self.blurTargetGlyph.textAlignment = NSTextAlignmentCenter;
	self.blurTargetGlyph.font = [UIFont fontWithName:@"Helvetica Neue" size:152];
	self.blurTargetGlyph.text = @"今";
	
	self.blurTargetPing.frame = CGRectMake(10,400,100,100);
	
	self.feedbackColour.frame = screen;
}

- (void) templateInterface
{
	self.interfaceMenu.frame = CGRectMake(0, 0, screen.size.width, screenMargin);
	
	CAGradientLayer *bgLayer = [self darkGradient];
	bgLayer.frame = self.interfaceMenu.frame;
	[self.interfaceMenu.layer insertSublayer:bgLayer atIndex:0];
	
	CALayer *bottomBorder = [CALayer layer];bottomBorder.frame = CGRectMake(0, screenMargin-1, screen.size.width, 1);bottomBorder.backgroundColor = [UIColor colorWithWhite:0 alpha:1].CGColor;[self.interfaceMenu.layer addSublayer:bottomBorder];
	CALayer *bottomBorder2 = [CALayer layer];bottomBorder2.frame = CGRectMake(0, screenMargin-2, screen.size.width, 1);bottomBorder2.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;[self.interfaceMenu.layer addSublayer:bottomBorder2];
	
	self.interfaceMenuProgress.frame = CGRectMake(screenMargin/4, 0, screen.size.width/2, screenMargin-2);
	self.interfaceMenuProgress.text = @"Average Speed: 10.2";
	self.interfaceMenuProgress.textColor = [UIColor colorWithWhite:0.5 alpha:1];
	self.interfaceMenuProgress.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.interfaceMenuProgress.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.interfaceMenuProgress.layer.shadowOpacity = 1.0f;
	self.interfaceMenuProgress.layer.shadowRadius = 0;
	self.interfaceMenuProgress.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceMenuProgress.font = [UIFont boldSystemFontOfSize:12.0f];
	
	self.interfaceMenuStop.frame = CGRectMake( screen.size.width-(self.interfaceMenuStop.titleLabel.frame.size.width)-(screenMargin/4), (screenMargin/4)/2, self.interfaceMenuStop.titleLabel.frame.size.width, (screenMargin-2)-(screenMargin/4));
	self.interfaceMenuStop.titleLabel.text = @"Pause";
	self.interfaceMenuStop.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuStop.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	[self.interfaceMenuStop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.interfaceMenuStop.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
	[self.interfaceMenuStop setTitle:@"Pause" forState:UIControlStateNormal];
	self.interfaceMenuStop.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
	self.interfaceMenuStop.layer.cornerRadius = 4; // this value vary as per your desire
    self.interfaceMenuStop.clipsToBounds = YES;
	self.interfaceMenuStop.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.interfaceMenuStop.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.interfaceMenuStop.layer.shadowOpacity = 1.0f;
	self.interfaceMenuStop.layer.shadowRadius = 0;
	CALayer *gradient = [CALayer layer];
	gradient.frame = CGRectMake(0, 0, self.interfaceMenuStop.frame.size.width, self.interfaceMenuStop.frame.size.height/2);
	gradient.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
	[self.interfaceMenuStop.layer addSublayer:gradient];
	
	self.interfaceOptions.frame = CGRectMake(0, (screenMargin*3)+(screen.size.width-(2*screenMargin)), screen.size.width, screen.size.height - ((screenMargin*3)+(screen.size.width-(2*screenMargin))));
	
	self.interfaceMenuTimeBar.alpha = 0;
	self.interfaceMenuTimeBar.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, screen.size.width-(2*screenMargin)-(2*(screenMargin/4)), (screenMargin/4) );
	self.interfaceMenuTimeBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
	self.interfaceMenuTimeBar.layer.cornerRadius = (screenMargin/4)/2;
	
	self.interfaceMenuTimeRemaining.alpha = 0;
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, (screenMargin/4), (screenMargin/4) );
	self.interfaceMenuTimeRemaining.backgroundColor = [UIColor whiteColor];
	self.interfaceMenuTimeRemaining.layer.cornerRadius = (screenMargin/4)/2;
	
	self.interfaceHint.frame = screen;
	self.interfaceHint.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	
	self.interfaceMenuTimeRemainingLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceMenuTimeRemainingLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuTimeRemainingLabel.textColor = [UIColor whiteColor];
	self.interfaceMenuTimeRemainingLabel.font = [UIFont boldSystemFontOfSize:14.0f];
	self.interfaceMenuTimeRemainingLabel.text = @"3 seconds left";
	self.interfaceMenuTimeRemainingLabel.alpha = 0;
	
	self.interfaceMenuTimeRemainingLabel.frame = CGRectMake(screenMargin, screenMargin*7, screen.size.width- (2*screenMargin), screenMargin*2);
	
	self.interfaceMenuNext.frame = CGRectMake(screenMargin/2, screenMargin*6.9, screen.size.width- (2*(screenMargin/2)), screenMargin*2);
	self.interfaceMenuNext.layer.cornerRadius = (screenMargin/4)/2;
	self.interfaceMenuNext.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
}




- (void) templateButtons
{
	for (UIView *subview in [self.interfaceOptions subviews]) {
		[subview removeFromSuperview];
	}
	int i = 0;
	while(i < 4){
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"option%d",i]) forControlEvents:UIControlEventTouchDown];
		button.tag = i+1;
		button.frame = CGRectMake(i*((screen.size.width/3)+1), screenMargin/2, screen.size.width/3, self.interfaceOptions.frame.size.height-screenMargin);
		button.backgroundColor = [UIColor whiteColor];
		[button setTitle: [NSString stringWithFormat:@"Value %d",i] forState: UIControlStateNormal];
		button.titleLabel.frame = CGRectMake(0, 0, 100, 100);
		[button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
		button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		[self.interfaceOptions addSubview:button];
		i += 1;
	}
}

- (void) templateButtonsAnimationShow
{
	int i = 3;
	for (UIView *subview in [self.interfaceOptions subviews]) {
		CGRect origin = subview.frame;
		subview.frame = CGRectOffset(origin, 0, 100);
		[UIView beginAnimations: @"Slide In" context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationDelay:(i*0.1)];
		subview.frame = origin;
		[UIView commitAnimations];
		i += 1;
	}
	
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.interfaceMenuTimeRemaining.alpha = 1;
	[UIView commitAnimations];
	
}

- (void) templateButtonsAnimationHide
{
	int i = 3;
	for (UIView *subview in [self.interfaceOptions subviews]) {
		CGRect origin = subview.frame;
		[UIView beginAnimations: @"Slide In" context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationDelay:(i*0.1)];
		subview.frame = CGRectOffset(origin, 0, 100);
		[UIView commitAnimations];
		i += 1;
	}
	
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.interfaceMenuTimeRemaining.alpha = 1;
	[UIView commitAnimations];
	
}


- (void) templateHintsAnimation
{
//	CGRect origin = self.interfaceMenuTimeRemainingLabel.frame;
//	self.interfaceMenuTimeRemainingLabel.frame = CGRectOffset(origin, 0, 5);
	self.interfaceMenuTimeRemainingLabel.alpha = 1;
	
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3];
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, screen.size.width-(2*screenMargin)-(2*(screenMargin/4)), (screenMargin/4) );
	self.interfaceMenuTimeBar.alpha = 1;
	self.interfaceMenuTimeRemainingLabel.alpha = 1;
//	self.interfaceMenuTimeRemainingLabel.frame = origin;
	[UIView commitAnimations];
}




- (CAGradientLayer*) greyGradient {
	
    UIColor *colorOne	= [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo	= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
	
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, nil];
	
    NSNumber *stopOne	= [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo	= [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.99];
	
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
	
    return headerLayer;
	
}



- (CAGradientLayer*) cyanGradient {
	
    UIColor *colorOne	= [UIColor colorWithRed:0.1 green:0 blue:0 alpha:1];
    UIColor *colorTwo	= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
	
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, nil];
	
    NSNumber *stopOne	= [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo	= [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.99];
	
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
	
    return headerLayer;
	
}


- (CAGradientLayer*) darkGradient {
	
    UIColor *colorOne	= [UIColor colorWithRed:0.1 green:0 blue:0 alpha:1];
    UIColor *colorTwo	= [UIColor colorWithWhite:0.25 alpha:1];
    UIColor *colorThree = [UIColor colorWithWhite:0.15 alpha:1];
	
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, nil];
	
    NSNumber *stopOne	= [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo	= [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.7];
	
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
	
    return headerLayer;

	
}





@end