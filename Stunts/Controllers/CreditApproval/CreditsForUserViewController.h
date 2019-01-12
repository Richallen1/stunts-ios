//
//  CreditsForUserViewController.h
//  Stunts
//
//  Created by Richard Allen on 07/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditApprovalViewController.h"
#import <Parse/Parse.h>

@interface CreditsForUserViewController : UIViewController

@property (nonatomic, strong) CreditApprovalViewController *parent;
@property (nonatomic, strong) PFUser *selectedUser;

@end
