/*
 *  AGVector.m
 *
 *  Created by Alex Gordon on 15/08/2008.
 *  Copyright 2008 Fileability. All rights reserved.
 *
 */


#import "AGVector.h"

const AGVec AGNullVec = {0.0l, 0.0l};

AGVec AGMakeVec(AGScalar x, AGScalar y)
{
	AGVec v;
	v.x = x;
	v.y = y;
	return v;
}
AGVec AGMakeGeometricVec(AGScalar angle, AGScalar magnitude)
{
	AGVec z;
	z.x = cosl(angle) * magnitude;
	z.y = sinl(angle) * magnitude;
	return z;
}

AGVec AGVecAdd(AGVec a, AGVec b)
{
	a.x += b.x;
	a.y += b.y;
	return a;
}
AGVec AGVecSub(AGVec a, AGVec b)
{
	a.x -= b.x;
	a.y -= b.y;
	return a;
}
AGScalar AGVecDot(AGVec a, AGVec b)
{
	return a.x*b.x + a.y*b.y;
}

//This is complex division applied to vectors
AGVec AGVecDiv(AGVec a, AGVec b)
{
	AGVec z;
	z.x = (a.x * b.x + a.y * b.y) / (pow(b.x, 2) + pow(b.y, 2));
	z.y = (a.y * b.x + a.x * b.y) / (pow(b.x, 2) + pow(b.y, 2));
	
	return z;
}

AGVec AGVecScalarMul(AGVec a, AGScalar b)
{
	a.x *= b;
	a.y *= b;
	return a;
}
AGVec AGVecScalarDiv(AGVec a, AGScalar b)
{
	if (b == 0)
		b = MAXFLOAT;
		
	a.x /= b;
	a.y /= b;
	return a;
}

AGScalar AGVecMag(AGVec a)
{
	return sqrtl(powl(a.x,2) + powl(a.y,2));
}
AGScalar AGVecDirection(AGVec a)
{
	return atan2l(a.y, a.x);
}


#ifdef ENABLE_COCOA_METHODS
	NSPoint AGVecToNSPoint(AGVec v)
	{
		NSPoint p;
		p.x = v.x;
		p.y = v.y;
		return p;
	}
	AGVec NSPointToAGVec(NSPoint p)
	{
		AGVec v;
		v.x = p.x;
		v.y = p.y;
		return v;
	}

	NSString *AGVecToString(AGVec v)
	{
		return [NSString stringWithFormat:@"{%Lf, %Lf}", v.x, v.y]; 
	}
#endif
