//
//  GoalListViewController.h
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalListTableViewController.h"

@interface GoalListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *goalItems;

-(void)addCancelButton;

@end
