//
//  AddToListViewController.m
//  Stunts
//
//  Created by Richard Allen on 22/08/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import <Parse/Parse.h>
#import "AddToListViewController.h"
#import "AppDelegate.h"
#import "AppImports.h"
#import "NewListViewController.h"
#import "MBProgressHUD.h"


@interface AddToListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *backgroundDarkView;
    UIView *popoverView;
    __block NSMutableArray *lists;
    AppDelegate *appDelegate;
    IBOutlet UITableView *listTableView;
    NewListViewController *popoverViewController;
    MBProgressHUD *hud;
}
@end

@implementation AddToListViewController
@synthesize lists;
@synthesize profileParent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate and Data Source.
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
    PFObject *list = [lists objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = list[@"name"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *list = [lists objectAtIndex:indexPath.row];
    [self AddUsersToList:list];
}


#pragma mark List Info
-(IBAction)Done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)AddNewList:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [profileParent AddNewList];
}

-(void)AddUsersToList:(PFObject *)list
{
    NSLog(@"%@", list);
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving List..";
    NSMutableArray *membersOfList = list[@"members"];
    
    if(!membersOfList){
        membersOfList = [NSMutableArray array];
    }
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [membersOfList addObject:profileParent.selectedMember.objectId];
        list[@"members"] = membersOfList;
    }];
    
    [hud hideAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}


@end

