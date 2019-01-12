//
//  PhysicalDescriptionViewController.h
//  Stunts
//
//  Created by Richard Allen on 21/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptionsViewController.h"

@interface PhysicalDescriptionViewController : UIViewController

@property (nonatomic, weak) FilterOptionsViewController *parent;
@property (nonatomic, strong) NSMutableDictionary *physicalFilterSelections;

@end
