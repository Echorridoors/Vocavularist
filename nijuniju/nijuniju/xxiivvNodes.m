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

- (void) nodeStart
{
	nodeContentArray = [[NSMutableArray alloc] init];
	
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"食", @"Think|ひら", @"Must|ひら", @"Eat|ひら",@"3", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"行", @"Go|ひら", @"Eat|ひら", @"Think|ひら",@"1", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"飲", @"Think|ひら", @"Drink|ひら", @"Eat|ひら",@"2", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"思", @"Half|ひら", @"Eat|ひら", @"Think|ひら",@"3", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"休", @"Think|ひら", @"Sleep|ひら", @"Eat|ひら",@"2", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"子", @"Go|ひら", @"Eat|ひら", @"Kid|ひら",@"3", nil]];
}

- (void) userStart
{
	userProgress = 1;
	userContentRecords = [[NSMutableArray alloc] init];
}


- (void) userSaveRecord :(int)location :(float)record
{
	NSLog(@"> Save  | Saved Record: %f", record);
	[userContentRecords addObject:[NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",location], [NSString stringWithFormat:@"%f",record], nil]];
}



- (void) userReset
{
	NSLog(@"> Reset | Reset User Records");
	userContentRecords = [[NSMutableArray alloc] init];
	[userContentRecords addObject:[NSArray arrayWithObjects: @"1",@"1",nil]];
	self.interfaceMenuProgress.text = @"Press \"Next\" to begin";
	[self gameFinish];
}

@end