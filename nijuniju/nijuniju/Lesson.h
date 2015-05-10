//
//  Lesson.h
//  Vocavularist
//
//  Created by Devine Lu Linvega on 2015-05-10.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lesson : NSObject

-(Lesson*)initWithString:(NSString*)language;
-(NSArray*)mistakesFromLessonId:(int)lessonId;
-(NSString*)answerFromLessonId:(int)lessonId;

-(NSUInteger)length;

@end
