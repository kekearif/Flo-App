//
//  PushButtonView.m
//  Flo
//
//  Created by Keke Arif on 20/11/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "PushButtonView.h"

IB_DESIGNABLE //This opens up the live design

@interface PushButtonView ()


@property (nonatomic, strong) IBInspectable UIColor *fillColor;


@end

@implementation PushButtonView


- (void)drawRect:(CGRect)rect {
    

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self.fillColor setFill];
    [path fill];
    
    CGFloat plusHeight = 5.0; //Stroke height
    CGFloat plusWidth = MIN(self.bounds.size.width, self.bounds.size.height)*0.6;
    
    UIBezierPath *plusPath = [[UIBezierPath alloc] init];
    plusPath.lineWidth = plusHeight;
    
    
    //Move to initial point
    [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2-plusWidth/2+0.5,self.bounds.size.height/2 +0.5)];
    
    //Add horiz
    [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2+plusWidth/2+0.5, self.bounds.size.height/2+0.5)];
    
    //Add vert (depending on button type)
    if(self.isAddButton){
        [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2+0.5, self.bounds.size.height/2-plusWidth/2+0.5)];
        [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2+0.5, self.bounds.size.height/2+plusWidth/2)];
    }
 
    
    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
    
    
    if(self.highlighted == YES){
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIColor *startColor = [UIColor clearColor];
        UIColor *endColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.15];
        NSArray *colorsArray = [NSArray arrayWithObjects:(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor, nil];
        CGFloat colorLocations[] = {0.0, 1.0};
        
        CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)colorsArray, colorLocations);
        CGFloat radius = self.bounds.size.width/2;
        CGContextSetBlendMode(context, kCGBlendModeDarken);
        CGContextDrawRadialGradient(context, gradient, CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2), 0, CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2), radius, 0);
    
    }
    

}



//setHighlighted is called each time the button changes it's value of highlighted
//We can override and call setNeedsDisplay to change the appearance of it

-(void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
    
}


@end
