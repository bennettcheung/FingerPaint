//
//  LineSegmentDataModel.h
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface LineSegmentDataModel : NSObject

@property (nonatomic, readonly) CGPoint firstPoint;
@property (nonatomic, readonly) CGPoint secondPoint;

- (instancetype)initWithFirstPoint:(CGPoint)first
                       secondPoint:(CGPoint)second;
@end
