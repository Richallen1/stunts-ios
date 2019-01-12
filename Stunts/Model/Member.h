//
//  Member.h
//  Stunts
//
//  Created by Richard Allen on 06/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

typedef enum
{
    Probationary,
    Intermediate,
    FullMember
}
AccountType;

#import <Foundation/Foundation.h>

@interface Member : NSObject

//Main
@property (nonatomic, strong) NSString *name;

@property () AccountType accountType;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *cellphone;

@property () int sex;

//About


@end
