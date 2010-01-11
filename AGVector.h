/*
 *  AGVector.h
 *
 *  Created by Alex Gordon on 15/08/2008.
 *  Copyright 2008 Fileability. All rights reserved.
 *
 */

#define ENABLE_COCOA_METHODS

typedef long double AGScalar;

typedef struct _AGVec {
	AGScalar x;
	AGScalar y;
} AGVec;

//The vector (0, 0)
extern const AGVec AGNullVec;

//Creates a vector with components (x, y)
AGVec AGMakeVec(AGScalar x, AGScalar y);
//Creates a vector at an angle (radians) and magnitude
AGVec AGMakeGeometricVec(AGScalar angle, AGScalar magnitude);

//Add two vectors together
AGVec AGVecAdd(AGVec a, AGVec b);
//Subtract vector b from vector a
AGVec AGVecSub(AGVec a, AGVec b);
//The dot product of a and b
AGScalar AGVecDot(AGVec a, AGVec b);
//This function treats vectors _a_ and _b_ as complex numbers, and performs complex division on them
AGVec AGVecDiv(AGVec a, AGVec b);

//Multiply vector a by a scalar b
AGVec AGVecScalarMul(AGVec a, AGScalar b);
//Divide vector a by a scalar b
AGVec AGVecScalarDiv(AGVec a, AGScalar b);

//The magnitude of vector a
AGScalar AGVecMag(AGVec a);
//The direction of vector a
AGScalar AGVecDirection(AGVec a);

#ifdef ENABLE_COCOA_METHODS
	//AGVector <-> NSPoint conversion
	NSPoint AGVecToNSPoint(AGVec v);
	AGVec NSPointToAGVec(NSPoint p);

	//Returns the string representation of the vector
	NSString *AGVecToString(AGVec v);
#endif