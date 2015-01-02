//
//  AppDelegate.h
//  iRise
//
//  Created by Chaitanya Rathi on 30/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alarm;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic , strong) Alarm * currentAlarm;


-(void)snooze;


@end

