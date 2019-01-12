//
//  FilterOptionsViewController.h
//  Stunts
//
//  Created by Richard Allen on 21/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembersCollectionViewController.h"

@interface FilterOptionsViewController : UIViewController

@property (nonatomic,strong) NSMutableDictionary *filterChoices;
@property (nonatomic, strong) MembersCollectionViewController *parent;


@end
