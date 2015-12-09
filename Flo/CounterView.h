//
//  CounterView.h
//  Flo
//
//  Created by Keke Arif on 30/11/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int const noOfGlasses;

@interface CounterView : UIView

@property IBInspectable int counter;
-(void)refreshCounter;

@end
