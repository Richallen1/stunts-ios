//
//  SigninSelectViewController.m
//  Stunts
//
//  Created by Richard Allen on 02/10/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "SigninSelectViewController.h"
#import "SignInViewController.h"

@interface SigninSelectViewController ()
{
    int accountType;
}
@end

@implementation SigninSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}

-(IBAction)PerformMemberSignup:(id)sender
{
    accountType = 0;
    [self performSegueWithIdentifier:@"login-segue" sender:self];
}

-(IBAction)PerformProductionSignup:(id)sender
{
    accountType = 1;
    [self performSegueWithIdentifier:@"login-segue" sender:self];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"login-segue"])
    {
        SignInViewController *vc = segue.destinationViewController;
        vc.accountType = accountType;
    }
}



@end
