//
//  GoalEntity.h
//  DailyGoals
//
//  Created by Travis Favaron on 2/10/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GoalEntity : NSManagedObject

@property (nonatomic, retain) NSString * goalName;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSDate * creationDate;

@end
