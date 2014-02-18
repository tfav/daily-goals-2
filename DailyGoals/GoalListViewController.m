//
//  GoalListViewController.m
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import "GoalListViewController.h"
#import "GoalItem.h"
#import "GoalListTableViewController.h"
#import "AddGoalViewController.h"

@interface GoalListViewController ()

@end

@implementation GoalListViewController


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
    
    //set welcome/intro page as viewed so it won't appear again.
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    
    
    //TF
    //Set nav bar to transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}]; //set title to white color
    
    
	// Do any additional setup after loading the view.
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

-(void)addCancelButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:self.editButtonItem.style target:self action:@selector(editCanceled)];
    NSLog(@"Cancel button should be added.");
    
}

-(void)editCanceled {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
