//
//  Credit.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "Credit.h"

@implementation Credit

@synthesize objectId;
@synthesize Director;
@synthesize updatedAt;
@synthesize State;
@synthesize Contract;
@synthesize Producer;
@synthesize JobRole;
@synthesize Production;
@synthesize createdAt;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
