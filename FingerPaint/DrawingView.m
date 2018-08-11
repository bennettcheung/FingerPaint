//
//  DrawingView.m
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView()
@property UIBezierPath *path;
@property UIImage *incrementalImage;
@end

@implementation DrawingView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.path = [UIBezierPath bezierPath];
        [self.path setLineWidth:2.0];
        self.color = [UIColor lightGrayColor];
        _drawingMode = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.incrementalImage drawInRect:rect];
    if (self.drawingMode)
    {
        [self.path setLineWidth:2.0];
        [self.color setStroke];
    }
    else
    {
        [self.path setLineWidth:6.0];
        [[UIColor whiteColor] setStroke];
    }
    
    [self.path stroke];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path moveToPoint:p];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p];
    [self drawBitmap]; 
    [self setNeedsDisplay];
    [self.path removeAllPoints];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!self.incrementalImage) // draw a rectangle with Bezier path paint background white
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [self.incrementalImage drawAtPoint:CGPointZero];
    if (self.drawingMode)
    {
        [self.path setLineWidth:2.0];
        [self.color setStroke];
    }
    else
    {
        [self.path setLineWidth:6.0];
        [[UIColor whiteColor] setStroke];
    }
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)clearDrawings{
    self.incrementalImage = nil;
    [self.path removeAllPoints];
    [self setNeedsDisplay];
}
@end
