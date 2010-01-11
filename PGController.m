//
//  PGController.m
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import "PGController.h"
#import "PGBall.h"
#import "PGGameView.h"
#import "Finder.h"

@implementation PGController

@synthesize initialTime;
@synthesize ball;

- (id) init
{
	if (self = [super init])
	{
		initialTime = 0.0;
		srandom([NSDate timeIntervalSinceReferenceDate]);

		ball = [[PGBall alloc] init];
		ball.controller = self;
	}
	return self;
}

- (void)awakeFromNib
{
	FinderApplication *Finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
	FinderDesktopObject *desktop = [Finder desktop];
	SBElementArray *items = [desktop items];
	
	const unsigned ballCount = 4;
	const unsigned paddleCount = 5;
	
	if ([items count] < ballCount + paddleCount*2)
	{
		NSRunAlertPanel(@"Not enough icons on desktop!", @"You need at least %d to play.", @"Damn! Better add some more...", nil, nil, ballCount + paddleCount * 2);
		[NSApp terminate:nil]; //No icons to move about!
	}
	
	if (NSRunAlertPanel(@"CAUTION!", @"This will seriously mess up arragement of icons on you desktop. If you like them as they are, DO NOT USE!", @"Get me out of here", @"Game on!", nil) != NSAlertAlternateReturn)
	{
		[NSApp terminate:nil];
	}
	
	float counter = 0.0;
	FinderItem *firstItem = nil;
	NSMutableArray *allItems = [[NSMutableArray alloc] init];
	for (FinderItem *item in items)
	{
		if (!firstItem)
			firstItem = item;
		
		[allItems addObject:item];
		
		counter++;
	}
	
	//Work out the size of the screen and icons
	screenSize = [[NSScreen mainScreen] visibleFrame].size;
	
	iconSize = [firstItem bounds].size;
	
	screenSize.width = (floor(screenSize.width/iconSize.width) - 3.0) * iconSize.width;
	screenSize.height = floor(screenSize.height/iconSize.height) * iconSize.height;	
	
	latticeWidth = round(screenSize.width / iconSize.width);
	latticeHeight = round(screenSize.height / iconSize.height);
	
	//Assign icons to the different paddles and ball.
	//ball = 4 icons in 2x2 square
	//paddle = 5 icons in 5x1 column
	
	NSUInteger i = 0;
	for (FinderItem *item in allItems)
	{
		if (i < ballCount)
		{
			[[ball finderIcons] addObject:item];
		}
		else if (i >= ballCount && i < ballCount + paddleCount)
		{
			[[gameView paddle1Icons] addObject:item];
		}
		else if (i >= ballCount + paddleCount && i <= ballCount + paddleCount * 2)
		{
			[[gameView paddle2Icons] addObject:item];
		}
		else
		{
			item.desktopPosition = NSMakePoint(iconSize.width, iconSize.height);
		}
		
		i++;
	}
	
	[[gameView window] setAlphaValue:0.5];
	[[gameView window] makeKeyAndOrderFront:nil];
}

- (NSSize)screenSize
{
	return screenSize;
}
- (NSSize)iconSize
{
	return iconSize;
}
- (NSUInteger)latticeWidth
{
	return latticeWidth;
}
- (NSUInteger)latticeHeight
{
	return latticeHeight;
}

- (AGVec)positionAt:(float)dt
{
	AGVec dx = AGVecAdd(AGVecScalarMul(ball.velocity, dt), AGVecScalarMul(AGVecAdd(ball.acceleration, ball.weight), powl(dt, 2) / 2.0));
	return AGVecAdd(ball.position, dx);
}

- (void)reset
{
	float height = [self screenSize].height;
	ball.position = AGMakeVec([self screenSize].width/2.0, SSRandomFloatBetween(height*0.25, height*0.75));
}

- (void)start
{
	if (!isStarted)
		[self loop];
	
	isStarted = YES;
}

- (void)loop
{
	if (initialTime == 0.0)
	{
		initialTime = [NSDate timeIntervalSinceReferenceDate]; 
		lastTime = initialTime;
	}
	
	NSTimeInterval dt = [NSDate timeIntervalSinceReferenceDate] - lastTime;
	lastTime = [NSDate timeIntervalSinceReferenceDate];
	
	//p(t) = ut + (1/2)*at^2
	
	AGVec newPosition = [self positionAt:dt];
	
	if (newPosition.x - ball.radius < 0 || newPosition.x + ball.radius > screenSize.width)
		ball.velocity = AGMakeVec(-ball.velocity.x, ball.velocity.y);
	if (newPosition.y - ball.radius < 0 || newPosition.y + ball.radius > screenSize.height)
		ball.velocity = AGMakeVec(ball.velocity.x, -ball.velocity.y);
	
	if (NSIntersectsRect([gameView rectForBall], [gameView rectForPaddle:0]))
		ball.velocity = AGMakeVec(-ball.velocity.x, ball.velocity.y);
	else if (NSIntersectsRect([gameView rectForBall], [gameView rectForSide:0]))
		[self reset];
	
	if (NSIntersectsRect([gameView rectForBall], [gameView rectForPaddle:1]))
		ball.velocity = AGMakeVec(-ball.velocity.x, ball.velocity.y);
	else if (NSIntersectsRect([gameView rectForBall], [gameView rectForSide:1]))
		[self reset];
	
	
	[gameView updatePlayerPaddle];
	
	ball.position = [self positionAt:dt];
	
	//[gameView display];
	
	[self performSelector:@selector(loop) withObject:nil afterDelay:0.09];
}

@end
