//
//  iRiseUtility.m
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import "iRiseUtility.h"
#import "AlarmAudioPlayer.h"

@implementation iRiseUtility

+(NSString *)convertNSDateToHourString:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    NSString *stringDate = [format stringFromDate:date];
    
    return stringDate;
}
+(NSString *)convertNSDateToDayString:(NSDate*)date;
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM"];
    NSString *stringDate = [format stringFromDate:date];
    
    return stringDate;
}
+(NSDate *)convertStringToDate:(NSString*)dateString
{
    return 0;
}

+(void)stopAlarm:(Alarm *)alarm{
    AlarmAudioPlayer * player = [AlarmAudioPlayer sharedAudioManager];
    if ([player.audioForNotificationName isEqualToString:alarm.notificationName]) {
        [player stopAlarm];
    }
}

+(NSDate *)dateWithZeroSeconds:(NSDate *)date
{
    NSTimeInterval time = floor([date timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:time];
}
+(NSString *)convert24HourTo12Hour:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *newDateString = [dateFormatter stringFromDate:date];
    return newDateString;
}
@end