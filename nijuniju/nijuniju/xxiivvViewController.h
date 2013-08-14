//
//  xxiivvViewController.h
//  nijuniju
//
//  Created by Devine Lu Linvega on 2013-08-06.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xxiivvViewController : UIViewController {
	UIImage *blurrredImage;
}

	@property (strong, nonatomic) IBOutlet UIImageView *feedbackColour;
	@property (strong, nonatomic) IBOutlet UIView *blurContainerView;
	@property (strong, nonatomic) IBOutlet UIScrollView *transparentView;
	@property (strong, nonatomic) IBOutlet UIScrollView *interfaceMenu;
	@property (strong, nonatomic) IBOutlet UILabel *interfaceMenuProgress;
	@property (strong, nonatomic) IBOutlet UIView *blurTarget;
	@property (strong, nonatomic) IBOutlet UILabel *blurTargetGlyph;
	@property (strong, nonatomic) IBOutlet UIScrollView *interfaceOptions;
	@property (strong, nonatomic) IBOutlet UIImageView *blurTargetPing;
	@property (strong, nonatomic) IBOutlet UIImageView *interfaceMenuTimeBar;
	@property (strong, nonatomic) IBOutlet UIImageView *interfaceMenuTimeRemaining;
	@property (strong, nonatomic) IBOutlet UIView *interfaceHint;
	@property (strong, nonatomic) IBOutlet UILabel *interfaceMenuTimeRemainingLabel;
	@property (strong, nonatomic) IBOutlet UIButton *interfaceMenuNext;
	@property (strong, nonatomic) IBOutlet UIImageView *blurError;
	@property (strong, nonatomic) IBOutlet UIButton *interfaceMenuReset;
	@property (strong, nonatomic) IBOutlet UIView *interfaceChapter;
	@property (strong, nonatomic) IBOutlet UILabel *interfaceChapterName;
	@property (strong, nonatomic) IBOutlet UIImageView *interfaceMenuTimeAverage;

	-(IBAction)interfaceMenuNext:(id)sender;
	-(IBAction)interfaceMenuReset:(id)sender;
	-(void)gameIsFinished;

@end

CGRect screen;
float screenMargin;

// User Variables

int		userLastLessonReached;
float	userCurrentKanjiScore;
int		userTotalKanjiSeen;
int		userCurrentKanjiSeen;

// Game Variables

int		gameCurrentKanjiAnswer;
float	gamePositionAverage;
float	gameTimeElapsed;
BOOL	gameNextLessonIsReview;
int		gameCurrentLesson;
NSString	*gameCurrentLessonKanji;
NSTimer		*gameTimeRemaining;
NSTimer		*gameTimeElapsing;

NSArray *gameContentArray;
NSMutableArray *userContentRecords;

UIColor* colorGood;
UIColor* colorBad;
UIColor* colorAverage;
UIColor* colorWorse;
UIColor* colorBetter;




