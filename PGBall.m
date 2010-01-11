//
//  PGBall.m
//  Ping
//
//  Created by Alex Gordon on 19/01/2009.
//  Copyright 2009 Fileability. All rights reserved.
//

#import "PGBall.h"
#import "PGController.h"
#import "Finder.h"

@implementation PGBall

@synthesize controller;

@synthesize radius;
@synthesize mass;
@synthesize position;
@synthesize velocity;
@synthesize acceleration;
@synthesize jerk;

@synthesize finderIcons;

- (void)setPosition:(AGVec)p
{
	FinderItem *topLeft = [finderIcons objectAtIndex:0];
	FinderItem *topRight = [finderIcons objectAtIndex:1];
	FinderItem *bottomLeft = [finderIcons objectAtIndex:2];
	FinderItem *bottomRight = [finderIcons objectAtIndex:3];
	
	NSSize iconSize = [controller iconSize];
	NSSize screenSize = [controller screenSize];

	position = p;
	
	p.x += iconSize.width;
	//p.y = screenSize.height - p.y;
	
	topLeft.desktopPosition = NSMakePoint(p.x, p.y);
	topRight.desktopPosition = NSMakePoint(p.x + iconSize.width, p.y);
	bottomLeft.desktopPosition = NSMakePoint(p.x, p.y + iconSize.height);
	bottomRight.desktopPosition = NSMakePoint(p.x + iconSize.width, p.y + iconSize.height);
}

- (id) init
{
	if (self = [super init])
	{
		radius = 5.5;
		mass = 1;
		position = AGMakeVec(10, 10);
		
		finderIcons = [[NSMutableArray alloc] initWithCapacity:4];
		
		double pi_8 = M_PI_4/2.0;
		float sign = (SSRandomIntBetween(0, 1) * 2 - 1);
		float extraQuarter = (SSRandomIntBetween(0, 1) * M_PI_2);
		float r = sign * (SSRandomFloatBetween(M_PI_2 * 0.25, M_PI_2 * 0.75) + extraQuarter);
		velocity = AGMakeGeometricVec(r, 450);
		acceleration = AGNullVec;
		jerk = AGNullVec;
	}
	return self;
}

- (AGVec)weight
{
	//mass * 9.8
	return AGNullVec;
	return AGMakeVec(0, mass * -1000);
}

@end
