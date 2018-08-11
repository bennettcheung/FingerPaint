//
//  DrawingView.h
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) float lineWidth;
@property (nonatomic, assign) BOOL drawingMode;

-(void) clearDrawings;
@end
