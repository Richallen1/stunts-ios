//
//  ProfileHeaderCellTableViewCell.m
//  Stunts
//
//  Created by Richard Allen on 07/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "macros.h"
#import "ProfileHeaderCellTableViewCell.h"

@implementation ProfileHeaderCellTableViewCell
@synthesize memberLevelView;
@synthesize cellphoneButton;
@synthesize emailButton;
@synthesize userImage;
@synthesize memberName;
@synthesize memberLevelLabel;
@synthesize switchUnitsOfMeasureButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    memberLevelView.layer.cornerRadius = 10;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserLevel:(AccountType)type
{
    switch (type) {
        case Probationary:
            memberLevelView.backgroundColor = UIColorFromRGB(0xDD3131);
            memberLevelLabel.text = @"Probationary";
            break;
        case Intermediate:
            memberLevelView.backgroundColor = UIColorFromRGB(0xEF931F);
            memberLevelLabel.text = @"Intermediate";
            break;
        case FullMember:
            memberLevelView.backgroundColor = UIColorFromRGB(0x66CB63);
            memberLevelLabel.text = @"Full Member";
            break;
            
        default:
            break;
    }
}
@end
