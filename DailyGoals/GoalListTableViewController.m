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

@interface GoalListTableViewController ()
@property (nonatomic, strong) NSArray *fetchedGoalsArray;
@property NSMutableArray *goalItems;

@end

@implementation GoalListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
//    AddGoalViewController *source = [segue sourceViewController];
//    GoalItem *item = source.goalItem;
//    if (item != nil) {
//        [self.goalItems addObject:item];
//        [self.tableView reloadData];
//    }
   
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.fetchedGoalsArray = [appDelegate getAllGoals];
    [self.tableView reloadData];

}

//-(void)loadInitialData {
//    GoalItem *item1 = [[GoalItem alloc] init];
//    item1.goalName = @"This is an initial item. Hardcoded in. What happens if it is too long?";
//    [self.goalItems addObject:item1];
//
//}

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
//    self.goalItems = [[NSMutableArray alloc]init];
//    [self loadInitialData];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.fetchedGoalsArray = [appDelegate getAllGoals];
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
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
    
    GoalEntity *goalItem = [self.fetchedGoalsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = goalItem.goalName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditGoalViewController *editController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditGoalViewControllerIdentifier"];
    editController.selectedGoal = [self.fetchedGoalsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editController animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
