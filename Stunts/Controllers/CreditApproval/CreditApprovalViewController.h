//
//  CreditApprovalViewController.h
//  Stunts
//
//  Created by Richard Allen on 29/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditApprovalViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *credits;

@property (nonatomic, strong) IBOutlet UITableView *creditTableView;

@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentControl;


-(void)GetUsersWithCreditsPending;
-(void)GetUsersWithCreditsApproved;
-(void)GetUsersWithCreditsRejected;

@end
