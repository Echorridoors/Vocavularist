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
	
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"食", @"Think", @"Must", @"Eat",@"3", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"行", @"Go", @"Eat", @"Think",@"1", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"飲", @"Think", @"Must", @"Eat",@"3", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"思", @"Go", @"Eat", @"Think",@"1", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"休", @"Think", @"Must", @"Eat",@"3", nil]];
	[nodeContentArray addObject:[NSArray arrayWithObjects: @"子", @"Go", @"Eat", @"Think",@"1", nil]];
}


@end