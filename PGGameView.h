//
//  PGGameView.h
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PGController;

typedef enum _AGKeyCodes
{
	AGEnterKeyCode = 76,
	AGReturnKeyCode = 36,
	AGEscapeKeyCode = 53,
	AGLeftKeyCode = 123,
	AGRightKeyCode = 124,
	AGUpKeyCode = 126,
	AGDownKeyCode = 125,
	AGSpaceKeyCode = 49,
	AGTabKeyCode = 48,
	AGBackspaceKeyCode = 51,
	AGForwardDeleteKeyCode = 117,
	AGHomeKeyCode = 115,
	AGEndKeyCode = 119,
	AGPageUpKeyCode = 116,
	AGPageDownKeyCode = 121
} AGKeyCodes;


@interface PGGameView : NSView
{
	IBOutlet PGController *controller;
	
	int playerPaddleDirection; //1 = up, 0 = stationary, -1, down
	
	float paddle1Position;
	float paddle2Position;
	
	NSMutableArray *paddle1Icons;
	NSMutableArray *paddle2Icons;
	
	float paddleWidth;// = 15;
	float paddleHeight; //= 100;
}

@property (readonly) int playerPaddleDirection;
@property (assign) float paddle1Position;
@property (assign) float paddle2Position;
@property (assign) NSMutableArray *paddle1Icons;
@property (assign) NSMutableArray *paddle2Icons;

- (NSRect)rectForPaddle:(int)ind;
- (NSRect)rectForSide:(int)ind;
- (NSRect)rectForBall;

- (float)aiTarget;

- (void)updatePlayerPaddle;

- (void)setPosition:(float)p forPaddle:(int)paddle;

@end
