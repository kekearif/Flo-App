//
//  ViewController.m
//  Flo
//
//  Created by Keke Arif on 20/11/2015.
//  Copyright © 2015 Keke Arif. All rights reserved.
//

#import "ViewController.h"
#import "CounterView.h"
#import "PushButtonView.h"
#import "GraphView.h"
#import "MedalImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CounterView *counterView;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@property (strong, nonatomic) UITapGestureRecognizer *tgr;

@property BOOL isGraphShowing;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet MedalImageView *medalView;

@end

@implementation ViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isGraphShowing = NO;
    self.counterView.counter = 0;
    self.counterLabel.text = [NSString stringWithFormat:@"%d",self.counterView.counter];
    self.tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipGraphView)];
    [self.containerView addGestureRecognizer:self.tgr];
    [self checkTotal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)pushButton:(PushButtonView *)sender {
    
    if(sender.isAddButton){
        
        
        if(self.counterView.counter<noOfGlasses){
            self.counterView.counter++;
            [self.counterView refreshCounter];
        }
        
        
    }
    else{
        
        if(self.counterView.counter>0){
            self.counterView.counter--;
            [self.counterView refreshCounter];
        }
        
        
    }
    
    self.counterLabel.text = [NSString stringWithFormat:@"%d",self.counterView.counter];
    
    //Flip back if we tap a button
    if(self.isGraphShowing){
        
        [self flipGraphView];
    }
    
    [self checkTotal];
    
    
}

-(void)flipGraphView{
    
    if(self.isGraphShowing){
        
        //Flip back to the counter
        [UIView transitionFromView:self.graphView toView:self.counterView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews completion:nil];

    }
    else{
        
        //Set the graph up with the days and todays value first
        [self setGraphDisplay];
        
        [UIView transitionFromView:self.counterView toView:self.graphView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews completion:nil];
 
    }
    
    self.isGraphShowing = !self.isGraphShowing;

}

-(void)setGraphDisplay{
    
    
    //Put the counter value into the last point on the graph (for TODAY)
    self.graphView.graphPoints[[self.graphView.graphPoints count] -1] = [NSNumber numberWithInt:self.counterView.counter];
    [self.graphView setNeedsDisplay];
    
    //Set the max number of glasses drank
    NSNumber *maxValue = [self.graphView.graphPoints valueForKeyPath:@"@max.self"];
    self.maxLabel.text = [NSString stringWithFormat:@"%d", [maxValue intValue]];
    
    //Calculate average water drank
    NSNumber *average = [self.graphView.graphPoints valueForKeyPath:@"@avg.self"];
    self.averageLabel.text = [NSString stringWithFormat:@"%d", [average intValue]];
    
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    int today = [[myFormatter stringFromDate:todayDate] intValue];
    
    NSMutableArray *days = [NSMutableArray arrayWithObjects:@"S", @"M", @"T", @"W", @"T", @"F", @"S", nil];
    
    //Order days along x-axis
    for(int x = (int)[self.graphView.graphPoints count]; x > 0; x--){
        
        int day = today - (7 - x);
        if(day < 0){
            day += 7;
        }
        UILabel *dayLabel = (UILabel *)[self.graphView viewWithTag:x];
        dayLabel.text = [NSString stringWithFormat:@"%@", days[day]];
   
    }
    
    
}

//For showing the medal, called on viewDidLoad and for button presses
-(void)checkTotal{
    
    if(self.counterView.counter >= 8){
        
        self.medalView.hidden = NO;
    }
    else{
        self.medalView.hidden = YES;
    }
}

@end
