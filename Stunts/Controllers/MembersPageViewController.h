//
//  MembersPageViewController.h
//  Stunts
//
//  Created by Peter Rocker on 07/02/2019.
//  Copyright © 2019 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Members.h"

NS_ASSUME_NONNULL_BEGIN

@interface MembersPageViewController : UIPageViewController

@property (nonatomic, strong) NSMutableArray* members;
@property (nonatomic, strong) Members* selectedMember;

@end

NS_ASSUME_NONNULL_END
