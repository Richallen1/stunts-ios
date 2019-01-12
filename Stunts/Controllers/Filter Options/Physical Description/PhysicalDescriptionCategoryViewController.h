//
//  PhysicalDecriptionLevel2ViewController.h
//  Stunts
//
//  Created by Richard Allen on 26/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalDescriptionViewController.h"

@interface PhysicalDescriptionCategoryViewController : UIViewController

@property (nonatomic, strong) NSString *descriptionCategory;
@property (nonatomic, weak) PhysicalDescriptionViewController *parent;

@end
