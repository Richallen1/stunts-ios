//
//  WeightPopoverController.h
//  Stunts
//
//  Created by Richard Allen on 02/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface WeightPopoverController : UIViewController

@property (nonatomic, strong) TestViewController *parent;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UITextField *unit1;
@property (nonatomic, strong) UITextField *unit2;

@end
