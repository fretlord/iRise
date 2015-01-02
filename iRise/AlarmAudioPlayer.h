//
//  AlarmAudioPlayer.h
//  iRise
//
//  Created by Chaitanya Rathi on 02/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AlarmAudioPlayer : NSObject <AVAudioPlayerDelegate>

@property(nonatomic , strong) NSString * audioForNotificationName;

+(id)sharedAudioManager;

-(void)playAlarm:(NSString *)name;

-(void)stopAlarm;

@end
