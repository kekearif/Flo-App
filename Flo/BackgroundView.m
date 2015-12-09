//
//  BackgroundView.m
//  Flo
//
//  Created by Keke Arif on 08/12/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "BackgroundView.h"

IB_DESIGNABLE //This opens up the live design

@interface BackgroundView ()


@property (nonatomic, strong) IBInspectable  UIColor *lightColor;
@property (nonatomic, strong) IBInspectable  UIColor *darkColor;
@property IBInspectable  CGFloat patternSize;

@end

@implementation BackgroundView

- (void)drawRect:(CGRect)rect {
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.darkColor.CGColor);
    CGContextFillRect(context, rect);
    

    CGSize drawSize = CGSizeMake(self.patternSize, self.patternSize);
    UIGraphicsBeginImageContextWithOptions(drawSize, YES, 0.0);
    CGContextRef drawingContext = UIGraphicsGetCurrentContext();
    

    [self.darkColor setFill];
    CGContextFillRect(drawingContext, CGRectMake(0, 0, drawSize.width, drawSize.height));
    
    //Draw triangles
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    
    
    [trianglePath moveToPoint:CGPointMake(drawSize.width/2, 0)];
    [trianglePath addLineToPoint:CGPointMake(0, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height/2)];
    
    [trianglePath moveToPoint:CGPointMake(0, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(0, drawSize.height)];
    
    [trianglePath moveToPoint:CGPointMake(drawSize.width, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height)];
    
    [self.lightColor setFill];
    [trianglePath fill];
    

    //Convert to a UIImage
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Now we have the image we can fill with a pattern
    [[UIColor colorWithPatternImage:image] setFill];
    CGContextFillRect(context, rect);
    

}


@end
