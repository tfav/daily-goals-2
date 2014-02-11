//
//  GoalListTableViewController.m
//  DailyGoals
//
//  Created by Travis Favaron on 2/9/14.
//  Copyright (c) 2014 Travis Favaron. All rights reserved.
//

#import "GoalListTableViewController.h"
#import "GoalItem.h"
#import "AddGoalViewController.h"
#import "AppDelegate.h"
#import "GoalEntity.h"
#import "EditGoalViewController.h"
#import "GoalListViewController.h"


@interface GoalListTableViewController ()
@property (nonatomic, strong) NSArray *fetchedGoalsArray;
@property NSMutableArray *goalItems;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation GoalListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{

    //Get the goals from the delegate, then reload the data after we unwind from Add Goal Controller
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedGoalsArray = [appDelegate getAllGoals];

}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Part of core data, getting the managedObjectContext from the appDelegate
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //Allowing the array to be editable for deleting rows
    self.fetchedGoalsArray = [[appDelegate getAllGoals]mutableCopy];
    

}

//Reload the data in the table after the view appears again (for editing and creating)
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.fetchedGoalsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Get the goal data, then set the goal name to the title of the cell
    GoalEntity *goalItem = [self.fetchedGoalsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = goalItem.goalName;
    
    //Detect left swipe for delete mode
    UISwipeGestureRecognizer *gestureLeft =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rowSwiped)];
    [gestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:gestureLeft];

    UILongPressGestureRecognizer *longTapDetected = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapDetected)];
    [cell addGestureRecognizer:longTapDetected];

    return cell;
}


-(void)longTapDetected
{
    
}

//Enable editing when a row is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditGoalViewController *editController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditGoalViewControllerIdentifier"];
    editController.selectedGoal = [self.fetchedGoalsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editController animated:YES];
    
}

//Enter editing mode if the row is swiped...called in cellForRowAtIndexPath
-(void)rowSwiped

{
    self.tableView.editing = !self.tableView.editing;
//  NSLog(@"Swipe Detected!!");
    
}

//Set row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView beginUpdates];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.managedObjectContext deleteObject:[self.fetchedGoalsArray objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Couldn't delete %@", [error localizedDescription]);
        }
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        self.fetchedGoalsArray = [appDelegate getAllGoals];
        [self.tableView setEditing:NO animated:YES];
        [tableView endUpdates];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
