//
//  Profile.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "Profile.h"

@implementation Profile

@synthesize objectId;
@synthesize sex;
@synthesize HairLength;
@synthesize HairColour;
@synthesize FacialHair;
@synthesize HairLengthColour;
@synthesize EyeColour;
@synthesize uid;
@synthesize Images;
@synthesize skills;
@synthesize Weight;
@synthesize Height;
@synthesize InsideArm;
@synthesize Waist;
@synthesize Chest;
@synthesize ShoeSizeUK;
@synthesize Hips;
@synthesize InsideLeg;
@synthesize Hat;
@synthesize Collar;
@synthesize createdAt;
@synthesize updatedAt;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
