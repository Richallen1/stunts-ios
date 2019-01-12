//
//  AboutMeViewController.h
//  Stunts
//
//  Created by Richard Allen on 03/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface EditAboutMeViewController : UIViewController

@property (nonatomic, strong) PFObject *member;

@property (nonatomic, strong) PFObject *Profile;

@end
