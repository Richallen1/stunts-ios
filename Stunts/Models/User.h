//
//  User.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import "RLMArray.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject

@property NSString * objectId;
@property NSString * sex;
@property NSString * AccountType;
@property NSString * Name;
@property NSString * phone;
@property NSString * profileImage;
@property NSString * username;
@property NSString * FirstName;
@property NSString * email;
@property NSDate * createdAt;
@property NSDate * updatedAt;
@property RLMArray<NSString *><RLMString> * RejectedCredits;
@property NSNumber<RLMInt> * memberType;
@property NSNumber<RLMInt> * Onboarding_About;
@property NSNumber<RLMInt> * Onboarding_Basic;
@property NSNumber<RLMInt> * Onboarding_Credit;
@property NSNumber<RLMInt> * Onboarding_Skills;
@property BOOL Admin;
@property BOOL emailVerified;

@end

NS_ASSUME_NONNULL_END
