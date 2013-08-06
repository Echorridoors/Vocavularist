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
	
	self.blurTarget.backgroundColor = [UIColor blueColor];
	self.blurTarget.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height-screenMargin);
	self.blurTargetGlyph.frame = CGRectMake(screenMargin, screenMargin, screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
	self.blurTargetGlyph.backgroundColor = [UIColor purpleColor];
	self.blurTargetGlyph.textAlignment = NSTextAlignmentCenter;
	self.blurTargetGlyph.font = [UIFont fontWithName:@"Helvetica Neue" size:128];
	self.blurTargetGlyph.text = @"今";
	
	self.blurTargetPing.frame = CGRectMake(screenMargin, screenMargin, screen.size.width-(2*screenMargin), screen.size.width-(2*screenMargin));
}

- (void) templateInterface
{
	self.interfaceMenu.frame = CGRectMake(0, 0, screen.size.width, screenMargin);
	self.interfaceMenu.backgroundColor = [UIColor redColor];
	
	self.interfaceMenuProgress.frame = CGRectMake(screenMargin/4, 0, screen.size.width/2, screenMargin);
	self.interfaceMenuProgress.text = @"0/10";
	self.interfaceMenuStop.frame = CGRectMake( (screen.size.width-(screenMargin/4))-(screen.size.width/2), 0, screen.size.width/2, screenMargin);
	self.interfaceMenuStop.titleLabel.text = @"Pause";
	
	self.interfaceOptions.frame = CGRectMake(0, (screenMargin*3)+(screen.size.width-(2*screenMargin)), screen.size.width, screen.size.height - ((screenMargin*3)+(screen.size.width-(2*screenMargin))));
	self.interfaceOptions.backgroundColor = [UIColor yellowColor];
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
		button.titleLabel.backgroundColor = [UIColor redColor];
		button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
		[self.interfaceOptions addSubview:button];
		i += 1;
	}
}



@end