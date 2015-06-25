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
int lessonRecord;
int answerPosition;

lessonMode currentMode = kanjiKana;

CGRect choice1Frame;
CGRect choice2Frame;
CGRect choice3Frame;

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
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (weak, nonatomic) IBOutlet UIButton *languageToggleButton;

@end

@implementation xxiivvViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	[self start:russian];
}

-(void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

-(void)start:(lessonMode)newMode
{
	currentMode = newMode;
	activeLesson = [[Lesson alloc] initWithLessonMode:newMode];
	
	[self templateStart];
	[self questionStart];
}

# pragma mark - Start

-(void)questionStart
{
	NSLog(@"! LESSON | Start");
	
	_progressLabel.text = [NSString stringWithFormat:@"%d/%lu",lessonId,(unsigned long)[activeLesson length]];
	_questionLabel.text = [NSString stringWithFormat:@"%@",[activeLesson question:lessonId]];
	
	if( currentMode == kanjiKana ){ [_languageToggleButton setTitle:@"日本語" forState:UIControlStateNormal]; }
	else if( currentMode == russian ){ [_languageToggleButton setTitle:@"РУССКИЙ" forState:UIControlStateNormal]; }
    else if( currentMode == korean ) { [_languageToggleButton setTitle:@"한국어" forState:UIControlStateNormal]; }
	else{ [_languageToggleButton setTitle:@"---" forState:UIControlStateNormal]; }
	
	// Notification
	if( lessonId == lessonRecord ){ _notificationLabel.text = @"New Word"; }
	else{ _notificationLabel.text = @"Review"; }
	_notificationLabel.alpha = 1;
	[UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_notificationLabel.alpha = 0;
	} completion:^(BOOL finished){ }];
	
	// Load Mistakes
	NSString* answer = [activeLesson answerFromLessonId:lessonId:currentMode];
	NSArray* mistakes = [activeLesson mistakesFromLessonId:lessonId:currentMode];
	
	// Reload if twice the same mistakes, or if mistake is equal to answer
	if( [mistakes indexOfObject:answer] > -1 ){ mistakes = [activeLesson mistakesFromLessonId:lessonId:currentMode]; }
	
	_choice1Label.text = mistakes[0];
	_choice2Label.text = mistakes[1];
	_choice3Label.text = mistakes[2];
	
	// Insert Answer
	answerPosition = arc4random_uniform(3);
	if( answerPosition == 0 ){ _choice1Label.text = answer; }
	else if( answerPosition == 1 ){ _choice2Label.text = answer; }
	else { _choice3Label.text = answer; }
}

# pragma mark - Response

-(void)correctChoice
{
	NSLog(@"- ANSWER | Correct answer!");
	
	[self audioPlayerSounds:@"fx.correct.wav"];
	
	lessonId += 1;
	if( lessonId > lessonRecord ){ lessonRecord = lessonId; }
	
	// Animate Feedback
	_feedbackView.alpha = 1;
	_feedbackView.backgroundColor = [UIColor whiteColor];
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_feedbackView.alpha = 0;
	} completion:^(BOOL finished){ }];
}

-(void)wrongChoice
{
	NSLog(@"- ANSWER | Wrong answer..");
	
	[self audioPlayerSounds:@"fx.mistake.wav"];
	
	lessonId -= 2;
	if( lessonId < 1 ){ lessonId = 0; }
	
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
	
	self.view.backgroundColor = UIColorFromRGB(0xDDDDDD);
	
	choice1Frame = CGRectMake(0, screenHeight-(screenMargin*6)-2, screenWidth, screenMargin*2);
	_choice1View.frame = choice1Frame;
	_choice1View.backgroundColor = [UIColor whiteColor];
	_choice1Label.frame = CGRectMake(screenMargin/2, 0, _choice1View.frame.size.width, _choice1View.frame.size.height);
	_choice1Button.frame = CGRectMake(0, 0,_choice1View.frame.size.width, _choice1View.frame.size.height);
	
	choice2Frame = CGRectMake(0, screenHeight-(screenMargin*4)-1, screenWidth, screenMargin*2);
	_choice2View.frame = choice2Frame;
	_choice2View.backgroundColor = [UIColor whiteColor];
	_choice2Label.frame = CGRectMake(screenMargin/2, 0, _choice2View.frame.size.width, _choice2View.frame.size.height);
	_choice2Button.frame = CGRectMake(0, 0,_choice2View.frame.size.width, _choice2View.frame.size.height);
	
	choice3Frame = CGRectMake(0, screenHeight-(screenMargin*2), screenWidth, screenMargin*2);
	_choice3View.frame = choice3Frame;
	_choice3View.backgroundColor = [UIColor whiteColor];
	_choice3Label.frame = CGRectMake(screenMargin/2, 0, _choice3View.frame.size.width, _choice3View.frame.size.height);
	_choice3Button.frame = CGRectMake(0, 0,_choice3View.frame.size.width, _choice3View.frame.size.height);
	
	_questionLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*9), screenWidth, screenMargin*2);
	_progressLabel.frame = CGRectMake(screenMargin/2, screenHeight-(screenMargin*7), screenWidth, screenMargin);
	_notificationLabel.frame = CGRectMake(screenMargin/2 + (screenMargin*2), screenHeight-(screenMargin*7), screenWidth, screenMargin);
	_languageToggleButton.frame = CGRectMake( screen.size.width-(screenMargin*4.5), screenHeight-(screenMargin*7), screenMargin*4, screenMargin);
	
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

-(void)lessonComplete
{
	_progressLabel.text = @"500/500";
	_questionLabel.text = @"Complete";
	[self audioPlayerSounds:@"fx.completed.wav"];
	
	
	self.view.backgroundColor = UIColorFromRGB(0x72DEC2);
}

-(void)displayChoices
{
	if( lessonId == 500 ){
		[self lessonComplete];
		return;
	}
	
	[self questionStart];
	
	_choice1View.frame = CGRectOffset(choice1Frame, screenWidth * -1, 0);
	_choice2View.frame = CGRectOffset(choice2Frame, screenWidth * -1, 0);
	_choice3View.frame = CGRectOffset(choice3Frame, screenWidth * -1, 0);
	_choice1View.alpha = 1;
	_choice2View.alpha = 1;
	_choice3View.alpha = 1;
	
	[UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_choice1View.frame = choice1Frame;
	} completion:^(BOOL finished){ [self audioPlayerSounds:@"fx.click.wav"]; }];
	[UIView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_choice2View.frame = choice2Frame;
	} completion:^(BOOL finished){ [self audioPlayerSounds:@"fx.click.wav"]; }];
	[UIView animateWithDuration:0.15 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_choice3View.frame = choice3Frame;
	} completion:^(BOOL finished){ [self audioPlayerSounds:@"fx.click.wav"]; }];
}

- (IBAction)choice1Button:(id)sender
{
	if( answerPosition == 0){ [self correctChoice]; }
	else{ [self wrongChoice]; }
	
	[UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice1View.frame = CGRectOffset(choice1Frame, screenWidth, 0);
	} completion:^(BOOL finished){ [self displayChoices]; }];
	
	[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice2View.frame = CGRectOffset(choice2Frame, screenWidth, 0);
		_choice3View.frame = CGRectOffset(choice3Frame, screenWidth, 0);
	} completion:^(BOOL finished){  }];
}

- (IBAction)choice2Button:(id)sender
{
	if( answerPosition == 1){ [self correctChoice]; }
	else{ [self wrongChoice]; }
	
	[UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice2View.frame = CGRectOffset(choice2Frame, screenWidth, 0);
	} completion:^(BOOL finished){ [self displayChoices]; }];
	
	[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice1View.frame = CGRectOffset(choice1Frame, screenWidth, 0);
		_choice3View.frame = CGRectOffset(choice3Frame, screenWidth, 0);
	} completion:^(BOOL finished){  }];
}

- (IBAction)choice3Button:(id)sender
{
	if( answerPosition == 2){ [self correctChoice]; }
	else{ [self wrongChoice]; }
	
	[UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice3View.frame = CGRectOffset(choice3Frame, screenWidth, 0);
	} completion:^(BOOL finished){ [self displayChoices]; }];
	
	[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_choice1View.frame = CGRectOffset(choice1Frame, screenWidth, 0);
		_choice2View.frame = CGRectOffset(choice2Frame, screenWidth, 0);
	} completion:^(BOOL finished){  }];
}

- (IBAction)choiceGeneric:(id)sender
{
	
}

- (IBAction)languageToggleButton:(id)sender
{
	lessonId = 0;
	lessonRecord = 0;
	
	[self audioPlayerSounds:@"fx.click.wav"];
	
	if( currentMode == kanjiKana ){
		currentMode = russian;
	}
    else if (currentMode == russian) {
        currentMode = korean;
    }
	else{
		currentMode = kanjiKana;
	}
	
	[self start:currentMode];
}

# pragma mark - Defaults

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
