//
//  AddGoalViewController.h
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GoalItem.h"
#import "AppDelegate.h"
#import "GoalEntity.h"

@interface AddGoalViewController : UIViewController

//@property GoalItem *goalItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
- (IBAction)saveData:(id)sender;


//Working with Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
