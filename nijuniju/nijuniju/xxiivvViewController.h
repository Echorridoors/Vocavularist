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

@property (strong, nonatomic) IBOutlet UIScrollView *blurContainerView;
@property (strong, nonatomic) IBOutlet UIScrollView *transparentView;
@property (strong, nonatomic) IBOutlet UIScrollView *interfaceMenu;
@property (strong, nonatomic) IBOutlet UILabel *interfaceMenuProgress;
@property (strong, nonatomic) IBOutlet UIButton *interfaceMenuStop;
@property (strong, nonatomic) IBOutlet UIScrollView *blurTarget;
@property (strong, nonatomic) IBOutlet UILabel *blurTargetGlyph;
@property (strong, nonatomic) IBOutlet UIScrollView *interfaceOptions;
@property (strong, nonatomic) IBOutlet UIImageView *blurTargetPing;
	
@end

CGRect screen;
float screenMargin;