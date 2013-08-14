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

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

AVAudioPlayer *audioPlayerSounds;

@interface xxiivvViewController ()

@end

@implementation xxiivvViewController

-(void)viewDidLoad{
	
	[super viewDidLoad];
	[self start];
}

-(void)didReceiveMemoryWarning{
	
	[super didReceiveMemoryWarning];
}

-(void)start{
	
	[self nodeStart];
	[self userStart];
	[self userLoad];
	
	[self templateStart];
	[self templateMenuBetweenKanjiRefresh];
	[self optionMenuAnimateHide];
	[self gameIsPreparing];
}


#pragma mark Game -

-(void)gameIsPreparing{
	
	NSLog(@"> Phase | Prepare");
	
	[self userIsSaving];
	[self gameIsConfiguring];
	[self templatePrepareAnimation];
}

-(void)gameIsConfiguring{
	
	NSLog(@"> Phase | Setup");
	
	if(gameNextLessonIsReview == TRUE){
		gameCurrentLesson = ((arc4random()%(userLastLessonReached))+1);
		gameNextLessonIsReview = FALSE;
	}
	else{
		gameCurrentLesson = userLastLessonReached;
		gameNextLessonIsReview = TRUE;
	}
	
	NSLog(@"> Phase | Progress %d Next Lesson %d", userLastLessonReached, gameCurrentLesson);
	
	[self gameIsReady];
}

-(void)gameIsReady{
	
	NSLog(@"> Phase | Ready");
	
	if( userLastLessonReached == 1 ){
		self.interfaceMenuTimeRemainingLabel.text = NSLocalizedString(@"click_to_begin", nil);
	}
	else{
		self.interfaceMenuTimeRemainingLabel.text = NSLocalizedString(@"next_kanji_card", nil);
	}
	
	gameTimeUntilMenu = [NSTimer scheduledTimerWithTimeInterval:(3) target:self selector:@selector(optionMenuDisplay) userInfo:nil repeats:NO];
	
	[self templateReadyAnimation];
}

-(void)gameIsStarting{
	
	NSLog(@"> Phase | Start");
	
	[gameTimeUntilMenu invalidate];
	
	gameCurrentLessonKanji = gameContentArray[gameCurrentLesson][0];
	
	self.interfaceMenuTimeRemainingLabel.text = NSLocalizedString(@"3_seconds_left", nil);
	
	self.blurTargetGlyph.text = gameCurrentLessonKanji;
	
	[self templateButtonsGenerate];
	[self templateButtonsAnimationShow];
	[self templateStartAnimation];
	
	gameTimeElapsed = 0;
	
	gameTimeRemaining = [NSTimer scheduledTimerWithTimeInterval:(3) target:self selector:@selector(gameIsFinished) userInfo:nil repeats:NO];
	gameTimeElapsing = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(gameTimeIsCounting) userInfo:nil repeats:YES];
}

-(void)gameTimeIsCounting{
	
	gameTimeElapsed += 0.1;
	self.interfaceMenuTimeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@_seconds", nil),[NSString stringWithFormat:@"%.2f",gameTimeElapsed]];
}

-(void)gameIsFinished{
	
	NSLog(@"> Phase | Finished");
		
	[gameTimeRemaining invalidate];
	[gameTimeElapsing invalidate];
		
	[self templateButtonsAnimationHide];
	[self templateFinishAnimation];
	
	[self gameIsPreparing];
}

-(void)gameVerify:(int)input{
	
	if(input == gameCurrentKanjiAnswer){
		userCurrentKanjiScore = (3- [[gameTimeRemaining fireDate] timeIntervalSinceNow]);
		
		[self userSaveRecord:gameCurrentLesson :userCurrentKanjiScore];
		[self gameSetAverage];
				
		if( userCurrentKanjiSeen == 1 && ([gameContentArray count]-1) > userLastLessonReached ){
			userLastLessonReached += 1;
			self.interfaceMenuProgress.text = [NSString stringWithFormat:NSLocalizedString(@"chapter_%d_kanji_0_to_%@", nil),(userLastLessonReached/10)+1, ((userLastLessonReached/10)+1)*10];
		}
		
		self.interfaceMenuTimeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@_seconds", nil), [[NSString stringWithFormat:@"%f", userCurrentKanjiScore] substringWithRange:NSMakeRange(0, 4)]];
		[self audioPlayerSounds:@"fx.accepted.wav"];
	}
	else{
		[self audioPlayerSounds:@"fx.error.wav"];
		self.feedbackColour.backgroundColor = colorBad;
		self.blurTarget.alpha = 0;
	}
}

-(void)gameSetAverage{
	
	float sum = 0.0;
	float averageSum = 0.0;
	
	userTotalKanjiSeen = 0;
	userCurrentKanjiSeen = 0;
	
	while(userTotalKanjiSeen < [userContentRecords count]){
		if([userContentRecords[userTotalKanjiSeen][0] intValue] == gameCurrentLesson){
			userCurrentKanjiSeen+=1;
			sum += [userContentRecords[userTotalKanjiSeen][1] floatValue];
		}
		averageSum += [userContentRecords[userTotalKanjiSeen][1] floatValue];
		userTotalKanjiSeen+=1;
	}
	
	self.interfaceChapterName.text = [NSString stringWithFormat:NSLocalizedString(@"%@s_average_%d_kanjis", nil), [[NSString stringWithFormat:@"%f", averageSum/userTotalKanjiSeen] substringWithRange:NSMakeRange(0, 4)],userTotalKanjiSeen];
	
	// Update Average pointer
	
	gamePositionAverage = screenMargin+(screenMargin/4) + ((screen.size.width - ((screenMargin+(screenMargin/4))*2))) - (((averageSum/userTotalKanjiSeen)/3) * (screen.size.width - ((screenMargin+(screenMargin/4))*2)));
	
	// Update Background color
	
	
	self.feedbackColour.backgroundColor = colorGood;
}

#pragma mark Options -

-(void)optionSelection:(id)sender{
	
	int optionId = ((UIView*)sender).tag;
	
	NSLog(@"+ Acted | Option: %d",optionId);
	
	gameCurrentKanjiAnswer = [gameContentArray[gameCurrentLesson][4] intValue];
	
	for (UIView *subview in [self.interfaceOptions subviews]) {
		if( subview.tag != optionId ){
			CGRect origin = subview.frame;
			[UIView beginAnimations: nil context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
			[UIView setAnimationDuration:0.25];
			subview.frame = CGRectOffset(origin, 0, 10);
			subview.alpha = 0.5;
			[UIView commitAnimations];
		}
	}
	
	[self audioPlayerSounds:@"fx.click.wav"];
	
	[self gameVerify:optionId];
	[self gameIsFinished];
}

-(void)optionMenuDisplay{
	[self optionMenuAnimateShow];
}

#pragma mark Interface Menu -

- (IBAction)interfaceMenuModeToggle:(id)sender {
	
	if (userEnglishMode == TRUE) {
		userEnglishMode = FALSE;
	}else{
		userEnglishMode = TRUE;
	}
	
	[self audioPlayerSounds:@"fx.click.wav"];
	[self templateMenuBetweenKanjiRefresh];
}

- (IBAction)interfaceMenuSoundToggle:(id)sender {
	
	if (userAudio == TRUE) {
		userAudio = FALSE;
	}else{
		userAudio = TRUE;
	}
	
	[self audioPlayerSounds:@"fx.click.wav"];
	[self templateMenuBetweenKanjiRefresh];
}

- (IBAction)interfaceMenuColourToggle:(id)sender {
	
	if (userColours == TRUE) {
		userColours = FALSE;
	}else{
		userColours = TRUE;
	}
	[self audioPlayerSounds:@"fx.click.wav"];
	[self templateMenuBetweenKanjiRefresh];
}

-(IBAction)interfaceMenuNext:(id)sender{
	
	[self audioPlayerSounds:@"fx.click.wav"];
	[self gameIsStarting];
}

-(IBAction)interfaceMenuReset:(id)sender{
	
	[self audioPlayerSounds:@"fx.click.wav"];
	[self userReset];
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


@end
