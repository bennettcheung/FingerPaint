//
//  LineSegmentDataModel.m
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "LineSegmentDataModel.h"

#import "LineSegmentDataModel.h"

@implementation LineSegmentDataModel

- (instancetype)initWithFirstPoint:(CGPoint)first
                       secondPoint:(CGPoint)second
{
    if (self = [super init]) {
        _firstPoint = first;
        _secondPoint = second;
    }
    return self;
}

@end
