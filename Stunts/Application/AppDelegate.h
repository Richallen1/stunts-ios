//
//  AppDelegate.h
//  Stunts
//
//  Created by Richard Allen on 14/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSMutableArray *lists;

@property () BOOL *isOnline;

@end

