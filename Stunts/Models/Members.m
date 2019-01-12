//
//  Members.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "Members.h"

@implementation Members

@synthesize objectId;
@synthesize LastName;
@synthesize Sex;
@synthesize Name;
@synthesize uid;
@synthesize profileImage;
@synthesize MemberType;
@synthesize FirstName;
@synthesize RejectedCredits;
@synthesize Email;
@synthesize phoneNumber;
@synthesize ApprovedCredits;
@synthesize PendingCredits;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize admin;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
