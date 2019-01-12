//
//  AddToListViewController.h
//  Stunts
//
//  Created by Richard Allen on 22/08/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileTableViewController.h"

@interface AddToListViewController : UIViewController

@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) ProfileTableViewController *profileParent;
@end
