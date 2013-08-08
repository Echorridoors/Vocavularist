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
	self.blurTargetGlyph.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.width-(2*screenMargin));
	self.blurTargetGlyph.textAlignment = NSTextAlignmentCenter;
	self.blurTargetGlyph.font = [UIFont fontWithName:@"Helvetica Neue" size:152];
	self.blurTargetGlyph.font = [UIFont boldSystemFontOfSize:152.0f];
	self.blurTargetGlyph.text = @"二十";
	
	self.blurTargetPing.frame = CGRectMake(10,400,100,100);
	self.blurTargetPing.hidden = YES;
	
	self.feedbackColour.frame = screen;
	
	
	
	self.blurTarget.hidden = NO;
	self.blurContainerView.hidden = YES;
	
	
	self.interfaceChapter.frame = CGRectMake(screenMargin/4, screenMargin, screen.size.width, screenMargin);
	
	self.interfaceChapterName.frame = CGRectMake(0, 0, screen.size.width, screenMargin);
	self.interfaceChapterName.textAlignment = NSTextAlignmentLeft;
	self.interfaceChapterName.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceChapterName.font = [UIFont boldSystemFontOfSize:12.0f];
	self.interfaceChapterName.textColor = [UIColor colorWithWhite:0 alpha:0.2];
	self.interfaceChapterName.text = @"New Game";
	self.interfaceChapterName.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	self.interfaceChapter.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	
	self.interfaceMenuTimeAverage.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8.35, (screenMargin/4), (screenMargin/4) );
	self.interfaceMenuTimeAverage.image = [UIImage imageNamed:@"icn.arrow.png"];
	
	
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
	self.interfaceMenuProgress.text = @"Chapter 1 - Kanji 0 to 10";
	self.interfaceMenuProgress.textColor = [UIColor colorWithWhite:0.5 alpha:1];
	self.interfaceMenuProgress.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.interfaceMenuProgress.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.interfaceMenuProgress.layer.shadowOpacity = 1.0f;
	self.interfaceMenuProgress.layer.shadowRadius = 0;
	self.interfaceMenuProgress.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceMenuProgress.font = [UIFont boldSystemFontOfSize:12.0f];
	
	self.InterfaceMenuReset.frame = CGRectMake( screen.size.width-(self.InterfaceMenuReset.titleLabel.frame.size.width*2)-(screenMargin/4), (screenMargin/4)/2, self.InterfaceMenuReset.titleLabel.frame.size.width*2, (screenMargin-2)-(screenMargin/4));
	self.InterfaceMenuReset.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.InterfaceMenuReset.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	[self.InterfaceMenuReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.InterfaceMenuReset.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
	[self.InterfaceMenuReset setTitle:@"Start Over" forState:UIControlStateNormal];
	self.InterfaceMenuReset.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
	self.InterfaceMenuReset.layer.cornerRadius = 4; // this value vary as per your desire
    self.InterfaceMenuReset.clipsToBounds = YES;
	self.InterfaceMenuReset.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.InterfaceMenuReset.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.InterfaceMenuReset.layer.shadowOpacity = 1.0f;
	self.InterfaceMenuReset.layer.shadowRadius = 0;
	CALayer *gradient = [CALayer layer];
	gradient.frame = CGRectMake(0, 0, self.InterfaceMenuReset.frame.size.width, self.InterfaceMenuReset.frame.size.height/2);
	gradient.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
	[self.InterfaceMenuReset.layer addSublayer:gradient];
	
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
	
	self.interfaceMenuTimeRemainingLabel.frame = CGRectMake(screenMargin, screenMargin*6.5, screen.size.width- (2*screenMargin), screenMargin*2);
	
	self.interfaceMenuNext.frame = CGRectMake(screenMargin/2, screenMargin*6.9, screen.size.width- (2*(screenMargin/2)), screenMargin*2);
	self.interfaceMenuNext.layer.cornerRadius = (screenMargin/4)/2;
	self.interfaceMenuNext.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
}




- (void) templateButtonsGenerate
{
	for (UIView *subview in [self.interfaceOptions subviews]) {
		[subview removeFromSuperview];
	}
	int i = 0;
	while(i < 3){
		
		NSArray* answerForm = [nodeContentArray[userLesson][i+1] componentsSeparatedByString: @"|"];
		
		NSString *hiraganaForm = [answerForm objectAtIndex: 1];
		NSString *englishForm = [answerForm objectAtIndex: 0];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"option%d",i]) forControlEvents:UIControlEventTouchDown];
		button.tag = i+1;
		button.frame = CGRectMake(i*((screen.size.width/3)+1), screenMargin/2, screen.size.width/3, self.interfaceOptions.frame.size.height-screenMargin);
		button.backgroundColor = [UIColor whiteColor];
		[button setTitle: [NSString stringWithFormat:englishForm] forState: UIControlStateNormal];
		button.titleLabel.frame = CGRectMake(0, 0, 100, 100);
		[button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
		button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		
		UILabel *hiragana = [[UILabel alloc] initWithFrame:CGRectMake(0, (button.frame.size.height/3)*1.7, button.frame.size.width, button.frame.size.height/3)];
		hiragana.text = [NSString stringWithFormat:hiraganaForm];
		hiragana.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
		hiragana.textAlignment = NSTextAlignmentCenter;
		hiragana.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
		[button addSubview:hiragana];
		
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


- (void) templatePrepareAnimation
{
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3];
	self.interfaceChapter.alpha = 1;
	self.interfaceMenuTimeBar.alpha = 1;
	self.interfaceMenuTimeRemainingLabel.alpha = 1;
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, screen.size.width-(2*screenMargin)-(2*(screenMargin/4)), (screenMargin/4) );
	[UIView commitAnimations];
}

- (void) templateReadyAnimation
{
	[self fadeIn:self.interfaceMenuNext d:0 t:0.5];
}

- (void) templateStartAnimation
{
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.blurTarget.alpha = 1;
	[UIView commitAnimations];
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, (screenMargin/4), (screenMargin/4) );
	self.blurContainerView.alpha = 0.5;
	[UIView commitAnimations];
	
	
	// move label up
	
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuNext.alpha = 0;
	self.interfaceChapter.alpha = 0;
	self.interfaceMenuTimeRemainingLabel.frame = CGRectMake(screenMargin, screenMargin*6.5, screen.size.width- (2*screenMargin), screenMargin*2);
	[UIView commitAnimations];
}


- (void) templateFinishAnimation
{
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.blurTarget.alpha = 0;
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


- (void)fadeIn:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration
{
	[UIView beginAnimations: @"Fade In" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 1;
	[UIView commitAnimations];
}

- (void)fadeOut:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration
{
	[UIView beginAnimations: @"Fade Out" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 0;
	[UIView commitAnimations];
}




@end