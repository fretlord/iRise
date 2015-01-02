//
//  SettingsViewController.m
//  iRise
//
//  Created by Chaitanya Rathi on 31/12/14.
//  Copyright (c) 2014 Chaitanya Rathi. All rights reserved.
//

#import "SettingsViewController.h"
#import "AlarmTableViewCell.h"
#import "AlarmDatabase.h"
#import "AlarmAudioPlayer.h"
#import "iRiseUtility.h"

@interface SettingsViewController () 

@property(nonatomic , strong) NSMutableArray * alarmArray;

@end

@implementation SettingsViewController

@synthesize alarmArray,alarmTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    alarmArray = [AlarmDatabase retrieveAlarms];
    
    alarmTableView.allowsMultipleSelectionDuringEditing = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Alarm"]) {

        [segue.destinationViewController setDelegate:(id)self];
    }
}

-(void)updateTableView{
    
    alarmArray = [AlarmDatabase retrieveAlarms];
    [alarmTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [alarmArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AlarmTableViewCell" owner:self options:nil];
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }

            [cell setLayoutMargins:UIEdgeInsetsZero];
        cell = (AlarmTableViewCell *)[nib objectAtIndex:0];
    }
    
    Alarm * currentAlarm = [alarmArray objectAtIndex:indexPath.row];
    
    cell.timeLabel.text = [iRiseUtility convert24HourTo12Hour:currentAlarm.date];


    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Alarm * toDeleteAlarm = [alarmArray objectAtIndex:indexPath.row];
        [toDeleteAlarm stopAlarm];
        
        [AlarmDatabase deleteAlarm:[alarmArray objectAtIndex:indexPath.row]];
        [alarmArray removeObjectAtIndex:indexPath.row];
        [alarmTableView reloadData];
    }
}

#pragma mark - Button Actions
-(IBAction)dismissController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}





@end
