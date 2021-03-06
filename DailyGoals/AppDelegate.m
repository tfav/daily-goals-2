//
//  AppDelegate.m
//  DailyGoals
//
//  Created by Travis Favaron on 2/6/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import "AppDelegate.h"
#import "GoalListViewController.h"
#import "AddGoalViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if(![standardUserDefaults boolForKey:@"hasSeenTutorial"]){ //this 'if statement' checks to see if welcome view controller has been viewed before and sets the root view controller to the welcome screen or the goal list screen accordingly.
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"hasSeenTutorial"];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
        self.window.rootViewController = viewController;
    } else {
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GoalListViewController"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
        self.window.rootViewController = viewController;
    }
    [standardUserDefaults synchronize]; // syncronize stnadardUserDefaults so 'hasSeenTutorial' will be remembered upon next app opening
    
    [self.window makeKeyAndVisible]; // commit assigned root view controller to storyboad
    
    // BEGIN default code for PARSE push notifications. Two additional methods are added below: didRegisterForRemoteNotificationsWithDeviceToken and didReceiveRemoteNotification
    [Parse setApplicationId:@"6PXvfKefTbIqaanI6dxXTdnNCIYrF1HIteeWIey5"
                  clientKey:@"Qn6QwfOBeF9fiHji7NgLhbJFGoGA54z7FdwRU5ym"]; // these ID's need to be updated 2/16/14
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    // Override point for customization after application launch.
    

    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
   //Pick the time to set the notification for, currently hard coded in.
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    [components setHour:9];
    [components setMinute:0];
    
    //The actual notification, receives time to send from above.
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.repeatInterval = NSDayCalendarUnit;
    [notification setAlertBody:@"Have you set your goals for today?"];
    [notification setFireDate: [calendar dateFromComponents:components]];
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [application setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DailyGoals" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DailyGoals.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

#pragma mark - Get all Goals
-(NSArray *)getAllGoals
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GoalEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchedGoals = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedGoals;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
