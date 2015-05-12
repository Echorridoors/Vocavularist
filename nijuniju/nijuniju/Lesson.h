//
//  Lesson.h
//  Vocavularist
//
//  Created by Devine Lu Linvega on 2015-05-10.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xxiivvViewController.h"

@interface Lesson : NSObject

-(Lesson*)initWithLessonMode:(lessonMode)mode;
-(NSArray*)mistakesFromLessonId:(int)lessonId :(lessonMode)lessonMode;
-(NSString*)answerFromLessonId:(int)lessonId :(lessonMode)lessonMode;

-(NSUInteger)length;
-(NSString*)question:(int)lessonId;

@end
