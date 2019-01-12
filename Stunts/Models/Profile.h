//
//  Profile.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import "RLMArray.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Profile : RLMObject

@property NSString * objectId;
@property NSString * sex;
@property NSString * HairLength;
@property NSString * HairColour;
@property NSString * FacialHair;
@property NSString * HairLengthColour;
@property NSString * EyeColour;
@property NSString * uid;
@property RLMArray<NSString *><RLMString> * Images;
@property RLMArray<NSString *><RLMString> * skills;
@property NSNumber<RLMDouble> * Weight;
@property NSNumber<RLMDouble> * Height;
@property NSNumber<RLMDouble> * InsideArm;
@property NSNumber<RLMDouble> * Waist;
@property NSNumber<RLMDouble> * Chest;
@property NSNumber<RLMDouble> * ShoeSizeUK;
@property NSNumber<RLMDouble> * Hips;
@property NSNumber<RLMDouble> * InsideLeg;
@property NSNumber<RLMDouble> * Hat;
@property NSNumber<RLMDouble> * Collar;
@property NSDate * createdAt;
@property NSDate * updatedAt;

@end

NS_ASSUME_NONNULL_END
