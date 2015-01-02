//
//  iRiseUtility.h
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface iRiseUtility : NSObject

+(NSString *)convertNSDateToHourString:(NSDate*)date;
+(NSString *)convertNSDateToDayString:(NSDate*)date;
+(NSDate *)convertStringToDate:(NSString*)dateString;
+(NSDate *)dateWithZeroSeconds:(NSDate *)date;
+(NSString *)convert24HourTo12Hour:(NSDate *)date;
+(void)stopAlarm:(Alarm *)alarm;

@end
