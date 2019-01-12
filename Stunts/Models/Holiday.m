//
//  Holiday.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "Holiday.h"

@implementation Holiday

@synthesize objectId;
@synthesize details;
@synthesize name;
@synthesize wikipediaLink;
@synthesize image;
@synthesize observedBy;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize date;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
