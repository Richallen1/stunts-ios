//
//  MemberCollectionViewCell.m
//  Stunts
//
//  Created by Richard Allen on 28/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "macros.h"
#import "MemberCollectionViewCell.h"

@implementation MemberCollectionViewCell
@synthesize memberImageContainer;
@synthesize memberImage;
@synthesize selectUserButton;
@synthesize memberName;
//@synthesize memberType;
@synthesize user;
@synthesize memberLabel;
@synthesize memberBadgeView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //nonatomicContainer
        memberImageContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 170, 170)];
        memberImageContainer.backgroundColor = UIColorFromRGB(0XEFEFF3);
        memberImageContainer.layer.cornerRadius = 5;
        memberImageContainer.clipsToBounds = YES;
        
        
        //Member Image
        memberImage = [[UIImageView alloc]initWithFrame:CGRectMake(memberImageContainer.frame.size.width/2-75, memberImageContainer.frame.size.height/2-75, 150, 150)];
        [memberImageContainer addSubview:memberImage];
        
        
        //Checkbox
        selectUserButton = [[UIButton alloc]initWithFrame:CGRectMake(memberImageContainer.frame.size.width-25, 5, 20, 20)];
        [selectUserButton setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
        selectUserButton.hidden = YES;
        [memberImageContainer addSubview:selectUserButton];
        
        [self addSubview:memberImageContainer];
        
        //Member Name
        memberName = [[UILabel alloc]initWithFrame:CGRectMake(12, 172, self.frame.size.width-12, 20)];
        memberName.font = [UIFont fontWithName:@"SFProText-Light" size:16];
        memberName.textColor = UIColorFromRGB(0XAC3EF9);
        
        [self addSubview:memberName];
        
        //Member Type Badge
        memberBadgeView = [[UIView alloc]initWithFrame:CGRectMake(9, 195, 100, 20)];
        memberBadgeView.layer.cornerRadius = 8;
        memberBadgeView.clipsToBounds = YES;
        
        memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 90, 20)];
        memberLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
        memberLabel.textColor = [UIColor whiteColor];
        memberLabel.textAlignment = NSTextAlignmentCenter;

        
        [memberBadgeView addSubview:memberLabel];
        [self addSubview:memberBadgeView];
    
    }
    return self;
}

-(void)setMemberType:(int)type
{
    NSLog(@"Member Type: %d", type);
    switch (type) {
        case 0:
            //Full Member
            memberBadgeView.backgroundColor = UIColorFromRGB(0xDD3131);
            memberLabel.text = @"Probationary";
            break;
        case 1:
            //Intermediate
            memberBadgeView.backgroundColor = UIColorFromRGB(0xEF931F);
            memberLabel.text = @"Intermediate";
            break;
        case 2:
            //Probationary
            memberBadgeView.backgroundColor = UIColorFromRGB(0x66CB63);
            memberLabel.text = @"Full Member";
            break;
            
        default:
            break;
    }
}
@end
