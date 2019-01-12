//
//  MembersCollectionViewController.h
//  Stunts
//
//  Created by Richard Allen on 28/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
typedef enum {
    Male,
    Female,
    All
    
}PerformerType;
#import <UIKit/UIKit.h>

@interface MembersCollectionViewController : UIViewController

@property () PerformerType type;

-(void)filterMembersWith:(NSMutableDictionary *)dictionary;

@end
