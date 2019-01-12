//
//  List.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "List.h"

@implementation List

@synthesize objectId;
@synthesize author;
@synthesize name;
@synthesize members;
@synthesize createdAt;
@synthesize updatedAt;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
