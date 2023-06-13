//
//  ViewController.h
//  simpleCalculator
//
//  Created by Dubiel-Teleszynski.
//  Copyright (c) 2020 Dubiel-Teleszynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *myTimer;
    BOOL running;
    int count;
    NSString *operation;
}

-(void)updateTimer;
- (IBAction)startstoptimer:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startstopbutton;
@property (weak, nonatomic) IBOutlet UILabel *timerlabel;
- (IBAction)restarttimer:(id)sender;

- (IBAction)draw:(id)sender;

- (IBAction)clear:(id)sender;

- (IBAction)check:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *displaye;
@property (weak, nonatomic) IBOutlet UILabel *display0;
@property (weak, nonatomic) IBOutlet UILabel *display1;
@property (weak, nonatomic) IBOutlet UILabel *display2;
@property (weak, nonatomic) IBOutlet UILabel *display3;
@property (weak, nonatomic) IBOutlet UILabel *display4;

@property (weak, nonatomic) IBOutlet UIButton *drawlabel;
@property (weak, nonatomic) IBOutlet UIButton *clearlabel;

@property (weak, nonatomic) IBOutlet UIButton *print1label;
@property (weak, nonatomic) IBOutlet UIButton *print2label;
@property (weak, nonatomic) IBOutlet UIButton *print3label;
@property (weak, nonatomic) IBOutlet UIButton *print4label;
@property (weak, nonatomic) IBOutlet UIButton *print5label;
@property (weak, nonatomic) IBOutlet UIButton *print6label;
@property (weak, nonatomic) IBOutlet UIButton *print7label;
@property (weak, nonatomic) IBOutlet UIButton *print8label;
@property (weak, nonatomic) IBOutlet UIButton *print9label;
@property (weak, nonatomic) IBOutlet UIButton *print0label;

- (IBAction)print1:(id)sender;
- (IBAction)print2:(id)sender;
- (IBAction)print3:(id)sender;
- (IBAction)print4:(id)sender;
- (IBAction)print5:(id)sender;
- (IBAction)print6:(id)sender;
- (IBAction)print7:(id)sender;
- (IBAction)print8:(id)sender;
- (IBAction)print9:(id)sender;
- (IBAction)print0:(id)sender;

@end
