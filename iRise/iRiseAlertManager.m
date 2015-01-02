//
//  iRiseAlertManager.h
//  iRise
//
//  Created by Chaitanya Rathi on 30/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

#import "iRiseAlertManager.h"

#define WoloAppDelegateObject() ([[UIApplication sharedApplication] delegate])

@interface iRiseAlertManager() <UIAlertViewDelegate>


@property(nonatomic ,strong) UIAlertView  *alertView;


@end



@implementation iRiseAlertManager

@synthesize alertView,alertViewResponse;

/*
 Static Method For creating Singleton Object
 */
+ (instancetype)sharedAlertManager
{
    static iRiseAlertManager *sharedMyManager = nil;
    if(!sharedMyManager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedMyManager = [[super allocWithZone:nil] init];
//            alertView = [[UIAlertView alloc] init];
        });
    }
    
    return sharedMyManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andResponse:(AlertViewResponse)response;
{
    // Checking if AlertView is Visible or not
    if (alertView.visible) {
        return;
    }

    // Assingin alert view block
    alertViewResponse = response;
    
    if (alertView) {
        alertView = nil;
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Snooze", nil];
        alertView.delegate = self;
        [alertView show];
        
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Snooze", nil];
        alertView.delegate = self;
        [alertView show];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    alertViewResponse(buttonIndex);
    

}
@end
