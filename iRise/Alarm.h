//
//  Alarm.h
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Alarm : NSObject <NSCoding>

@property(nonatomic, strong) NSDate * date;
@property(nonatomic, strong) NSDate * snoozeDate;
@property(nonatomic, strong) NSString * notificationName;
@property(nonatomic, strong) NSString * dbPath;
@property(nonatomic, assign) BOOL isActive;

/*
 Used to fire notification for the specified date
 */
-(void)sendNotificationForDate:(NSDate *)datePicked;

-(void)stopAlarm;

-(void)snoozeAlarm;

@end
