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

-(void)start
{
	
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
