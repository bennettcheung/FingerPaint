//
//  DrawingView.m
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "DrawingView.h"
#import "LineSegmentDataModel.h"

@interface DrawingView()
// An array of line segments mimicking the path of the user has traced
@property (nonatomic) NSMutableArray<LineSegmentDataModel *> *line;

@end

@implementation DrawingView

// Initializer for when created from NIB file
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _line = [NSMutableArray new];
        _color = [UIColor lightGrayColor];
        _lineWidth = 5.0;
    }
    return self;
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    // First line segment is from the initial touch point to the initial touch point, so
    // basically a point
    LineSegmentDataModel *segment = [[LineSegmentDataModel alloc] initWithFirstPoint:first
                                                                         secondPoint:first];
    [self.line addObject:segment];
    
    // Tell the system that we need to be redrawn, so the system will call drawRect: before
    // the end of the current event loop
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint second = [touch locationInView:self];        // Current touch location
    CGPoint first = [touch previousLocationInView:self]; // Previous touch location
    NSLog(@"%d: %@, %@", __LINE__, NSStringFromCGPoint(first), NSStringFromCGPoint(second));
    // Line segment is from previous touch location to current touch location
    LineSegmentDataModel *segment = [[LineSegmentDataModel alloc] initWithFirstPoint:first
                                                                         secondPoint:second];
    [self.line addObject:segment];
    
    // Tell the system that we need to be redrawn, so the system will call drawRect: before
    // the end of the current event loop
    [self setNeedsDisplay];
}

#pragma mark - Drawing

// Called whenever a portion of this view needs to be redrawn
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    UIColor *gray = self.color;
    [gray setStroke];
    
    // Loop through all elements in the segment array and draw each line
    for (LineSegmentDataModel *segment in self.line) {
        if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
            // If start/end point of line segment is the same (i.e. this is the first
            // point, then move to that point so that line is drawn starting from that
            // point
            [path moveToPoint:segment.firstPoint];
            continue;
        }
        // Draw a line from the previous line segment to the first point
        [path addLineToPoint:segment.firstPoint];
        // Draw a line from the first point to the second point
        [path addLineToPoint:segment.secondPoint];
    }
    [path stroke];
}
@end
