//
//  CreditsForUserViewController.m
//  Stunts
//
//  Created by Richard Allen on 07/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "CreditsForUserViewController.h"


@interface CreditsForUserViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *creditsToShow;
    IBOutlet UITableView *creditsTableView;
    __weak IBOutlet UILabel *memberNameLabel;
    PFObject *selectedCredit;
}
@end

@implementation CreditsForUserViewController
@synthesize parent;
@synthesize selectedUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    creditsToShow = [[NSMutableArray alloc]init];
    //Get Credits for user
    for (PFObject *cred in parent.credits)
    {
        PFUser *credUser = cred[@"User"];
        if ([credUser[@"Name"] isEqualToString:selectedUser[@"Name"]])
        {
            [creditsToShow addObject:cred];
        }
    }
    [creditsTableView reloadData];
    
    memberNameLabel.text = [NSString stringWithFormat:@"For %@",  selectedUser[@"Name"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return creditsToShow.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    cell.textLabel.font = labelFont;
    cell.detailTextLabel.font = labelFont;
    
    PFObject *currentCredit = [creditsToShow objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentCredit[@"Production"];
    cell.detailTextLabel.text = currentCredit[@"State"];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
