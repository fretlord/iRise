//
//  iRiseAlertManager.h
//  iRise
//
//  Created by Chaitanya Rathi on 30/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iRiseAlertManager : NSObject

typedef void (^AlertViewResponse) (int clickedButtonIndex);


@property (nonatomic, strong) AlertViewResponse alertViewResponse;


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andResponse:(AlertViewResponse)response;

+ (id)sharedAlertManager;

@end
