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
	[self userStart];
	
	[self templateStart];
	[self gamePrepare];
	//[self performSelectorInBackground:@selector(captureBlur) withObject:nil];
}


- (void) gamePrepare
{
	NSLog(@"> Phase | Prepare");
	
//	self.interfaceMenuTimeRemainingLabel.text = @"Preparing..";
	
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
	
//	self.interfaceMenuTimeRemainingLabel.text = @"Finished";
	
	[timeRemaining invalidate];
	timeRemaining = nil;
	
	[self templateButtonsAnimationHide];
	[self templateFinishAnimation];
	
	[self gamePrepare];
}



- (void) gameVerify :(int)input
{
	if( input == [nodeContentArray[userLesson][4] intValue] ){
		
		float score = (3- [[timeRemaining fireDate] timeIntervalSinceNow]);
		
		// Save
		[self userSaveRecord:userLesson :score];
		
		// Get average
		float sum = 0.0;
		float average = 0.0;
		float averageSum = 0.0;
		int i = 0;
		float e = 0;
		while( i < [userContentRecords count] ){
			if( [userContentRecords[i][0] intValue] == userLesson ){
				e+=1;
				sum += [userContentRecords[i][1] floatValue];
			}
			averageSum += [userContentRecords[i][1] floatValue];
			i+=1;
		}
		
		average = sum/e;
		
		self.interfaceMenuProgress.text = [NSString stringWithFormat:@"%@ seconds %d kanjis", [[NSString stringWithFormat:@"%f", averageSum/i] substringWithRange:NSMakeRange(0, 4)],i];
		
		// Display the score in colours
		
		if( score > 2.5 ){ self.feedbackColour.backgroundColor = [self colorOrange]; }
		else if( score > 1.5 ){ self.feedbackColour.backgroundColor = [self colorYellow]; }
		else{ self.feedbackColour.backgroundColor = [self colorCyan]; }
		if( e > 2 && score < average ){ self.feedbackColour.backgroundColor = [self colorBlue]; }
		
		// Write time
		self.interfaceMenuTimeRemainingLabel.text = [NSString stringWithFormat:@"%@ Seconds", [[NSString stringWithFormat:@"%f", score] substringWithRange:NSMakeRange(0, 4)]];
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
- (UIColor*) colorYellow
{
	return [UIColor colorWithRed:0.9 green:0.9 blue:0.1 alpha:1];
}
- (UIColor*) colorBlue
{
	return [UIColor colorWithRed:0.8 green:0.6 blue:1.0 alpha:1];
}
- (UIColor*) colorOrange
{
	return [UIColor colorWithRed:0.9 green:0.5 blue:0.0 alpha:1];
}





- (IBAction)interfaceMenuNext:(id)sender {
	[self gameStart];
}








@end
