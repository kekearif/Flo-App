//
//  GraphView.m
//  Flo
//
//  Created by Keke Arif on 01/12/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "GraphView.h"

IB_DESIGNABLE

@interface GraphView ()

@property (nonatomic, strong) IBInspectable  UIColor *startColor;
@property (nonatomic, strong) IBInspectable  UIColor *endColor;



@end

@implementation GraphView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        
        //Init for 7 days (example data)
        self.graphPoints = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt: 6], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5], [NSNumber numberWithInt:8], [NSNumber numberWithInt:3], nil];
    }
    
    return  self;
}


- (void)drawRect:(CGRect)rect {
    
    
  
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8.0, 8.0)];
    [roundedPath addClip];
    
    //Get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Standard color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colorsArray = [NSArray arrayWithObjects:(__bridge id)self.startColor.CGColor, (__bridge id)self.endColor.CGColor, nil];
    //This is a C array
    CGFloat colorLocations[] = {0.0, 1.0};
    
    //Need to bridge
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorsArray, colorLocations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    //This paints along the control line defined by startPoint and endPoint
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    
    
    //Get the points for the graph
    NSMutableArray *points = [[NSMutableArray alloc] init];
    CGFloat maxY = 0;
    
    CGFloat margin = 20.0;
    CGFloat topBorder = 60;
    CGFloat bottomBorder = 50;
    CGFloat graphHeight = rect.size.height - topBorder - bottomBorder;
    NSNumber *maxValue = [self.graphPoints valueForKeyPath:@"@max.self"];
    
    //Calculate point locations
    for(int n = 0; n < [self.graphPoints count]; n++){
        
        CGFloat spacer = (rect.size.width - margin*2)/(CGFloat)([self.graphPoints count]-1);
        CGFloat x = (CGFloat)n*spacer;
        x += margin;
        
        //Divide by the max value and the height to scale it
        CGFloat y = (CGFloat)[self.graphPoints[n] floatValue]/(CGFloat)[maxValue floatValue]*graphHeight;
        y = graphHeight + topBorder - y;
        
        if(y > maxY){
            maxY = y;
        }
        
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
    }
    
    //Plot all
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    
    UIBezierPath *graphPath = [[UIBezierPath alloc] init];
    [graphPath moveToPoint:[points[0] CGPointValue]];
    
    for(int n = 1; n < [points count]; n++){
        
        CGPoint nextPoint = [points[n] CGPointValue];
        [graphPath addLineToPoint:nextPoint];
    }
    
    //Save state so we can restore after doing a clipping
    CGContextSaveGState(context);
    
    //Create a clipping path under the graph
    UIBezierPath *clippingPath = [UIBezierPath bezierPathWithCGPath:graphPath.CGPath];
    [clippingPath addLineToPoint:CGPointMake([points[[points count] -1]CGPointValue].x, self.bounds.size.height)];
    [clippingPath addLineToPoint:CGPointMake([points[0]CGPointValue].x, self.bounds.size.height)];
    [clippingPath closePath];
    [clippingPath addClip];
    
    //Go from the top to the bottom and apply gradient ovet the clipping
    startPoint = CGPointMake(margin, self.bounds.size.height-topBorder-maxY);
    endPoint = CGPointMake(margin, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    
    //Restore state so clipping area is removed
    CGContextRestoreGState(context);
    
    graphPath.lineWidth = 2.0;
    [graphPath stroke];
    
    //Add points
    for(int n = 0; n < [points count]; n++){
        
        CGPoint point = [points[n] CGPointValue];
        point.x -= 5.0/2;
        point.y -= 5.0/2;
        //Radius is 2.5
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x, point.y, 5.0, 5.0)];
        [circle fill];
        
        
    }
    
    //Draw three lines across the graph
    
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:CGPointMake(margin, topBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width - margin, topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, graphHeight/2 + topBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width - margin, graphHeight/2 + topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, graphHeight + topBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width - margin, graphHeight + topBorder)];
    
    linePath.lineWidth = 1.0;
    [linePath stroke];

    
}


@end
