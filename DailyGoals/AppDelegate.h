//
//  AppDelegate.h
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//
// With gitignore?


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSArray *)getAllGoals;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
