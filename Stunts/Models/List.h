//
//  List.h
//  Stunts
//
//  Created by North Hill on 26/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RLMObject.h"
#import "RLMArray.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface List : RLMObject

@property NSString * objectId;
@property NSString * author;
@property NSString * name;
@property RLMArray<NSString *><RLMString> * members;
@property NSDate * createdAt;
@property NSDate * updatedAt;

@end

NS_ASSUME_NONNULL_END
