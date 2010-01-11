//
//  PGController.h
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "AGVector.h"

@class PGGameView, PGBall;

static __inline__ int SSRandomIntBetween(int a, int b)
{
    int range = b - a < 0 ? b - a - 1 : b - a + 1; 
    int value = (int)(range * ((float)random() / (float) LONG_MAX));
    return value == range ? a : a + value;
}

static __inline__ float SSRandomFloatBetween(float a, float b)
{
    return a + (b - a) * ((float)random() / (float) LONG_MAX);
}

@interface PGController : NSObject
{
	NSTimeInterval initialTime;
	NSTimeInterval lastTime;
	
	PGBall *ball;
	
	BOOL isStarted;
	
	IBOutlet PGGameView *gameView;
	
	NSSize screenSize;
	NSSize iconSize;
	NSUInteger latticeWidth;
	NSUInteger latticeHeight;
}

@property (assign) NSTimeInterval initialTime;
@property (assign) PGBall *ball;

- (void)start;
- (void)loop;
- (AGVec)positionAt:(float)dt;

- (NSSize)screenSize;
- (NSSize)iconSize;
- (NSUInteger)latticeWidth;
- (NSUInteger)latticeHeight;
@end
