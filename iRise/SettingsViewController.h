//
//  SettingsViewController.h
//  iRise
//
//  Created by Chaitanya Rathi on 31/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAlarmViewController.h"

@interface SettingsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AddAlarmDelegate>


@property (nonatomic , weak) IBOutlet UITableView * alarmTableView;


@end
