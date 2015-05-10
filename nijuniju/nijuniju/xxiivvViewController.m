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
int lessonId;
int answerPosition;

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
@property (weak, nonatomic) IBOutlet UIView *feedbackView;

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
	activeLesson = [[Lesson alloc] initWithString:@"Japanese"];
	
	[self templateStart];
	[self questionStart];
}

# pragma mark - Start

-(void)questionStart
{
	NSLog(@"! LESSON | Start");
	
	_progressLabel.text = [NSString stringWithFormat:@"%d/%lu",lessonId,(unsigned long)[activeLesson length]];
	
	// Load Mistakes
	NSArray* mistakes = [activeLesson mistakesFromLessonId:lessonId];
	_choice1Label.text = mistakes[0];
	_choice2Label.text = mistakes[1];
	_choice3Label.text = mistakes[2];
	
	// Insert Answer
	NSString* answer = [activeLesson answerFromLessonId:lessonId];
	answerPosition = arc4random_uniform(3);
	if( answerPosition == 0 ){ _choice1Label.text = answer; }
	else if( answerPosition == 1 ){ _choice2Label.text = answer; }
	else { _choice3Label.text = answer; }
}

# pragma mark - Response

-(void)correctChoice
{
	NSLog(@"- ANSWER | Correct answer!");
	lessonId += 1;
	[self questionStart];
	
	// Animate Feedback
	_feedbackView.alpha = 1;
	_feedbackView.backgroundColor = [UIColor whiteColor];
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_feedbackView.alpha = 0;
	} completion:^(BOOL finished){}];
}

-(void)wrongChoice
{
	NSLog(@"- ANSWER | Wrong answer..");
	lessonId -= 1;
	if( lessonId < 1 ){ lessonId = 0; }
	[self questionStart];
	
	// Animate Feedback
	_feedbackView.alpha = 1;
	_feedbackView.backgroundColor = [UIColor redColor];
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_feedbackView.alpha = 0;
	} completion:^(BOOL finished){}];
}

# pragma mark - Template

-(void)templateStart
{
	CGRect screen = [[UIScreen mainScreen] bounds];
	float screenMargin = screen.size.width/8;
	
	_choice1View.frame = CGRectMake(0, screenHeight-(screenMargin*6)-2, screenWidth, screenMargin*2);
	_choice1View.backgroundColor = [UIColor whiteColor];
	_choice1Label.frame = CGRectMake(screenMargin/2, 0, _choice1View.frame.size.width, _choice1View.frame.size.height);
	_choice1Button.frame = CGRectMake(0, 0,_choice1View.frame.size.width, _choice1View.frame.size.height);
	
	_choice2View.frame = CGRectMake(0, screenHeight-(screenMargin*4)-1, screenWidth, screenMargin*2);
	_choice2View.backgroundColor = [UIColor whiteColor];
	_choice2Label.frame = CGRectMake(screenMargin/2, 0, _choice2View.frame.size.width, _choice2View.frame.size.height);
	_choice2Button.frame = CGRectMake(0, 0,_choice2View.frame.size.width, _choice2View.frame.size.height);
	
	_choice3View.frame = CGRectMake(0, screenHeight-(screenMargin*2), screenWidth, screenMargin*2);
	_choice3View.backgroundColor = [UIColor whiteColor];
	_choice3Label.frame = CGRectMake(screenMargin/2, 0, _choice3View.frame.size.width, _choice3View.frame.size.height);
	_choice3Button.frame = CGRectMake(0, 0,_choice3View.frame.size.width, _choice3View.frame.size.height);
	
	_questionLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*9), screenWidth, screenMargin*2);
	_progressLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*7), screenWidth, screenMargin);
	
	_feedbackView.backgroundColor = [UIColor redColor];
	_feedbackView.frame = CGRectMake(0, 0, screenWidth, screenHeight-(7*screenMargin) );
	_feedbackView.alpha = 0;
}


# pragma mark - Audio

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

# pragma mark - Interactions

- (IBAction)choice1Button:(id)sender
{
	if( answerPosition == 0){ [self correctChoice]; }
	else{ [self wrongChoice]; }
}

- (IBAction)choice2Button:(id)sender
{
	if( answerPosition == 1){ [self correctChoice]; }
	else{ [self wrongChoice]; }
}

- (IBAction)choice3Button:(id)sender
{
	if( answerPosition == 2){ [self correctChoice]; }
	else{ [self wrongChoice]; }
}

# pragma mark - Defaults

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
