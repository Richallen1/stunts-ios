//
//  ProfileTableViewController.h
//  Stunts
//
//  Created by Richard Allen on 07/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
#import <Parse/Parse.h>
#import "Members.h"

@interface ProfileTableViewController : UITableViewController

/*Selected Parse Profile */
@property (nonatomic, strong)  Members *selectedMember;

//@property (nonatomic, strong) Member *selectedProfile;

-(void)AddNewList;

@end
