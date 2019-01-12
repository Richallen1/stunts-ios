//
//  ProfileHeaderCellTableViewCell.h
//  Stunts
//
//  Created by Richard Allen on 07/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface ProfileHeaderCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *memberLevelView;
@property (weak, nonatomic) IBOutlet UILabel *memberLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellphoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UIButton *switchUnitsOfMeasureButton;
-(void)setUserLevel:(AccountType)type;
@end
