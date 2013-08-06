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
	[self templateButtons];
	
	
	self.transparentView.frame = screen;
	self.blurContainerView.frame = screen;
	
	
	CAGradientLayer *bgLayer = [self greyGradient];
	bgLayer.frame = CGRectMake(0, 0, screen.size.width, 200);
	[self.blurTarget.layer insertSublayer:bgLayer atIndex:0];
	
	
	
	self.blurTarget.backgroundColor = [UIColor whiteColor];
	
	self.blurTarget.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height-screenMargin);
	self.blurTargetGlyph.frame = CGRectMake(screenMargin, screenMargin, screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
	self.blurTargetGlyph.textAlignment = NSTextAlignmentCenter;
	self.blurTargetGlyph.font = [UIFont fontWithName:@"Helvetica Neue" size:128];
	self.blurTargetGlyph.text = @"今";
	
	self.blurTargetPing.frame = CGRectMake(10,400,100,100);
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
	
	self.interfaceOptions.frame = CGRectMake(0, (screenMargin*3)+(screen.size.width-(2*screenMargin)), screen.size.width, screen.size.height - ((screenMargin*3)+(screen.size.width-(2*screenMargin))));

}




- (void) templateButtons
{
	int i = 0;
	while(i < 4){
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"option%d",i]) forControlEvents:UIControlEventTouchDown];
		button.tag = 10;
		button.frame = CGRectMake(i*((screen.size.width/3)+1), 0, screen.size.width/3, self.interfaceOptions.frame.size.height-screenMargin);
		button.backgroundColor = [UIColor greenColor];
		[button setTitle: [NSString stringWithFormat:@"Value%d",i] forState: UIControlStateNormal];
		button.titleLabel.frame = CGRectMake(0, 0, 100, 100);
		[button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
		
		CALayer *leftBorder = [CALayer layer];
		leftBorder.frame = CGRectMake(0, 0, 1, screenMargin*2);
		leftBorder.backgroundColor = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0].CGColor;
		[button.layer addSublayer:leftBorder];
		CALayer *rightBorder = [CALayer layer];
		rightBorder.frame = CGRectMake((screen.size.width/3)-1, 0, 1, screenMargin*2);
		rightBorder.backgroundColor = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0].CGColor;
		[button.layer addSublayer:rightBorder];
		
		CAGradientLayer *bgLayer = [self greyGradient];
		bgLayer.frame = button.bounds;
		[button.layer insertSublayer:bgLayer atIndex:0];
		
		
		[self.interfaceOptions addSubview:button];
		i += 1;
	}
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