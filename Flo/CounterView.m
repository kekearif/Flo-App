//
//  CounterView.m
//  Flo
//
//  Created by Keke Arif on 30/11/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "CounterView.h"

int const noOfGlasses = 8;

IB_DESIGNABLE //This opens up the live design

@interface CounterView ()


@property (nonatomic, strong) IBInspectable  UIColor *outlineColor;
@property (nonatomic, strong) IBInspectable  UIColor *counterColor;

@end

@implementation CounterView


- (void)drawRect:(CGRect)rect {
    
    //Draw main arc
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MIN(self.bounds.size.width/2, self.bounds.size.height)/2;
    
    CGFloat arcWidth = 76;
    
    CGFloat startAngle = 3*M_PI/4;
    CGFloat endAngle = M_PI/4;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.lineWidth = arcWidth;
    
    [self.counterColor setStroke];
    [path stroke];
    
    //Draw the outline (length depends on number of glasses drank)
    
    CGFloat angleDifference = 2*M_PI - startAngle + endAngle;
    CGFloat arcLengthPerGlass = angleDifference / noOfGlasses;
    
    CGFloat outlinedEndAngle = arcLengthPerGlass * self.counter + startAngle;
    
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius+arcWidth/2-2.5 startAngle:startAngle endAngle:outlinedEndAngle clockwise:YES];
    
    //Inner
    [outlinePath addArcWithCenter:center radius:radius-arcWidth/2 + 2.5 startAngle:outlinedEndAngle endAngle:startAngle clockwise:NO];
    
    [outlinePath closePath];
    [self.outlineColor setStroke];
    outlinePath.lineWidth = 5;
    [outlinePath stroke];
    
    //Draw the markers
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Save original state
    CGContextSaveGState(context);
    [self.outlineColor setFill];
    CGFloat markerwidth = 5.0;
    CGFloat markersize = 10.0;
    
    //Markers are tiny rects, shift by -1/2 the width so they are centered, right now they are positioned at the top left of the context
    UIBezierPath *markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-markerwidth/2, 0, markerwidth, markersize)];
    
    //Here they are put in the center i.e. half the width and size
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    
    for(int i = 0; i < noOfGlasses+1; i++){
        
        //Save the centered context
        CGContextSaveGState(context);
        
        //Angle them
        CGFloat angle = arcLengthPerGlass * (CGFloat)i + startAngle - M_PI/2;
        CGContextRotateCTM(context, angle);
        
        //Translate
        CGContextTranslateCTM(context, 0, radius+arcWidth/2 - markersize);
        
        [markerPath fill];
        CGContextRestoreGState(context);
        
        
    }
    
    CGContextRestoreGState(context);
    
    
}

//Called each time a button is pressed

-(void)refreshCounter{
    
    [self setNeedsDisplay];
}


@end
