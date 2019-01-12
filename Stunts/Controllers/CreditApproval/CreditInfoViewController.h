//
//  CreditInfoViewController.h
//  Stunts
//
//  Created by Richard Allen on 29/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CreditApprovalViewController.h"

@interface CreditInfoViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *credits;
@property (nonatomic, strong) CreditApprovalViewController *parent;

@end
