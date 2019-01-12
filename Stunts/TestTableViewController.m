//
//  TestTableViewController.m
//  Stunts
//
//  Created by Richard Allen on 07/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "macros.h"
#import "TestTableViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


@interface TestTableViewController ()
{
    MBProgressHUD *hud;
    NSCountedSet *pending;
    NSCountedSet *approved;
    NSCountedSet *rejected;
    
    //Table Data
    NSMutableArray *names;
    NSMutableArray *nameCounts;
    
    
}
@end

@implementation TestTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    names = [[NSMutableArray alloc]init];
    nameCounts = [[NSMutableArray alloc]init];
    
    [self GetUsersWithCreditsPending];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)GetUsersWithCreditsPending
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Credits....";
    
    
    
    
}

-(void)SetTableDataFor:(NSCountedSet *)countedSet
{
    for (NSString *str in countedSet)
    {
        [names addObject:str];
        [nameCounts addObject:[NSNumber numberWithUnsignedLong:[countedSet countForObject:str]]];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return pending.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [names objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [nameCounts objectAtIndex:indexPath.row]];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}\
 
 
 
 
 
 -(void)GetUsersWithCreditsAthorised
 {
 hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 hud.label.text = @"Getting Credits....";
 
 if (!approved) {
 approved = [[NSMutableArray alloc]init];
 }
 PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
 [query orderByAscending:@"User"];
 [query whereKey:@"State" equalTo:@"Approved"];
 query.limit = 100;
 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 if (!error) {
 // The find succeeded.
 NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
 
 
 for (PFObject *object in objects) {
 PFUser *user = [object[@"User"] fetch];
 NSLog(@"%@", user[@"Name"]);
 
 NSMutableDictionary *currentUsersCredits = [self GetCreditsForUser:object[@"User"] inCredits:objects];
 [approved addObject:currentUsersCredits];
 }
 [hud hideAnimated:YES];
 [self.tableView reloadData];
 
 } else {
 // Log details of the failure
 NSLog(@"Error: %@ %@", error, [error userInfo]);
 }
 }];
 }
 -(void)GetUsersWithCreditsRejected
 {
 hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 hud.label.text = @"Getting Credits....";
 
 if (!rejected) {
 rejected = [[NSMutableArray alloc]init];
 }
 PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
 [query orderByAscending:@"User"];
 [query whereKey:@"State" equalTo:@"Rejected"];
 query.limit = 100;
 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 if (!error) {
 // The find succeeded.
 NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
 
 for (PFObject *object in objects) {
 PFUser *user = [object[@"User"] fetch];
 NSLog(@"%@", user[@"Name"]);
 
 //Get List Of Users
 
 
 
 //                NSMutableDictionary *currentUsersCredits = [self GetCreditsForUser:object[@"User"] inCredits:objects];
 //                [rejected addObject:currentUsersCredits];
 }
 [hud hideAnimated:YES];
 [self.tableView reloadData];
 
 } else {
 // Log details of the failure
 NSLog(@"Error: %@ %@", error, [error userInfo]);
 }
 }];
 }
 
 
 
*/

@end
