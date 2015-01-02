//
//  AddAlarmViewController.h
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddAlarmDelegate <NSObject>

-(void)updateTableView;

@end

@interface AddAlarmViewController : UIViewController

@property(nonatomic, weak) id <AddAlarmDelegate> delegate;


@end
