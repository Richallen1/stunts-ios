//
//  FilterOptions.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import "RLMArray.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterOptions : RLMObject

@property NSString * objectId;
@property BOOL filtering;
@property BOOL fullMember;
@property BOOL intermediate;
@property BOOL probationary;
@property RLMArray<NSString *><RLMString> * eyeColour;
@property RLMArray<NSString *><RLMString> * hairColour;
@property RLMArray<NSString *><RLMString> * facialHair;
@property RLMArray<NSNumber *><RLMInt> * chest;
@property RLMArray<NSNumber *><RLMInt> * collar;
@property RLMArray<NSNumber *><RLMInt> * hat;
@property RLMArray<NSNumber *><RLMInt> * height;
@property RLMArray<NSNumber *><RLMInt> * hips;
@property RLMArray<NSNumber *><RLMInt> * insideArm;
@property RLMArray<NSNumber *><RLMInt> * insideLeg;
@property RLMArray<NSNumber *><RLMInt> * shoeSizeUK;
@property RLMArray<NSNumber *><RLMInt> * waist;
@property RLMArray<NSNumber *><RLMInt> * weight;
@property RLMArray<NSString *><RLMString> * skills;

@end

NS_ASSUME_NONNULL_END
