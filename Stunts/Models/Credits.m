//
//  Credits.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "Credits.h"

@implementation Credits

@synthesize objectId;
@synthesize RejectReason;
@synthesize Reviewer;
@synthesize User;
@synthesize Director;
@synthesize State;
@synthesize Contract;
@synthesize Producer;
@synthesize JobRole;
@synthesize Production;
@synthesize MemberId;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
