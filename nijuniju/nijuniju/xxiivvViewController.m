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
	
	userNextType +=1;
	
	if( userNextType % 2){
		NSLog(@"> Tasks | Review");
		userLesson = ((arc4random()%(userProgress))+1);
	}
	else{
		NSLog(@"> Tasks | New");
		userLesson = userProgress;
	}
	
	NSLog(@"> Phase | Progress %d Next Lesson %d", userProgress, userLesson);
	
	
	// userLesson = ((arc4random()%([nodeContentArray count]-1))+1);
	
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
	
	gameElapsing = 0;
	
	timeRemaining = [NSTimer scheduledTimerWithTimeInterval:(3) target:self selector:@selector(gameFinish) userInfo:nil repeats:NO];
	timeElapsing = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(gameTime) userInfo:nil repeats:YES];

}

- (void) gameTime
{
	gameElapsing += 0.1;
	self.interfaceMenuTimeRemainingLabel.text = [NSString stringWithFormat:@"%@ Seconds",[[NSString stringWithFormat:@"%f",gameElapsing] substringWithRange:NSMakeRange(0, 4)]];
	
}

- (void) gameFinish
{
	NSLog(@"> Phase | Finished");
		
	[timeRemaining invalidate];
	timeRemaining = nil;
	[timeElapsing invalidate];
	timeElapsing = nil;
	
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
		
		// Progress if new item
		if( e == 1 && ([nodeContentArray count]-1) > userProgress ){
			userProgress += 1;
			self.interfaceChapterName.text = [NSString stringWithFormat:@"Chapter %d - Kanji 0 to %d",(userProgress/10)+1, ((userProgress/10)+1)*10];
		}
		
		
		
		
				
		average = sum/e;
		
		self.interfaceMenuProgress.text = [NSString stringWithFormat:@"%@s average %d kanjis", [[NSString stringWithFormat:@"%f", averageSum/i] substringWithRange:NSMakeRange(0, 4)],i];
		
		// Display the score in colours
		
		if( score > 2.5 ){ self.feedbackColour.backgroundColor = [self colorWorse]; }
		else if( score > 1.5 ){ self.feedbackColour.backgroundColor = [self colorAverage]; }
		else if( score > average ){ self.feedbackColour.backgroundColor = [self colorBetter]; }
		else { self.feedbackColour.backgroundColor = [self colorGood]; }
		
		// Write time
		self.interfaceMenuTimeRemainingLabel.text = [NSString stringWithFormat:@"%@ Seconds", [[NSString stringWithFormat:@"%f", score] substringWithRange:NSMakeRange(0, 4)]];
	}
	else{
		self.feedbackColour.backgroundColor = [self colorBad];
		self.blurTarget.alpha = 0;
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


- (UIColor*) colorGood
{
	return [UIColor colorWithWhite:0.7 alpha:1];
}
- (UIColor*) colorBad
{
	return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
}
- (UIColor*) colorAverage
{
	return [UIColor colorWithWhite:0.5 alpha:1];
}
- (UIColor*) colorWorse
{
	return [UIColor colorWithWhite:0.3 alpha:1];
}
- (UIColor*) colorBetter
{
	return [UIColor colorWithWhite:0.9 alpha:1];
}



- (IBAction)interfaceMenuNext:(id)sender {
	[self gameStart];
}



- (IBAction)InterfaceMenuReset:(id)sender {
	[self userReset];
}





@end
