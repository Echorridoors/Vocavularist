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

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "Lesson.h"

AVAudioPlayer *audioPlayerSounds;
Lesson *activeLesson;

@interface xxiivvViewController ()

@property (weak, nonatomic) IBOutlet UIButton *choice1Button;
@property (weak, nonatomic) IBOutlet UIButton *choice2Button;
@property (weak, nonatomic) IBOutlet UIButton *choice3Button;
@property (weak, nonatomic) IBOutlet UIView *choice1View;
@property (weak, nonatomic) IBOutlet UIView *choice2View;
@property (weak, nonatomic) IBOutlet UIView *choice3View;
@property (weak, nonatomic) IBOutlet UILabel *choice1Label;
@property (weak, nonatomic) IBOutlet UILabel *choice2Label;
@property (weak, nonatomic) IBOutlet UILabel *choice3Label;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation xxiivvViewController

-(void)viewDidLoad{
	
	[super viewDidLoad];
	[self start];
}

-(void)didReceiveMemoryWarning{
	
	[super didReceiveMemoryWarning];
}

-(void)start
{
	[self templateStart];
	[self startLesson:@"Japanese"];
	
}

-(void)startLesson:(NSString*)targetLanguage
{
	NSLog(@"! LESSON | Start");
	activeLesson = [[Lesson alloc] initWithString:targetLanguage];
}


-(void)templateStart
{
	CGRect screen = [[UIScreen mainScreen] bounds];
	float screenMargin = screen.size.width/8;
	
	_choice1View.frame = CGRectMake(0, screenHeight-(screenMargin*6)-2, screenWidth, screenMargin*2);
	_choice1View.backgroundColor = [UIColor whiteColor];
	_choice1Label.frame = CGRectMake(screenMargin/2, 0, _choice1View.frame.size.width, _choice1View.frame.size.height);
	
	_choice2View.frame = CGRectMake(0, screenHeight-(screenMargin*4)-1, screenWidth, screenMargin*2);
	_choice2View.backgroundColor = [UIColor whiteColor];
	_choice2Label.frame = CGRectMake(screenMargin/2, 0, _choice2View.frame.size.width, _choice2View.frame.size.height);
	
	_choice3View.frame = CGRectMake(0, screenHeight-(screenMargin*2), screenWidth, screenMargin*2);
	_choice3View.backgroundColor = [UIColor whiteColor];
	_choice3Label.frame = CGRectMake(screenMargin/2, 0, _choice3View.frame.size.width, _choice3View.frame.size.height);
	
	_questionLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*9), screenWidth, screenMargin*2);
	_progressLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*7), screenWidth, screenMargin);
}

-(void)audioPlayerSounds:(NSString *)filename{
	
	NSLog(@"$ Audio | Play %@",filename);
	
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	resourcePath = [resourcePath stringByAppendingString: [NSString stringWithFormat:@"/%@", filename] ];
	NSError* err;
	audioPlayerSounds = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
	
	audioPlayerSounds.volume = 1.0;
	
	audioPlayerSounds.numberOfLoops = 0;
	audioPlayerSounds.currentTime = 0;
	
	if(err)	{ NSLog(@"%@",err); }
	else	{
		[audioPlayerSounds prepareToPlay];
		[audioPlayerSounds play];
	}
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
