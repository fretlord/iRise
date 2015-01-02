//
//  AlarmAudioPlayer.m
//  iRise
//
//  Created by Chaitanya Rathi on 02/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import "AlarmAudioPlayer.h"

@interface AlarmAudioPlayer ()

@property(nonatomic, strong) AVAudioPlayer * audioPlayer;

@end

@implementation AlarmAudioPlayer

@synthesize audioPlayer,audioForNotificationName;

+(id)sharedAudioManager{
    
    static AlarmAudioPlayer * audioManager = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        audioManager = [[AlarmAudioPlayer alloc] init];
    });
    return audioManager;
}

-(void)playAlarm:(NSString *)name
{
    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:name ofType:@"caf"];
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
    
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:backgroundMusicURL error:&error];
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
-(void)stopAlarm
{
    [audioPlayer stop];
}
@end
