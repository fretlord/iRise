//
//  AddAlarmViewController.m
//  iRise
//
//  Created by Chaitanya Rathi on 01/01/15.
//  Copyright (c) 2015 Chaitanya Rathi. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "AlarmDatabase.h"
#import "Alarm.h"
#import "iRiseUtility.h"

@interface AddAlarmViewController ()

@property(nonatomic ,strong) NSDate * datePicked;
@property(nonatomic, weak) IBOutlet UITextField * inputText;

@end

@implementation AddAlarmViewController

@synthesize datePicked,delegate,inputText;

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
    self.datePicked = [NSDate date];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Keyboard Methods
-(void)dismissKeyboard {
    
    [self.view endEditing:YES];
}
- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [self moveViewWithheight:keyboardFrameBeginRect.size.height-100.0];
    
}
- (void) keyboardWillHide:(NSNotification *)notification
{
    
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [self moveViewWithheight:-keyboardFrameBeginRect.size.height+100.0];
    
    
}

-(void)moveViewWithheight:(CGFloat)delta
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - delta , self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(IBAction)didSelectDate:(id)sender
{
    UIDatePicker * picker = (UIDatePicker *)sender;
    self.datePicked = [picker date];
}

-(IBAction)saveAlarmForTextField:(id)sender
{
    NSDate * date = [iRiseUtility convertStringToDate:inputText.text];
    Alarm * alarm = [[Alarm alloc] init];
    
    if (date) {
        alarm.date = [iRiseUtility dateWithZeroSeconds:date];
        alarm.snoozeDate = [iRiseUtility dateWithZeroSeconds:date];
        [AlarmDatabase saveAlarm:alarm];
        [self sendNotificationForAlarm:alarm];
        
    }else{
        
        NSString * inputString = inputText.text;        
        NSError * error;
        
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate
                                                                   error:&error];
        NSString *string = inputString;
        [detector enumerateMatchesInString:string
                                   options:kNilOptions
                                     range:NSMakeRange(0, [string length])
                                usingBlock:
         ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
             
             NSLog(@"Match: %@", result);
             NSDate * alarmDate = [result date];
            
             Alarm * alarm = [[Alarm alloc] init];
             alarm.date = [iRiseUtility dateWithZeroSeconds:alarmDate];
             alarm.snoozeDate = [iRiseUtility dateWithZeroSeconds:alarmDate];
             [AlarmDatabase saveAlarm:alarm];
             [self sendNotificationForAlarm:alarm];
             
             [delegate updateTableView];
             
             [self dismissViewControllerAnimated:YES completion:^{
                 
             }];
         }];
    }
}

-(IBAction)saveAlarm:(id)sender
{
    
    Alarm * alarm = [[Alarm alloc] init];
    alarm.date = [iRiseUtility dateWithZeroSeconds:self.datePicked];
    alarm.snoozeDate = [iRiseUtility dateWithZeroSeconds:self.datePicked];
    [AlarmDatabase saveAlarm:alarm];
    
    [self sendNotificationForAlarm:alarm];
    
    [delegate updateTableView];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(IBAction)done:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)sendNotificationForAlarm:(Alarm *)alarm{
    
    if ([[NSDate date] compare:alarm.date] == NSOrderedAscending)
        [alarm sendNotificationForDate:alarm.date];
    
}
@end
