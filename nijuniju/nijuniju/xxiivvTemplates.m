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

-(void)templateStart{
	
	screen = [[UIScreen mainScreen] bounds];
	screenMargin = screen.size.width/8;
	
	colorGood = [UIColor colorWithWhite:0.7 alpha:1];
	colorBad = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
	colorAverage = [UIColor colorWithWhite:0.5 alpha:1];
	colorWorse = [UIColor colorWithWhite:0.3 alpha:1];
	colorBetter = [UIColor colorWithWhite:0.9 alpha:1];
	
	[self templateInterface];
	
	self.transparentView.frame = screen;
	self.blurContainerView.frame = screen;
	self.blurContainerView.hidden = NO;
	self.blurContainerView.alpha = 0.5;
	
	CAGradientLayer *bgLayer = [self greyGradient];
	bgLayer.frame = screen;
	[self.blurTarget.layer insertSublayer:bgLayer atIndex:0];
	
	self.blurTarget.backgroundColor = [UIColor whiteColor];
	
	self.blurTarget.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height-screenMargin);
	self.blurTargetGlyph.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.width-(2*screenMargin));
	self.blurTargetGlyph.textAlignment = NSTextAlignmentCenter;
	self.blurTargetGlyph.font = [UIFont fontWithName:@"Helvetica Neue" size:152];
	self.blurTargetGlyph.font = [UIFont boldSystemFontOfSize:152.0f];
	self.blurTargetGlyph.text = @"";
	
	self.blurTargetEnglishWord.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.width-(2*screenMargin));
	self.blurTargetEnglishWord.textAlignment = NSTextAlignmentCenter;
	self.blurTargetEnglishWord.font = [UIFont fontWithName:@"Helvetica Neue" size:152];
	self.blurTargetEnglishWord.text = @"";
	
	self.blurTargetPing.frame = CGRectMake(10,400,100,100);
	self.blurTargetPing.hidden = YES;
	
	self.feedbackColour.frame = screen;
	
	self.blurTarget.hidden = NO;
	self.blurContainerView.hidden = YES;
	
	self.interfaceChapter.frame = CGRectMake(screenMargin/4, screenMargin, screen.size.width, screenMargin);
	
	self.interfaceChapterName.frame = CGRectMake(0, 0, screen.size.width, screenMargin);
	self.interfaceChapterName.textAlignment = NSTextAlignmentLeft;
	self.interfaceChapterName.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceChapterName.font = [self fontSmall];
	self.interfaceChapterName.textColor = [UIColor colorWithWhite:0 alpha:0.2];
	self.interfaceChapterName.text = @"New Game";
	self.interfaceChapterName.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	self.interfaceChapter.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	
	self.interfaceMenuTimeAverage.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8.35, (screenMargin/4), (screenMargin/4) );
	self.interfaceMenuTimeAverage.image = [UIImage imageNamed:@"icn.arrow.png"];
	
	// interfaceMenuBetweenKanjis
	
	int buttonInterfaceMenuButton = (screen.size.width - (screenMargin*2))/3;
	
	self.interfaceMenuBetweenKanjis.frame = screen;
	self.interfaceMenuBetweenKanjis.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	self.interfaceMenuBetweenKanjis.alpha = 0;
	
	self.interfaceMenuModeView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
	self.interfaceMenuModeView.frame = CGRectMake(screenMargin/2, screenMargin*4, buttonInterfaceMenuButton, buttonInterfaceMenuButton);
	self.interfaceMenuModeView.layer.cornerRadius = buttonInterfaceMenuButton/2;
	
	self.interfaceMenuModeLabel.frame = CGRectMake(screenMargin/2, screenMargin*3, buttonInterfaceMenuButton, screenMargin);
	self.interfaceMenuModeLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuModeLabel.font = [self fontSmall];
	self.interfaceMenuModeLabel.text = NSLocalizedString(@"language", nil);
	
	self.interfaceMenuModeToggle.titleLabel.font = [self fontMedium];
	self.interfaceMenuModeToggle.frame = CGRectMake(screenMargin/4, screenMargin/4, buttonInterfaceMenuButton-((screenMargin/4)*2), buttonInterfaceMenuButton-((screenMargin/4)*2));
	self.interfaceMenuModeToggle.layer.cornerRadius = self.interfaceMenuModeToggle.frame.size.width/2;
	
	self.interfaceMenuReviewView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
	self.interfaceMenuReviewView.frame = CGRectMake(screenMargin+buttonInterfaceMenuButton, screenMargin*4, buttonInterfaceMenuButton, buttonInterfaceMenuButton);
	self.interfaceMenuReviewView.layer.cornerRadius = buttonInterfaceMenuButton/2;
	
	self.interfaceMenuReviewLabel.frame = CGRectMake(screenMargin+buttonInterfaceMenuButton, screenMargin*3, buttonInterfaceMenuButton, screenMargin);
	self.interfaceMenuReviewLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuReviewLabel.font = [self fontSmall];
	self.interfaceMenuReviewLabel.text = NSLocalizedString(@"review", nil);
	
	self.interfaceMenuReviewToggle.titleLabel.font = [self fontMedium];
	self.interfaceMenuReviewToggle.frame = CGRectMake(screenMargin/4, screenMargin/4, buttonInterfaceMenuButton-((screenMargin/4)*2), buttonInterfaceMenuButton-((screenMargin/4)*2));
	self.interfaceMenuReviewToggle.layer.cornerRadius = self.interfaceMenuModeToggle.frame.size.width/2;
	
	self.interfaceMenuSurvivalView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
	self.interfaceMenuSurvivalView.frame = CGRectMake((screenMargin*1.5)+(buttonInterfaceMenuButton*2), screenMargin*4, buttonInterfaceMenuButton, buttonInterfaceMenuButton);
	self.interfaceMenuSurvivalView.layer.cornerRadius = buttonInterfaceMenuButton/2;
	
	self.interfaceMenuSurvivalLabel.frame = CGRectMake((screenMargin*1.5)+(buttonInterfaceMenuButton*2), screenMargin*3, buttonInterfaceMenuButton, screenMargin);
	self.interfaceMenuSurvivalLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuSurvivalLabel.font = [self fontSmall];
	self.interfaceMenuSurvivalLabel.text = NSLocalizedString(@"survival", nil);
	
	self.interfaceMenuSurvivalToggle.titleLabel.font = [self fontMedium];
	self.interfaceMenuSurvivalToggle.frame = CGRectMake(screenMargin/4, screenMargin/4, buttonInterfaceMenuButton-((screenMargin/4)*2), buttonInterfaceMenuButton-((screenMargin/4)*2));
	self.interfaceMenuSurvivalToggle.layer.cornerRadius = self.interfaceMenuModeToggle.frame.size.width/2;
}

-(void)templateInterface{
	
	self.interfaceMenu.frame = CGRectMake(0, 0, screen.size.width, screenMargin);
	
	CAGradientLayer *bgLayer = [self darkGradient];
	bgLayer.frame = self.interfaceMenu.frame;
	[self.interfaceMenu.layer insertSublayer:bgLayer atIndex:0];
	
	CALayer *bottomBorder = [CALayer layer];bottomBorder.frame = CGRectMake(0, screenMargin-1, screen.size.width, 1);
	bottomBorder.backgroundColor = [UIColor colorWithWhite:0 alpha:1].CGColor;[self.interfaceMenu.layer addSublayer:bottomBorder];
	CALayer *bottomBorder2 = [CALayer layer];bottomBorder2.frame = CGRectMake(0, screenMargin-2, screen.size.width, 1);
	bottomBorder2.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;[self.interfaceMenu.layer addSublayer:bottomBorder2];
	
	self.interfaceMenuProgress.frame = CGRectMake(screenMargin/4, 0, screen.size.width/2, screenMargin-2);
	self.interfaceMenuProgress.text = @"Chapter 1 - Kanji 0 to 10";
	self.interfaceMenuProgress.textColor = [UIColor colorWithWhite:0.5 alpha:1];
	self.interfaceMenuProgress.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.interfaceMenuProgress.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.interfaceMenuProgress.layer.shadowOpacity = 1.0f;
	self.interfaceMenuProgress.layer.shadowRadius = 0;
	self.interfaceMenuProgress.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceMenuProgress.font = [self fontSmall];
	
	self.interfaceMenuReset.frame = CGRectMake( screen.size.width-(self.interfaceMenuReset.titleLabel.frame.size.width*2)-(screenMargin/4), (screenMargin/4)/2, self.interfaceMenuReset.titleLabel.frame.size.width*2, (screenMargin-2)-(screenMargin/4));
	self.interfaceMenuReset.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuReset.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	[self.interfaceMenuReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.interfaceMenuReset.titleLabel.font = [self fontSmall];
	[self.interfaceMenuReset setTitle:@"Start Over" forState:UIControlStateNormal];
	self.interfaceMenuReset.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
	self.interfaceMenuReset.layer.cornerRadius = 4; // this value vary as per your desire
    self.interfaceMenuReset.clipsToBounds = YES;
	self.interfaceMenuReset.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.interfaceMenuReset.layer.shadowOffset = CGSizeMake(0, -1.0f);
	self.interfaceMenuReset.layer.shadowOpacity = 1.0f;
	self.interfaceMenuReset.layer.shadowRadius = 0;
	CALayer *gradient = [CALayer layer];
	gradient.frame = CGRectMake(0, 0, self.interfaceMenuReset.frame.size.width, self.interfaceMenuReset.frame.size.height/2);
	gradient.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
	[self.interfaceMenuReset.layer addSublayer:gradient];
	
	self.interfaceOptions.frame = CGRectMake(0, screen.size.height - (screenMargin*2), screen.size.width, screenMargin*1.5);
	
	self.interfaceMenuTimeBar.alpha = 0;
	self.interfaceMenuTimeBar.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, screen.size.width-(2*screenMargin)-(2*(screenMargin/4)), (screenMargin/4) );
	self.interfaceMenuTimeBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
	self.interfaceMenuTimeBar.layer.cornerRadius = (screenMargin/4)/2;
	
	self.interfaceMenuTimeRemaining.alpha = 0;
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, (screenMargin/4), (screenMargin/4) );
	self.interfaceMenuTimeRemaining.backgroundColor = [UIColor whiteColor];
	self.interfaceMenuTimeRemaining.layer.cornerRadius = (screenMargin/4)/2;
	
	self.interfaceHint.frame = screen;
	self.interfaceHint.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	
	self.interfaceMenuTimeRemainingLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
	self.interfaceMenuTimeRemainingLabel.textAlignment = NSTextAlignmentCenter;
	self.interfaceMenuTimeRemainingLabel.textColor = [UIColor whiteColor];
	self.interfaceMenuTimeRemainingLabel.font = [self fontMedium];
	self.interfaceMenuTimeRemainingLabel.text = @"3 seconds left";
	self.interfaceMenuTimeRemainingLabel.alpha = 0;
	
	self.interfaceMenuTimeRemainingLabel.frame = CGRectMake(screenMargin, screenMargin*6.5, screen.size.width- (2*screenMargin), screenMargin*2);
	
	self.interfaceMenuNext.frame = CGRectMake(screenMargin/2, screenMargin*6.9, screen.size.width- (2*(screenMargin/2)), screenMargin*2);
	self.interfaceMenuNext.layer.cornerRadius = (screenMargin/4)/2;
	self.interfaceMenuNext.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
}

-(void)templateButtonsGenerate{
	
	for (UIView *subview in [self.interfaceOptions subviews]) {
		[subview removeFromSuperview];
	}
	
	// Find 2 different wrong answers
	
	char wrongAnswers[3];

	for (int i=0; i<3; i++){
		wrongAnswers[i] = arc4random()%(userLastLessonReached+3) + 1;
	}
	while(wrongAnswers[0] == gameCurrentLesson || wrongAnswers[0] == wrongAnswers[1] || wrongAnswers[0] == wrongAnswers[2] || wrongAnswers[0] < 0 ){
		wrongAnswers[0] = arc4random()%(userLastLessonReached+3) + 1;
	}
	while(wrongAnswers[1] == gameCurrentLesson || wrongAnswers[1] == wrongAnswers[2] || wrongAnswers[1] == wrongAnswers[0] || wrongAnswers[1] < 0 ){
		wrongAnswers[1] = arc4random()%(userLastLessonReached+3) + 1;
	}
	while(wrongAnswers[2] == gameCurrentLesson || wrongAnswers[2] < 0 ){
		wrongAnswers[2] = arc4random()%(userLastLessonReached+3) + 1;
	}
	
	int goodAnswerPosition = (arc4random()%3);
	
	for(int i = 0; i < 3; i++){
		
		NSString *hiraganaForm = gameContentArray[wrongAnswers[i]][1];
		NSString *englishForm = gameContentArray[wrongAnswers[i]][2];
		NSString *kanjiForm = gameContentArray[wrongAnswers[i]][0];
		
		if( i == goodAnswerPosition ){
			hiraganaForm = gameContentArray[gameCurrentLesson][1];
			englishForm = gameContentArray[gameCurrentLesson][2];
			kanjiForm = gameContentArray[gameCurrentLesson][0];
		}

		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button addTarget:self action:NSSelectorFromString(@"optionSelection:") forControlEvents:UIControlEventTouchDown];
		button.tag = wrongAnswers[i];
		button.frame = CGRectMake(i*((screen.size.width/3)+1), 0, screen.size.width/3, screenMargin*1.5);
		button.backgroundColor = [UIColor whiteColor];
		button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
		button.titleLabel.font = [self fontMedium];
		[button setTitle: englishForm forState: UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
		button.contentEdgeInsets = UIEdgeInsetsMake(-1*(screenMargin*0.2), 0, 0, 0);
		
		if( i == goodAnswerPosition ){
			button.tag = gameCurrentLesson;
		}
		
		if( userEnglishMode == 1 ){
			[button setTitle: kanjiForm forState: UIControlStateNormal];
			button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
		}
		else{
			UILabel *hiragana = [[UILabel alloc] initWithFrame:CGRectMake(0, (screenMargin*1.5)*0.55, button.frame.size.width, button.frame.size.height/3)];
			hiragana.text = hiraganaForm;
			hiragana.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
			hiragana.textAlignment = NSTextAlignmentCenter;
			hiragana.font = [self fontTiny];
			[button addSubview:hiragana];
		}
		
		[self.interfaceOptions addSubview:button];
	}
}

-(void)templateMenuBetweenKanjiRefresh
{
	NSLog(@"Setup | %d %d %d",userEnglishMode, userReviewMode, userSurvivalMode);
	
	if( userEnglishMode == 1 ){
		[self.interfaceMenuModeToggle setTitle:NSLocalizedString(@"english", nil) forState:normal];
		[self.interfaceMenuModeToggle setTitleColor:[UIColor blackColor] forState:normal];
		self.interfaceMenuModeToggle.titleLabel.textColor = [UIColor blackColor];
		self.interfaceMenuModeToggle.backgroundColor = [UIColor whiteColor];
	}
	else{
		[self.interfaceMenuModeToggle setTitle:NSLocalizedString(@"japanese", nil) forState:normal];
		[self.interfaceMenuModeToggle setTitleColor:[UIColor whiteColor] forState:normal];
		self.interfaceMenuModeToggle.titleLabel.textColor = [UIColor whiteColor];
		self.interfaceMenuModeToggle.backgroundColor = [UIColor blackColor];
	}
	
	if( userReviewMode == 1 ){
		[self.interfaceMenuReviewToggle setTitle:NSLocalizedString(@"on", nil) forState:normal];
		[self.interfaceMenuReviewToggle setTitleColor:[UIColor blackColor] forState:normal];
		self.interfaceMenuReviewToggle.titleLabel.textColor = [UIColor blackColor];
		self.interfaceMenuReviewToggle.backgroundColor = [UIColor whiteColor];
	}
	else{
		[self.interfaceMenuReviewToggle setTitle:NSLocalizedString(@"off", nil) forState:normal];
		[self.interfaceMenuReviewToggle setTitleColor:[UIColor whiteColor] forState:normal];
		self.interfaceMenuReviewToggle.titleLabel.textColor = [UIColor whiteColor];
		self.interfaceMenuReviewToggle.backgroundColor = [UIColor blackColor];
	}
	
	if( userSurvivalMode == 1 ){
		[self.interfaceMenuSurvivalToggle setTitle:NSLocalizedString(@"on", nil) forState:normal];
		[self.interfaceMenuSurvivalToggle setTitleColor:[UIColor whiteColor] forState:normal];
		self.interfaceMenuSurvivalToggle.titleLabel.textColor = [UIColor whiteColor];
		self.interfaceMenuSurvivalToggle.backgroundColor = [UIColor redColor];
	}
	else{
		[self.interfaceMenuSurvivalToggle setTitle:NSLocalizedString(@"off", nil) forState:normal];
		[self.interfaceMenuSurvivalToggle setTitleColor:[UIColor whiteColor] forState:normal];
		self.interfaceMenuSurvivalToggle.titleLabel.textColor = [UIColor whiteColor];
		self.interfaceMenuSurvivalToggle.backgroundColor = [UIColor blackColor];
	}
}

#pragma mark Animations -

-(void)templateButtonsAnimationShow{
	
	int i = 3;
	for (UIView *subview in [self.interfaceOptions subviews]) {
		CGRect origin = subview.frame;
		subview.frame = CGRectOffset(origin, 0, screenMargin*1.5);
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationDelay:(i*0.1)];
		subview.frame = origin;
		[UIView commitAnimations];
		i += 1;
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.interfaceMenuTimeRemaining.alpha = 1;
	[UIView commitAnimations];
	
}

-(void)templateButtonsAnimationHide{
	
	int i = 3;
	for (UIView *subview in [self.interfaceOptions subviews]) {
		CGRect origin = subview.frame;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationDelay:(i*0.1)];
		subview.frame = CGRectOffset(origin, 0, screenMargin*1.5);
		[UIView commitAnimations];
		i += 1;
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.interfaceMenuTimeRemaining.alpha = 1;
	[UIView commitAnimations];
}

-(void)templatePrepareAnimation{
	
	[self.view.layer removeAnimationForKey:@"templateStartAnimation"];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3];
	self.interfaceChapter.alpha = 1;
	self.interfaceMenuTimeBar.alpha = 1;
	self.interfaceMenuTimeRemainingLabel.alpha = 1;
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, screen.size.width-(2*screenMargin)-(2*(screenMargin/4)), (screenMargin/4) );
	[UIView commitAnimations];
}

-(void)templateReadyAnimation{
	
	[self fadeIn:self.interfaceMenuNext d:0 t:0.5];
}

-(void)templateStartAnimation {
	
	[self optionMenuAnimateHide];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.blurTarget.alpha = 1;
	[UIView commitAnimations];
	
	[UIView beginAnimations: @"templateStartAnimation" context:nil];
	[UIView setAnimationDuration:3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+(screenMargin/4), screenMargin*8, (screenMargin/4), (screenMargin/4) );
	self.blurContainerView.alpha = 0.5;
	[UIView commitAnimations];
	
	// move label up
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuNext.alpha = 0;
	self.interfaceChapter.alpha = 0;
	self.interfaceMenuTimeRemainingLabel.frame = CGRectMake(screenMargin, screenMargin*6.5, screen.size.width- (2*screenMargin), screenMargin*2);
	[UIView commitAnimations];
}

-(void)templateFinishAnimation{
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.blurTarget.alpha = 0;
	self.interfaceMenuTimeAverage.frame = CGRectMake(gamePositionAverage, screenMargin*8.35, (screenMargin/4), (screenMargin/4) );
	[UIView commitAnimations];
}

-(void)optionMenuAnimateShow{
	[self fadeIn:self.interfaceMenuBetweenKanjis d:0 t:0.5];
}
-(void)optionMenuAnimateHide{
	[self fadeOut:self.interfaceMenuBetweenKanjis d:0 t:0.3];
}

#pragma mark Ui Elements -

-(CAGradientLayer*)greyGradient{
	
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

-(CAGradientLayer*)darkGradient{
	
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

-(void)fadeIn:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration {
	
	[UIView beginAnimations: @"Fade In" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 1;
	[UIView commitAnimations];
}

-(void)fadeOut:(UIView*)viewToFadeIn d:(NSTimeInterval)delay t:(NSTimeInterval)duration {
	
	[UIView beginAnimations: @"Fade Out" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelay:delay];
	viewToFadeIn.alpha = 0;
	[UIView commitAnimations];
}

#pragma mark Responsive Values -

-(void)gameEnglishMode{
	self.blurTargetGlyph.hidden = YES;
	self.blurTargetEnglishWord.hidden = NO;
}

-(void)gameJapaneseMode{
	self.blurTargetGlyph.hidden = NO;
	self.blurTargetEnglishWord.hidden = YES;
}

-(void)templateEnglishWordLabelSize{
	
	int length = gameCurrentLessonEnglishWord.length;
	float fontSize = 90;
	
	if( length < 4 ){
		fontSize = 120;
	}
	else if( length < 7 ){
		fontSize = 80;
	}
	else {
		fontSize = 50;
	}
	
	self.blurTargetEnglishWord.font = [UIFont boldSystemFontOfSize:fontSize];
}

-(UIFont*)fontTiny{
	
	if( screen.size.width > 640 ){
		return [UIFont fontWithName:@"Helvetica Neue" size:22.0f];
	}
	return [UIFont fontWithName:@"Helvetica Neue" size:11.0f];
}

-(UIFont*)fontSmall{
	
	if( screen.size.width > 640 ){
		return [UIFont boldSystemFontOfSize:24.0f];
	}
	return [UIFont boldSystemFontOfSize:12.0f];
}

-(UIFont*)fontMedium{
	
	if( screen.size.width > 640 ){
		return [UIFont boldSystemFontOfSize:28.0f];
	}
	return [UIFont boldSystemFontOfSize:14.0f];
}


@end