//
//  OnboardingViewController.h
//  Stunts
//
//  Created by Richard Allen on 31/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardingViewController : UIViewController

/****************************
 Varible Type: int
 Varible Name: accountType
****************************/
@property () int accountType;

@property (nonatomic, strong) NSMutableDictionary *userCredentials;

@end
