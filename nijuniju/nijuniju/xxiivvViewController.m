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

@interface xxiivvViewController ()

@end

@implementation xxiivvViewController

- (void)viewDidLoad { [super viewDidLoad]; [self start];}
- (void)didReceiveMemoryWarning{ [super didReceiveMemoryWarning]; }

- (void) start
{
	[self templateStart];
	[self gamePrepare];
	//[self performSelectorInBackground:@selector(captureBlur) withObject:nil];
}


- (void) gamePrepare
{
	self.blurTarget.hidden = YES;
	self.view.backgroundColor = [UIColor redColor];
	[NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(gameReady) userInfo:nil repeats:NO];
	self.interfaceMenuTimeRemainingLabel.text = @"Preparing..";
}

- (void) gameReady
{
	[self templateButtons];
	[NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(gameStart) userInfo:nil repeats:NO];
	self.interfaceMenuTimeRemainingLabel.text = @"Ready";
	[self templateButtonsAnimation];
	[self templateHintsAnimation];
}

-(void) gameStart
{
	self.interfaceMenuTimeRemainingLabel.text = @"3 Seconds Left";
	self.view.backgroundColor = [UIColor blueColor];
	NSLog(@"POW !");
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
	newView.frame = CGRectMake(-30, -20, screen.size.width+60, screen.size.height+60);
    
    [self.blurContainerView insertSubview:newView belowSubview:self.transparentView];
}


- (void) option0
{
	NSLog(@"!!1");
}
- (void) option1
{
	NSLog(@"!!2");
}
- (void) option2
{
	NSLog(@"!!3");
}






@end
