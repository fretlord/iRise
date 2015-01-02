//
//  ViewController.m
//  iRise
//
//  Created by Chaitanya Rathi on 30/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

/*
 Able to set alarm for given time stamp
 Set Alarm with input
 */

#import "ViewController.h"
#import "AlarmAudioPlayer.h"
#import "AppDelegate.h"
#import "Alarm.h"
#import "AlarmDatabase.h"


@interface ViewController ()

@property (assign) SystemSoundID pewPewSound;
@property (assign) BOOL backgroundMusicPlaying;
@property (strong, nonatomic) Alarm * alarm;

@end


@implementation ViewController

@synthesize inputText,label,alarm,stopButton,snoozeButton;

int hours, minutes, seconds;
int secondsLeft;


-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];

}
- (void)updateCounter:(NSTimer *)theTimer {
    
    
    
    NSDate * todaysDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];

    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:todaysDate];

    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    label.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hour, (long)minute, (long)second];

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    Do any additional setup after loading the view, typically from a nib.
    label.font=[UIFont fontWithName:@"DBLCDTempBlack" size:52.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (UIEventSubtypeMotionShake) {
        AppDelegate * appDelegate = [[UIApplication sharedApplication ] delegate];
        if (appDelegate.currentAlarm) {
            [appDelegate snooze];            
        }

        
    }
}

@end
