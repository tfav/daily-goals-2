//
//  AddGoalViewController.m
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import "AddGoalViewController.h"

@interface AddGoalViewController ()

@end

@implementation AddGoalViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if (sender != self.addButton) return;
//    if (self.textField.text.length > 0) {
//        self.goalItem = [[GoalItem alloc] init];
//        self.goalItem.goalName = self.textField.text;
//        self.goalItem.completed = NO;
//    }
    
    //CData Work
    
    if (sender !=self.addButton) return;
    if (self.textField.text.length > 0) {
        GoalEntity *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"GoalEntity" inManagedObjectContext:self.managedObjectContext];
        newEntry.goalName = self.textField.text;
        newEntry.isCompleted = NO;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save %@", [error localizedDescription]);
        }
        self.textField.text = @"";
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    
    
    
   //Set Background Logic
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh"];
    NSString *resultStringHour = [dateFormatter stringFromDate: currentTime];
    [dateFormatter setDateFormat:@"a"];
    NSString *resultStringAMPM = [dateFormatter stringFromDate: currentTime];
    
    // sets background to be blue between 2 AM and 10 AM, Red between 10AM and 6PM, and Purple between 6PM and 2am
    if ([resultStringHour intValue] >= 6 && [resultStringHour intValue] <= 9 && [resultStringAMPM isEqualToString: @"AM"])
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"morningBG.png"]];
    }
    else if(([resultStringHour intValue] >= 10 && [resultStringAMPM isEqualToString: @"AM"]) || ([resultStringHour intValue] <= 6 && [resultStringAMPM isEqualToString: @"PM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dayBG.png"]];
    }
    else if(([resultStringHour intValue] >= 7 && [resultStringAMPM isEqualToString: @"PM"]) || ([resultStringHour intValue] <= 5 && [resultStringAMPM isEqualToString: @"AM"]) || ([resultStringHour intValue] == 12 && [resultStringAMPM isEqualToString: @"AM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nightBg.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveData:(id)sender {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    //get date to add to the goal object
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newGoal;
    newGoal = [NSEntityDescription
               insertNewObjectForEntityForName:@"GoalEntity"
               inManagedObjectContext:context];
    [newGoal setValue: _textField.text forKey:@"goalName"];
    [newGoal setValue: NO forKey:@"isCompleted"];
    [newGoal setValue: currentTime forKey:@"creationDate"];
    _textField.text = @"";
    
    NSError *error;
    [context save:&error];
}
@end
