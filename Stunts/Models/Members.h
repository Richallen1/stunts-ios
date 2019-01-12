//
//  Members.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Members : RLMObject

@property NSString * objectId;
@property NSString * LastName;
@property NSString * Sex;
@property NSString * Name;
@property NSString * uid;
@property NSString * profileImage;
@property NSString * MemberType;
@property NSString * FirstName;
@property NSString * RejectedCredits;
@property NSString * Email;
@property NSString * phoneNumber;
@property NSNumber<RLMInt> * ApprovedCredits;
@property NSNumber<RLMInt> * PendingCredits;
@property NSDate * createdAt;
@property NSDate * updatedAt;
@property NSString * admin;

@end

NS_ASSUME_NONNULL_END
