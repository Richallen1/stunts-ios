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
        case 0:
            memberLevelView.backgroundColor = UIColorFromRGB(0xff66cc);
            memberLevelLabel.text = @"Probationary";
            break;
        case 1:
            memberLevelView.backgroundColor = UIColorFromRGB(0xff6633);
            memberLevelLabel.text = @"Stunt Performer";
            break;
        case 2:
            memberLevelView.backgroundColor = UIColorFromRGB(0xdfb610);
            memberLevelLabel.text = @"Senior Stunt Performer";
            break;
        case 3:
            memberLevelView.backgroundColor = UIColorFromRGB(0x33cc99);
            memberLevelLabel.text = @"Key Stunt Performer";
            break;
        case 4:
            memberLevelView.backgroundColor = UIColorFromRGB(0x92d050);
            memberLevelLabel.text = @"Full Member";
            break;
            
        default:
            break;
    }
}
@end
