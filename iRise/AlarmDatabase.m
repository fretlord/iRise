//
//  AlarmDatabase.m
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import "AlarmDatabase.h"
#import "AppDelegate.h"
#import "AlarmAudioPlayer.h"

@implementation AlarmDatabase

+(NSString *)getDocumentDirectory {
    
    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"resourceName.extension"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Alarms"];

    NSFileManager * fm = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exists = [fm fileExistsAtPath:documentsDirectory isDirectory:&isDir];
    if (!exists) {
        
        NSError * error;
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return documentsDirectory;
    
}

+(NSString *)nextAlarmName{
    
    NSString * documentsDirectory = [self getDocumentDirectory];
    
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    int maxNumber = 0;
    for (NSString *file in files) {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
    }
    NSString *availableName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist", maxNumber+1]];
    
    return availableName;
}


+(NSMutableArray *)retrieveAlarms
{
    NSString *documentsDirectory = [self getDocumentDirectory];
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    NSMutableArray * alarmArray = [[NSMutableArray alloc] init];

    for (NSString * file in files) {
        if ([file.pathExtension compare:@"plist" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            Alarm * currentAlarm = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
            currentAlarm.dbPath = fullPath;
            [alarmArray addObject:currentAlarm];
        }
    }
    return alarmArray;
}
+(void)deleteAlarm:(Alarm *)alarm
{
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:alarm.dbPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
}
+(void)saveAlarm:(Alarm *)alarm
{
    NSString * documentsDirectoryPath = [self nextAlarmName];
    alarm.dbPath = documentsDirectoryPath;
    alarm.notificationName = documentsDirectoryPath;
    [NSKeyedArchiver archiveRootObject:alarm toFile:documentsDirectoryPath];
    
}

+(void)updateAlarm:(Alarm *)alarm
{
    [NSKeyedArchiver archiveRootObject:alarm toFile:alarm.dbPath];
}


+(Alarm *)retrieveAlarmWithName:(NSString *)alarmName
{
    NSString *documentsDirectory = [self getDocumentDirectory];
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    Alarm * retrievedAlarm = [[Alarm alloc] init];
    
    for (NSString * file in files) {
        if ([file.pathExtension compare:@"plist" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            Alarm * currentAlarm = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
            if ([currentAlarm.notificationName isEqualToString:alarmName]) {
                retrievedAlarm = currentAlarm;
            }
        }
    }
    return retrievedAlarm;

}
@end
