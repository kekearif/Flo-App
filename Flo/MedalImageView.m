//
//  MedalImageView.m
//  Flo
//
//  Created by Keke Arif on 09/12/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "MedalImageView.h"

@implementation MedalImageView



- (id)initWithCoder:(NSCoder *)coder{
    
    self = [super initWithCoder:coder];
    if(self){
        
        
        self.image = [self getMedalImage];
        
    }
    
    return self;
    
}



-(UIImage *)getMedalImage{
    
    //Create a canvas/context to draw in, (transparent)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(120, 200), false, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set the shadow
    CGSize shadowOffset = CGSizeMake(2.0, 2.0);
    CGFloat shadowBlurRadius = 5;
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [[UIColor blackColor] colorWithAlphaComponent:0.80].CGColor);
    //Use a transparency layer so all objects are grouped for the shadow
    CGContextBeginTransparencyLayer(context, nil);
    
    //Lower Ribbon
    UIBezierPath *lowerRibbonPath = [[UIBezierPath alloc] init];
    [lowerRibbonPath moveToPoint:CGPointMake(0, 0)];
    [lowerRibbonPath addLineToPoint:CGPointMake(40, 0)];
    [lowerRibbonPath addLineToPoint:CGPointMake(78, 70)];
    [lowerRibbonPath addLineToPoint:CGPointMake(38, 70)];
    [lowerRibbonPath closePath];
    
    [[UIColor redColor] setFill];
    [lowerRibbonPath fill];
    
    //Clasp
    UIBezierPath *claspPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(36, 62, 43, 20) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    claspPath.lineWidth = 5;
    [[self darkGoldColor] setStroke];
    [claspPath stroke];
    
    //Medallion
    UIBezierPath *medallionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(8, 72, 100, 100)];
    CGContextSaveGState(context);
    [medallionPath addClip];
    
    //Press the gradient on top of medallion
    NSArray *colorsArray = [NSArray arrayWithObjects:(__bridge id)[self darkGoldColor].CGColor, (__bridge id)[self midGoldColor].CGColor, (__bridge id)[self lightGoldColor].CGColor, nil];
    CGFloat colorLocations[]= {0, 0.51, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)colorsArray, colorLocations);
    //Note the control line is diagonal
    CGContextDrawLinearGradient(context, gradient, CGPointMake(40, 40), CGPointMake(100, 160), 0);
    
    //Restore to remove clipping path
    CGContextRestoreGState(context);
    
    //Inner circle
    medallionPath.lineWidth = 2.0;
    //Create a transform matrix with scaling
    CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.8);
    //Create a transform matrix from existing transform matrix and apply a translate
    transform = CGAffineTransformTranslate(transform, 15, 30);
    [medallionPath applyTransform:transform];
    [medallionPath stroke];
    
    //Upper ribbion
    UIBezierPath *upperRibbonPath = [[UIBezierPath alloc] init];
    [upperRibbonPath moveToPoint:CGPointMake(68, 0)];
    [upperRibbonPath addLineToPoint:CGPointMake(108, 0)];
    [upperRibbonPath addLineToPoint:CGPointMake(78, 70)];
    [upperRibbonPath addLineToPoint:CGPointMake(38, 70)];
    [upperRibbonPath closePath];
    [[UIColor blueColor] setFill];
    [upperRibbonPath fill];
    
    //Number
    NSString *numberOne = @"1";
    CGRect numberRect = CGRectMake(47, 100, 50, 50);
    //Create the attributes
    UIFont *font = [UIFont fontWithName:@"Academy Engraved LET" size:60];
    NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *numberOneAttributes = @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: font, NSForegroundColorAttributeName: [self darkGoldColor]};
    [numberOne drawInRect:numberRect withAttributes:numberOneAttributes];
    
    CGContextEndTransparencyLayer(context);
    
    //Get the image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


//Custom colors

-(UIColor *)darkGoldColor{
    
    return [UIColor colorWithRed:0.6 green:0.5 blue:0.15 alpha:1.0];
}

-(UIColor *)midGoldColor{
    
    return [UIColor colorWithRed:0.86 green:0.73 blue:0.3 alpha:1.0];
    
}

-(UIColor *)lightGoldColor{
    
    return [UIColor colorWithRed:1.0 green:0.98 blue:0.9 alpha:1.0];
    
}


@end
