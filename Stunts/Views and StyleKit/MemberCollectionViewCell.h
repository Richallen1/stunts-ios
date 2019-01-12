//
//  MemberCollectionViewCell.h
//  Stunts
//
//  Created by Richard Allen on 28/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Members.h"

@interface MemberCollectionViewCell : UICollectionViewCell

//Member Image Container
@property (nonatomic, strong) UIView *memberImageContainer;

//Member Image
@property (nonatomic, strong) UIImageView *memberImage;

//Checkbox
@property (nonatomic, strong) UIButton *selectUserButton;

//Member Name
@property (nonatomic, strong) UILabel *memberName;

//Member Type
@property () int memberType;

//Member User Object
@property (nonatomic, strong) PFUser *user;

@property (nonatomic, strong) Members * member;

@property (nonatomic, strong) UIView *memberBadgeView;
@property (nonatomic, strong) UILabel *memberLabel;


@end
