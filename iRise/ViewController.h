//
//  ViewController.h
//  iRise
//
//  Created by Chaitanya Rathi on 30/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSTimer *timer;

}

@property(nonatomic, weak) IBOutlet UITextField * inputText;
@property(nonatomic, weak) IBOutlet UILabel * label;
@property(nonatomic, weak) IBOutlet UIButton * stopButton;
@property(nonatomic, weak) IBOutlet UIButton * snoozeButton;

@end

