//
//  AlarmTableViewCell.h
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmTableViewCell : UITableViewCell

@property(nonatomic , weak) IBOutlet UILabel * timeLabel;
@property(nonatomic , weak) IBOutlet UILabel * dayLabel;

@end
