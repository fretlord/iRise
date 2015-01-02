//
//  Alarm.m
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import "Alarm.h"
#import "AlarmAudioPlayer.h"

@implementation Alarm

@synthesize date,isActive,notificationName,dbPath,snoozeDate;


-(id)init{
    
    self = [super init];
    
    if (self) {
        isActive = YES;
    }
    return self;
    
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        date = [coder decodeObjectForKey:@"time"];
        snoozeDate = [coder decodeObjectForKey:@"snooze"];
        isActive = [coder decodeBoolForKey:@"isActive"];
        notificationName = [coder decodeObjectForKey:@"notificationName"];
        dbPath = [coder decodeObjectForKey:@"dbPath"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:date forKey:@"time"];
    [coder encodeObject:snoozeDate forKey:@"snooze"];
    [coder encodeBool:isActive forKey:@"isActive"];
    [coder encodeObject:notificationName forKey:@"notificationName"];
    [coder encodeObject:dbPath forKey:@"dbPath"];

}

-(void)sendNotificationForDate:(NSDate *)datePicked
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil){
        
        NSLog(@"It was nill");
        return;
    }
    
    localNotif.fireDate = datePicked;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // Notification details
    localNotif.alertBody = @"Time to get up!";
    // Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = @"out.caf";
    
    // Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:self.notificationName forKey:@"notificationName"];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

-(void)stopAlarm
{    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *oldNotifications = [app scheduledLocalNotifications];
    
    // Clear out the old notification
    for (UILocalNotification * notification in oldNotifications) {
        NSLog(@"User info for this notification is %@",[notification userInfo] );
        if ([[[notification userInfo]valueForKey:@"notificationName"] isEqualToString:self.notificationName]) {
            [app cancelLocalNotification:notification];
        }
    }
    AlarmAudioPlayer * player = [AlarmAudioPlayer sharedAudioManager];
    [player stopAlarm];
}

-(void)snoozeAlarm
{
    [self stopAlarm];
    if ([[NSDate date] compare:self.date] == NSOrderedAscending)
        [self sendNotificationForDate:self.snoozeDate];
}

@end
