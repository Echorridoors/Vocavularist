//
//  xxiivvViewController.m
//  nijuniju
//
//  Created by Devine Lu Linvega on 2013-08-06.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "xxiivvTemplates.h"
#import "xxiivvNodes.h"

@interface xxiivvViewController ()

@end

@implementation xxiivvViewController

- (void)viewDidLoad { [super viewDidLoad]; [self start];}
- (void)didReceiveMemoryWarning{ [super didReceiveMemoryWarning]; }

- (void) start
{
	[self nodeStart];
	
	[self templateStart];
	[self gamePrepare];
	//[self performSelectorInBackground:@selector(captureBlur) withObject:nil];
}


- (void) gamePrepare
{
	NSLog(@"> Phase | Prepare");
	
	self.interfaceMenuTimeRemainingLabel.text = @"Preparing..";
	
	[NSTimer scheduledTimerWithTimeInterval:(0.3) target:self selector:@selector(gameSetup) userInfo:nil repeats:NO];
	
	[self templatePrepareAnimation];
}

-(void) gameSetup
{
	NSLog(@"> Phase | Setup");
	
	userLesson = ((arc4random()%([nodeContentArray count]-1))+1);
	
	[self gameReady];
}

- (void) gameReady
{
	NSLog(@"> Phase | Ready");
	
	self.interfaceMenuTimeRemainingLabel.text = @"Next Kanji Card";

	[self templateReadyAnimation];
}




- (void) gameStart
{
	NSLog(@"> Phase | Start");
	
	self.interfaceMenuTimeRemainingLabel.text = @"3 Seconds Left";
	
	self.blurTargetGlyph.text = nodeContentArray[userLesson][0];
	
	[self templateButtonsGenerate];
	[self templateButtonsAnimationShow];
	[self templateStartAnimation];
	
	timeRemaining = [NSTimer scheduledTimerWithTimeInterval:(3) target:self selector:@selector(gameFinish) userInfo:nil repeats:NO];
}

- (void) gameFinish
{
	NSLog(@"> Phase | Finished");
	
	self.interfaceMenuTimeRemainingLabel.text = @"Finished";
	
	[timeRemaining invalidate];
	timeRemaining = nil;
	
	[self templateButtonsAnimationHide];
	[self templateFinishAnimation];
	
	[self gamePrepare];
}



- (void) gameVerify :(int)input
{
	if( input == [nodeContentArray[userLesson][4] intValue] ){
		self.feedbackColour.backgroundColor = [self colorCyan];
		[self userSaveRecord:userLesson :(3- [[timeRemaining fireDate] timeIntervalSinceNow])];
	}
	else{
		self.feedbackColour.backgroundColor = [self colorRed];
	}
}



- (void) captureBlur {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.blurTarget.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat:10] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    blurrredImage = [[UIImage alloc] initWithCIImage:resultImage];
    
    UIImageView *newView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    newView.image = blurrredImage;
	newView.backgroundColor = [UIColor whiteColor];
	newView.frame = CGRectMake(-30, 0, screen.size.width+60, screen.size.height+60);
    
    [self.blurContainerView insertSubview:newView belowSubview:self.transparentView];
}



- (void) optionSelection :(int)target
{
	NSLog(@"+ Acted | Option: %d",target);
	
	for (UIView *subview in [self.interfaceOptions subviews]) {
		if( subview.tag != target ){
			CGRect origin = subview.frame;
			[UIView beginAnimations: @"Slide In" context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
			[UIView setAnimationDuration:0.25];
			subview.frame = CGRectOffset(origin, 0, 10);
			[UIView commitAnimations];
		}
	}
	
	[self gameVerify:target];
	[self gameFinish];
}




- (void) option0
{
	[self optionSelection:1];
}
- (void) option1
{
	[self optionSelection:2];
}
- (void) option2
{
	[self optionSelection:3];
}


- (UIColor*) colorCyan
{
	return [UIColor colorWithRed:0.2 green:0.9 blue:0.8 alpha:1];
}
- (UIColor*) colorRed
{
	return [UIColor colorWithRed:0.9 green:0.2 blue:0.3 alpha:1];
}
- (UIColor*) colorGrey
{
	return [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1];
}





- (IBAction)interfaceMenuNext:(id)sender {
	[self gameStart];
}








@end
