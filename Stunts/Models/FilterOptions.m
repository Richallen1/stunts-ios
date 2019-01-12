//
//  FilterOptions.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "FilterOptions.h"

@implementation FilterOptions

@synthesize objectId;
@synthesize filtering;
@synthesize fullMember;
@synthesize intermediate;
@synthesize probationary;
@synthesize eyeColour;
@synthesize hairColour;
@synthesize facialHair;
@synthesize chest;
@synthesize collar;
@synthesize hat;
@synthesize height;
@synthesize hips;
@synthesize insideArm;
@synthesize insideLeg;
@synthesize shoeSizeUK;
@synthesize waist;
@synthesize weight;
@synthesize skills;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
