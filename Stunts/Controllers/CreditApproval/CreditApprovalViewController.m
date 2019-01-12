//
//  CreditApprovalViewController.m
//  Stunts
//
//  Created by Richard Allen on 29/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "CreditApprovalViewController.h"
#import <Parse/Parse.h>
#import "CreditInfoViewController.h"
#import "MBProgressHUD.h"
#import "CreditsForUserViewController.h"

@interface CreditApprovalViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{


    MBProgressHUD *hud;
    __weak IBOutlet UISearchBar *memberSearchBox;
    
    NSCountedSet *pending;
    NSCountedSet *approved;
    NSCountedSet *rejected;
    
    //Table Data
    NSMutableArray *names;
    NSMutableArray *nameCounts;
    NSMutableArray *userObjs;
    
    //Search
    NSCountedSet *searchResults;
    BOOL isSearched;
    
    NSString *selectedUserName;
    //PFObject *selectedUser;
    
}
@end

@implementation CreditApprovalViewController
@synthesize credits;
@synthesize creditTableView;
@synthesize segmentControl;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSearched = NO;
    
    names = [[NSMutableArray alloc]init];
    nameCounts = [[NSMutableArray alloc]init];
    userObjs = [[NSMutableArray alloc]init];
    
    [segmentControl addTarget:self
                         action:@selector(segmentChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    memberSearchBox.delegate = self;
    
    [self GetUsersWithCreditsPending];
    
}

-(void)GetUsersWithCreditsPending
{
    [userObjs removeAllObjects];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Credits....";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
    [query orderByAscending:@"User"];
    [query whereKey:@"State" equalTo:@"Pending"];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
            credits = [NSMutableArray arrayWithArray:objects];
            pending = [[NSCountedSet alloc] init];
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
                PFUser *user = [object[@"User"] fetch];
                
                [userObjs addObject:user];
                [pending addObject:user[@"Name"]];
                
            }
            [self SetTableDataFor:pending];
            [hud hideAnimated:YES];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)GetUsersWithCreditsApproved
{
    [userObjs removeAllObjects];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Credits....";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
    [query orderByAscending:@"User"];
    [query whereKey:@"State" equalTo:@"Approved"];
    [query includeKey:@"Member"];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
            credits = [NSMutableArray arrayWithArray:objects];
            approved = [[NSCountedSet alloc] init];
            for (PFObject *object in objects) {
                PFObject *user = object[@"Member"];
                if(user){
                    [userObjs addObject:user];
                    [approved addObject:user[@"Name"]];
                }
                
            }
            [self SetTableDataFor:approved];
            [hud hideAnimated:YES];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)GetUsersWithCreditsRejected
{
    [userObjs removeAllObjects];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Credits....";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
    [query orderByAscending:@"User"];
    [query whereKey:@"State" equalTo:@"Rejected"];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
            credits = [NSMutableArray arrayWithArray:objects];
            rejected = [[NSCountedSet alloc] init];
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
                PFUser *user = [object[@"User"] fetch];
                
                [userObjs addObject:user];
                [rejected addObject:user[@"Name"]];
                
            }
            [self SetTableDataFor:rejected];
            [hud hideAnimated:YES];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)SetTableDataFor:(NSCountedSet *)countedSet
{
    NSLog(@"%@", countedSet);
    [names removeAllObjects];
    [nameCounts removeAllObjects];
    for (NSString *str in countedSet)
    {
        [names addObject:str];
        [nameCounts addObject:[NSNumber numberWithUnsignedLong:[countedSet countForObject:str]]];
    }
    [creditTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchResults)
    {
        return searchResults.count;
    }
    
    return names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    cell.textLabel.font = labelFont;
    cell.detailTextLabel.font = labelFont;

    cell.textLabel.text = [names objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [nameCounts objectAtIndex:indexPath.row]];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [creditTableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedUserName = [names objectAtIndex:indexPath.row];
    //selectedUser = [userObjs objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"show-credit-detail" sender:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentChanged:(UISegmentedControl *)control
{
    switch (control.selectedSegmentIndex)
    {
        case 0:
        {
            if (pending.count != 0)
            {
                NSLog(@"%@", pending);
                [self SetTableDataFor:pending];
            }
            else
            {
                [self GetUsersWithCreditsPending];
            }
            
        }
            break;
        case 1:
        {
            if (approved.count != 0)
            {
                [self SetTableDataFor:approved];
            }
            else
            {
                [self GetUsersWithCreditsApproved];
            }
        }
            break;
        case 2:
        {
            if (rejected.count != 0)
            {
                [self SetTableDataFor:rejected];
            }
            else
            {
                [self GetUsersWithCreditsRejected];
            }
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - Search
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchResults = [[NSCountedSet alloc]init];

    switch (segmentControl.selectedSegmentIndex)
    {
        case 0:
        {
            for (NSString *member in pending)
            {
                NSRange range = [member rangeOfString:@" " options:NSBackwardsSearch];
                NSString *result = [member substringFromIndex:range.location+1];
                
                if ([result isEqualToString:searchBar.text])
                {
                    [searchResults addObject:member];
                }
                
            }
            [self SetTableDataFor:searchResults];
        }
            break;
        case 1:
        {
            for (NSString *member in approved)
            {
                if ([member isEqualToString:searchBar.text])
                {
                    [searchResults addObject:member];
                }
            }
            [self SetTableDataFor:searchResults];
        }
            break;
        case 2:
        {
            for (NSString *member in rejected)
            {
                if ([member isEqualToString:searchBar.text])
                {
                    [searchResults addObject:member];
                }
            }
            [self SetTableDataFor:searchResults];
        }
            break;

        default:
            break;
    }
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    searchResults = nil;
    [searchBar resignFirstResponder];
    
    switch (segmentControl.selectedSegmentIndex)
    {
        case 0:
        {
            [self SetTableDataFor:pending];
        }
            break;
        case 1:
        {
            [self SetTableDataFor:approved];
        }
            break;
        case 2:
        {
            [self SetTableDataFor:rejected];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"show-credit-detail"])
    {
        
        CreditInfoViewController *vc = segue.destinationViewController;
        NSMutableArray *creditsForUser = [[NSMutableArray alloc]init];
        for (PFObject *cred in credits)
        {
            PFObject *credUser = cred[@"Member"];
            if ([credUser[@"Name"] isEqualToString:selectedUserName])
            {
                [creditsForUser addObject:cred];
            
            }
            vc.credits = creditsForUser;
            vc.parent = self;
        }
    }
    
    if ([segue.identifier isEqualToString:@"show-credit-for-user"])
    {
//        CreditsForUserViewController *vc = segue.destinationViewController;
//        vc.selectedUser = selectedUser;
//        vc.parent = self;
    }
    
}


@end
