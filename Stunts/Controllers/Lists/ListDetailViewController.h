//
//  ListDetailViewController.h
//  Stunts
//
//  Created by Richard Allen on 19/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "List.h"

@interface ListDetailViewController : UIViewController

@property (nonatomic, strong) List *list;
@property (nonatomic, strong) NSMutableArray *lists;

@end
