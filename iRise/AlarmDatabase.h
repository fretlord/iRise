//
//  AlarmDatabase.h
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface AlarmDatabase : NSObject

+(NSMutableArray *)retrieveAlarms;
+(Alarm *)retrieveAlarmWithName:(NSString *)alarmName;
+(void)saveAlarm:(Alarm *)alarm;
+(NSString *)nextAlarmName;
+(void)deleteAlarm:(Alarm *)alarm;
+(void)updateAlarm:(Alarm *)alarm;

@end