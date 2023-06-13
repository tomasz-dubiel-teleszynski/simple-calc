//
//  ViewController.m
//  simpleCalculator
//
//  Created by Dubiel-Teleszynski.
//  Copyright (c) 2020 Dubiel-Teleszynski. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    running = NO;
    count = 0;
    operation = @"";
    self.timerlabel.text = @" 00:00.00";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startstoptimer:(id)sender {
    if(running == YES) {
        running = NO;
        
        if (self.display3.textColor == [UIColor greenColor]) {
            operation = @"";
        } else {
            operation = self.display0.text;
        }
            
        [myTimer invalidate];
        myTimer = nil;
        
        [self.startstopbutton setTitle:@"START" forState:UIControlStateNormal];
        
        self.displaye.text = @"";
        self.display0.text = @"";
        self.display1.text = @"";
        self.display2.text = @"";
        self.display3.text = @"";
        
        self.display3.textColor = [UIColor blackColor];
        self.display4.textColor = [UIColor blackColor];
        self.drawlabel.titleLabel.textColor = [UIColor blackColor];
        self.clearlabel.titleLabel.textColor = [UIColor blackColor];
        
    }
    else if (running == NO){
        running = YES;
        [self.startstopbutton setTitle:@"STOP" forState:UIControlStateNormal];
        if (myTimer == nil) {
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
        [self draw:self];
    }
}

-(void)updateTimer {
    count++;
    int min = floor(count/100/60);
    int sec = floor(count/100);
    int mSec = count % 100;
    if (sec >= 60) {
        sec = sec % 60;
    }
    self.timerlabel.text = [NSString stringWithFormat:@" %02d:%02d.%02d",min,sec,mSec];
}

- (IBAction)restarttimer:(id)sender {
    running = NO;
    [myTimer invalidate];
    myTimer = nil;
    count = 0;
    operation = @"";
    self.timerlabel.text = @" 00:00.00";
    
    [self.startstopbutton setTitle:@"START" forState:UIControlStateNormal];
    
    self.displaye.text = @"";
    self.display0.text = @"";
    self.display1.text = @"";
    self.display2.text = @"";
    self.display3.text = @"";
    self.display4.text = @"0";
    
    self.display3.textColor = [UIColor blackColor];
    self.display4.textColor = [UIColor blackColor];
    self.drawlabel.titleLabel.textColor = [UIColor blackColor];
    self.clearlabel.titleLabel.textColor = [UIColor blackColor];
    
}

- (IBAction)draw:(id)sender {
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (([self.display3.text isEqualToString:@""]) && ([self.display1.text isEqualToString:@""] == 0)) {
        return;
    }
    
    if (([self.display3.text isEqualToString:@""] == 0) && ([self.display1.text isEqualToString:@""] == 0) && (self.display3.textColor == [UIColor blackColor])) {
        return;
    }
    
    if (running == NO) {
        return;
    }
    
    self.displaye.text = @"=";
    
    self.display3.textColor = [UIColor blackColor];
    self.display4.textColor = [UIColor blackColor];
    
    int min = MIN(499,1 + floor(cbrt([self.display4.text intValue]))); // cube root
    int max = MIN(499,10 + floor(sqrt([self.display4.text intValue]))); // square root
    
    double rn0;
    int rn1;
    int rn2;
    
    rn0 = arc4random()/RAND_MAX;
    
    if ([operation isEqualToString:@""]) {
        if (rn0 > 0.5) {
            self.display0.text = @"+";
        } else {
            self.display0.text = @"-";
        }
    } else {
        self.display0.text = operation;
        operation = @"";
    }
    
    rn1 = min + arc4random_uniform((uint32_t)(max - min + 1));
    
    rn2 = min + arc4random_uniform((uint32_t)(max - min + 1));
    
    if (rn1 > rn2) {
        self.display1.text = [NSString stringWithFormat:@"%i",rn1];
        
        self.display2.text = [NSString stringWithFormat:@"%i",rn2];
    } else {
        self.display1.text = [NSString stringWithFormat:@"%i",rn2];
        
        self.display2.text = [NSString stringWithFormat:@"%i",rn1];
    }

    self.display3.text = @"";
    
}

- (IBAction)clear:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    self.display3.text = @"";
    self.display3.textColor = [UIColor blackColor];
    
    self.display4.textColor = [UIColor blackColor];
    self.clearlabel.titleLabel.textColor = [UIColor blackColor];
    
}

- (IBAction)check:(id)sender {
    if (([self.display1.text isEqualToString:@""]) ||
        ([self.display3.text isEqualToString:@""])) {
        return;
    }
    
    if ((self.display3.textColor == [UIColor greenColor]) ||
        (self.display3.textColor == [UIColor redColor])) {
        return;
    }
    
    int a = [self.display1.text intValue];
    int b = [self.display2.text intValue];
    int c = [self.display3.text intValue];
    int p;
    
    if ([self.display0.text isEqualToString:@"+"]) {
        if (a + b == c) {
            self.display3.textColor = [UIColor greenColor];
            self.display4.textColor = [UIColor greenColor];
            self.drawlabel.titleLabel.textColor = [UIColor greenColor];
            p = [self.display4.text intValue];
            p += 2;
            self.display4.text = [NSString stringWithFormat:@"%i",p];
            
        }
        else {
            self.display3.textColor = [UIColor redColor];
            p = [self.display4.text intValue];
            p -= 1;
            p = MAX(0,p);
            self.display4.text = [NSString stringWithFormat:@"%i",p];
            self.display4.textColor = [UIColor redColor];
            self.clearlabel.titleLabel.textColor = [UIColor redColor];
            
        }
    }
    else {
        if (a - b == c) {
            self.display3.textColor = [UIColor greenColor];
            self.display4.textColor = [UIColor greenColor];
            self.drawlabel.titleLabel.textColor = [UIColor greenColor];
            p = [self.display4.text intValue];
            p += 2;
            self.display4.text = [NSString stringWithFormat:@"%i",p];
            
        }
        else {
            self.display3.textColor = [UIColor redColor];
            p = [self.display4.text intValue];
            p -= 1;
            p = MAX(0,p);
            self.display4.text = [NSString stringWithFormat:@"%i",p];
            self.display4.textColor = [UIColor redColor];
            self.clearlabel.titleLabel.textColor = [UIColor redColor];

        }
    }
    
}

- (IBAction)print1:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"1";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"1"];
    }
    
}

- (IBAction)print2:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"2";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"2"];
    }
    
}

- (IBAction)print3:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"3";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"3"];
    }
    
}

- (IBAction)print4:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"4";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"4"];
    }
    
}

- (IBAction)print5:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"5";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"5"];
    }
    
}

- (IBAction)print6:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"6";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"6"];
    }
    
}

- (IBAction)print7:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"7";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"7"];
    }
    
}

- (IBAction)print8:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"8";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"8"];
    }
    
}

- (IBAction)print9:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"9";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"9"];
    }
    
}

- (IBAction)print0:(id)sender {
    if ([self.display1.text isEqualToString:@""]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor greenColor]) {
        return;
    }
    
    if (self.display3.textColor == [UIColor redColor]) {
        return;
    }
    
    if (self.display3.text.length > 2) {
        self.display3.text = @"0";
    }
    else {
        self.display3.text = [self.display3.text  stringByAppendingString:@"0"];
    }
    
}

@end
