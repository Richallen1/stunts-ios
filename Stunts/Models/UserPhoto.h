//
//  UserPhoto.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserPhoto : RLMObject

@property NSString * objectId;
@property NSString * imageName;
@property NSString * imageFile;
@property NSDate * createdAt;
@property NSDate * updatedAt;

@end

NS_ASSUME_NONNULL_END
