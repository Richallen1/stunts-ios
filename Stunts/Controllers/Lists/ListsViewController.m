//
//  ListsViewController.m
//  Stunts
//
//  Created by Richard Allen on 19/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "ListsViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "ListDetailViewController.h"
#import "List.h"

@interface ListsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *listsTableView;
    NSMutableArray *lists;
    List *selectedList;
    MBProgressHUD *hud;
}
@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self GetListsFromParse];
    [listsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    PFObject *list = [lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = list[@"name"];
    
    return cell;
}

-(void)GetListsFromParse
{
    lists = [[NSMutableArray alloc]init];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Lists";
    
    RLMResults<List *> * results = [List objectsWhere:@"author = %@",[PFUser currentUser].objectId];
    if(results != NULL){
        for(List * tmp in results){
            [lists addObject:tmp];
        }
        [listsTableView reloadData];
        [hud hideAnimated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedList = [lists objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"show-users-in-list" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        List *list = [lists objectAtIndex:indexPath.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] deleteObject:list];
            [hud hideAnimated:YES];
        }];
        hud.label.text = @"Deleting List";
        [lists removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show-users-in-list"])
    {
        //Segue to List info collectiion View
        ListDetailViewController *vc = segue.destinationViewController;
        vc.list = selectedList;
        vc.lists = lists;
    }
}


@end
