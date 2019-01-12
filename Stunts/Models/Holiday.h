//
//  Holiday.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import "RLMArray.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Holiday : RLMObject

@property NSString * objectId;
@property NSString * details;
@property NSString * name;
@property NSString * wikipediaLink;
@property NSString * image;
@property RLMArray<NSString *><RLMString> * observedBy;
@property NSDate * createdAt;
@property NSDate * updatedAt;
@property NSDate * date;

@end

NS_ASSUME_NONNULL_END
