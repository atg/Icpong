//
//  PGBall.h
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "AGVector.h"

@class PGController;

@interface PGBall : NSObject
{
	PGController *controller;
	
	float radius;
	AGScalar mass;
	
	AGVec position;
	AGVec velocity;
	AGVec acceleration;
	AGVec jerk;
	
	NSMutableArray *finderIcons;
}

@property (assign) PGController *controller;

@property (assign) float radius;
@property (assign) AGScalar mass;

@property (assign) AGVec position;
@property (assign) AGVec velocity;
@property (assign) AGVec acceleration;
@property (assign) AGVec jerk;

@property (assign) NSMutableArray *finderIcons;

@property (readonly, getter=weight) AGVec weight;

/*- (AGVector)momentum;
- (AGVector)impulse;
- (AGVector)force;*/

- (void)setPosition:(AGVec)p;

@end
