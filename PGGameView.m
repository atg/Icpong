//
//  PGGameView.m
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import "PGGameView.h"
#import "PGController.h"
#import "PGBall.h"
#import "Finder.h"

@implementation PGGameView

@synthesize playerPaddleDirection;
@synthesize paddle1Position;
@synthesize paddle2Position;
@synthesize paddle1Icons;
@synthesize paddle2Icons;

- (void)setPaddle1Position:(float)p
{
	[self setPosition:p forPaddle:1];
}
- (void)setPaddle2Position:(float)p
{
	[self setPosition:p forPaddle:2];
}
- (void)setPosition:(float)p forPaddle:(int)paddle
{
	NSArray *icons = (paddle == 1 ? paddle1Icons : paddle2Icons);
	
	NSSize iconSize = [controller iconSize];
	NSSize screenSize = [controller screenSize];
	NSUInteger paddleLength = [icons count];
	
	if (paddle == 1)
		paddle1Position = p;
	else
		paddle2Position = p;
	
	float positionFraction = p / screenSize.height;
	if (positionFraction < 0.0)
		positionFraction = 0.0;
	if (positionFraction > 1.0)
		positionFraction = 1.0;
	
	NSPoint topIconPoint = NSMakePoint(iconSize.width, iconSize.height);
	
	if (paddle == 2)
		topIconPoint.x = screenSize.width + 2.0*iconSize.width;
	
	topIconPoint.y += positionFraction * (screenSize.height - (paddleLength * iconSize.height));//(screenSize.height - (paddleLength * iconSize.height)) * paddle1Position;
	for (FinderItem *item in icons)
	{
		item.desktopPosition = topIconPoint;
		topIconPoint.y += iconSize.height;
	}
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		
	}
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self initAll];
	}
	return self;
}
- (void)initAll
{
	paddle1Icons = [[NSMutableArray alloc] init];
	paddle2Icons = [[NSMutableArray alloc] init];

	NSSize screenSize = [controller screenSize];
	NSSize iconSize = [controller iconSize];
	paddleHeight = [paddle1Icons count] * iconSize.height;
	
	paddleWidth = [controller iconSize].width;
}
- (void)awakeFromNib
{
	playerPaddleDirection = 0;
	self.paddle1Position = [controller screenSize].height/2;
}

- (float)aiTarget
{
	/*
	float m = labs(controller.ball.velocity.y) / labs(controller.ball.velocity.x);
	float c = controller.ball.position.y - (m * controller.ball.position.x);
	
	return m * ([controller screenSize].width - paddleWidth) + c;*/
	return controller.ball.position.y;
}

- (void)drawRect:(NSRect)rect
{
	
}

- (NSRect)rectForPaddle:(int)ind
{
	if (ind == 0)
		return NSMakeRect(0, paddle1Position - paddleHeight/2.0, paddleWidth, paddleHeight);
	else
		return NSMakeRect([controller screenSize].width - paddleWidth, paddle2Position - paddleHeight/2.0, paddleWidth, paddleHeight);
}
- (NSRect)rectForSide:(int)ind
{
	if (ind == 0)
		return NSMakeRect(0, 0, paddleWidth, [controller screenSize].height);
	else
		return NSMakeRect([controller screenSize].width - paddleWidth, 0, paddleWidth, [controller screenSize].height);
}

- (BOOL)isOpaque
{
	return NO;
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}
- (BOOL)canBecomeKeyView
{
	return YES;
}
- (NSRect)rectForBall
{
	PGBall *ball = controller.ball;
	float ballRadius = ball.radius;
	return NSMakeRect(ball.position.x - ballRadius, ball.position.y - ballRadius, ballRadius * 2.0, ballRadius * 2.0);
}

- (void)mouseUp:(NSEvent *)event
{
	[controller start];
}

- (void)keyDown:(NSEvent *)event
{
	if ([event keyCode] == AGUpKeyCode)
	{
		playerPaddleDirection = 1;
	}
	else if ([event keyCode] == AGDownKeyCode)
	{
		playerPaddleDirection = -1;
	}
}
- (void)keyUp:(NSEvent *)event
{
	playerPaddleDirection = 0;
}

- (void)updatePlayerPaddle
{
	NSSize screenSize = [controller screenSize];
	
	float fudgeFactor = 10.0;
	
	if (playerPaddleDirection == 1)
		self.paddle1Position -= screenSize.height / fudgeFactor;
	else if (playerPaddleDirection == -1) 
		self.paddle1Position += screenSize.height / fudgeFactor;
	
	float aiTarget = [self aiTarget];
	
	//float margin = SSRandomFloatBetween(paddleHeight*0.1, paddleHeight);
//	if (paddle2Position < aiTarget)
//		self.paddle2Position += screenSize.height / fudgeFactor;
//	else if (paddle2Position )
		self.paddle2Position = aiTarget;//screenSize.height / fudgeFactor;
	
	float halfHeight = paddleHeight/2.0;
	if (paddle1Position - halfHeight < 0)
		self.paddle1Position = halfHeight;
	else if (paddle1Position + halfHeight > [controller screenSize].height)
		self.paddle1Position = [controller screenSize].height - halfHeight;
	
	if (paddle2Position - halfHeight < 0)
		self.paddle2Position = halfHeight;
	else if (paddle2Position + halfHeight > [controller screenSize].height)
		self.paddle2Position = [controller screenSize].height - halfHeight;
}


@end
