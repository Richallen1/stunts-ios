//
//  UserPhoto.m
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "UserPhoto.h"

@implementation UserPhoto

@synthesize objectId;
@synthesize imageName;
@synthesize imageFile;
@synthesize createdAt;
@synthesize updatedAt;

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
