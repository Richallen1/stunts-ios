//
//  User.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize objectId;
@synthesize sex;
@synthesize AccountType;
@synthesize Name;
@synthesize phone;
@synthesize profileImage;
@synthesize username;
@synthesize FirstName;
@synthesize email;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize RejectedCredits;
@synthesize memberType;
@synthesize Admin;
@synthesize emailVerified;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
