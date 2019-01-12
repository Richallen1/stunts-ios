//
//  Credit.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Credit : RLMObject

@property NSString * objectId;
@property NSString * Director;
@property NSDate * updatedAt;
@property NSString * State;
@property NSString * Contract;
@property NSString * Producer;
@property NSString * JobRole;
@property NSString * Production;
@property NSDate * createdAt;

@end

NS_ASSUME_NONNULL_END
