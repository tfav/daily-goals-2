//
//  GoalItem.h
//  DailyGoals
//
//  Created by Travis Favaron on 2/9/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoalItem : NSObject

@property (nonatomic, strong) NSString *goalName;
@property BOOL completed;
@property (nonatomic, strong) NSDate *goalDate;
@property (readonly) NSDate *creationDate;

@end
