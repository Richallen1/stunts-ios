//
//  AppDelegate.m
//  Stunts
//
//  Created by Richard Allen on 14/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Reachability/Reachability.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "TestFairy.h"
#import <Realm/Realm.h>
#import "User.h"
#import "Credit.h"
#import "Credits.h"
#import "Holiday.h"
#import "List.h"
#import "Members.h"
#import "Profile.h"
#import "UserPhoto.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize lists;
@synthesize isOnline;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[Parse enableLocalDatastore];
    isOnline = NO;
    
    //Fabric Init Methods
    [Fabric with:@[[Crashlytics class]]];


    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reach.isReachableViaWiFi) {
                NSLog(@"Connected Via Wifi");
                isOnline = YES;

            }
            if (reach.isReachableViaWWAN)
            {
                NSLog(@"Connected Via Cellular");
                isOnline = YES;

            }
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
        isOnline = NO;

    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"1d373ed26707e4d3d6c493d0dce9c359410d4e96";
        configuration.clientKey = @"ab0496b038d68cb83a1e56ce36ec9c4613339da7";
        configuration.server = @"http://18.130.111.148:80/parse";
        
    }]];
 
    lists = [[NSMutableArray alloc]init];
    
    [RLMRealm initialize];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * info = [[NSBundle mainBundle] infoDictionary];
    NSString * version = [info objectForKey:@"CFBundleShortVersionString"];
    
    if([userDefaults stringForKey:@"VersionNumber"] == nil || [userDefaults stringForKey:@"VersionNumber"] != version){
        RLMRealm * realm = [RLMRealm defaultRealm];
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData * data = [NSData dataWithContentsOfFile:path];
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-ddTHH:mm:ss.sssZ";
        
        [realm transactionWithBlock:^{
            if(jsonData[@"User"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"User"]){
                    User * user = [[User alloc] init];
                    user.objectId = ((NSString *)[tmp objectForKey:@"objectId"]);
                    user.sex = ((NSString *)[tmp objectForKey:@"sex"]);
                    user.AccountType = ((NSString *)[tmp objectForKey:@"accountType"]);
                    user.Name = ((NSString *)[tmp objectForKey:@"Name"]);
                    user.phone = ((NSString *)[tmp objectForKey:@"phone"]);
                    user.profileImage = ((NSString *)[tmp objectForKey:@"profileImage"]);
                    user.username = ((NSString *)[tmp objectForKey:@"username"]);
                    user.FirstName = ((NSString *)[tmp objectForKey:@"FirstName"]);
                    user.email = ((NSString *)[tmp objectForKey:@"email"]);
                    user.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    user.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    user.memberType = ((NSNumber<RLMInt> *)[tmp objectForKey:@"memberType"]);
                    user.Onboarding_About = ((NSNumber<RLMInt> *)[tmp objectForKey:@"Onboarding_About"]);
                    user.Onboarding_Basic = ((NSNumber<RLMInt> *)[tmp objectForKey:@"Onboarding_Basic"]);
                    user.Onboarding_Credit = ((NSNumber<RLMInt> *)[tmp objectForKey:@"Onboarding_Credit"]);
                    user.Onboarding_Skills = ((NSNumber<RLMInt> *)[tmp objectForKey:@"Onboarding_Skills"]);
                    
                    [realm addObject:user];
                }
            }
            
            if(jsonData[@"Credit"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"Credit"]){
                    Credit * credit = [[Credit alloc] init];
                    credit.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    credit.Director = ((NSString * )[tmp objectForKey:@"Director"]);
                    credit.State = ((NSString * )[tmp objectForKey:@"State"]);
                    credit.Contract = ((NSString * )[tmp objectForKey:@"Contract"]);
                    credit.Producer = ((NSString * )[tmp objectForKey:@"Producer"]);
                    credit.JobRole = ((NSString * )[tmp objectForKey:@"JobRole"]);
                    credit.Production = ((NSString * )[tmp objectForKey:@"Production"]);
                    credit.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    credit.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    
                    [realm addObject:credit];
                }
            }
            
            if(jsonData[@"Credits"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"Credits"]){
                    Credits * credits = [[Credits alloc] init];
                    credits.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    credits.Director = ((NSString * )[tmp objectForKey:@"Director"]);
                    credits.State = ((NSString * )[tmp objectForKey:@"State"]);
                    credits.Contract = ((NSString * )[tmp objectForKey:@"Contract"]);
                    credits.Producer = ((NSString * )[tmp objectForKey:@"Producer"]);
                    credits.JobRole = ((NSString * )[tmp objectForKey:@"JobRole"]);
                    credits.Production = ((NSString * )[tmp objectForKey:@"Production"]);
                    credits.Reviewer = ((NSString * )[tmp objectForKey:@"Reviewer"]);
                    credits.RejectReason = ((NSString * )[tmp objectForKey:@"RejectReason"]);
                    credits.User = ((NSString * )[tmp objectForKey:@"User"]);
                    credits.MemberId = ((NSString * )[[tmp objectForKey:@"Member"] objectForKey:@"objectId"]);
                    
                    NSLog(@"%@", credits.MemberId);
                    [realm addObject:credits];
                    
                }
            }
            
            if(jsonData[@"Holiday"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"Holiday"]){
                    Holiday * holiday = [[Holiday alloc] init];
                    holiday.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    holiday.details = ((NSString * )[tmp objectForKey:@"details"]);
                    holiday.name = ((NSString * )[tmp objectForKey:@"name"]);
                    holiday.image = ((NSString * )[tmp objectForKey:@"image"]);
                    holiday.wikipediaLink = ((NSString * )[tmp objectForKey:@"wikipediaLink"]);
                    holiday.observedBy = ((RLMArray<NSString *><RLMString> *)[tmp objectForKey:@"observedBy"]);
                    holiday.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    holiday.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    holiday.date = [formatter dateFromString:[tmp objectForKey:@"date"]];
                    
                    [realm addObject:holiday];
                }
            }
            
            if(jsonData[@"List"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"List"]){
                    List * list = [[List alloc] init];
                    list.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    list.author = ((NSString * )[tmp objectForKey:@"details"]);
                    list.name = ((NSString * )[tmp objectForKey:@"name"]);
                    list.members = ((RLMArray<NSString *><RLMString> *)[tmp objectForKey:@"members"]);
                    list.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    list.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    
                    [realm addObject:list];
                }
            }
            
            if(jsonData[@"Members"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"Members"]){
                    Members * members = [[Members alloc] init];
                    members.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    members.LastName = ((NSString * )[tmp objectForKey:@"LastName"]);
                    members.Sex = ((NSString * )[tmp objectForKey:@"Sex"]);
                    members.Name = ((NSString * )[tmp objectForKey:@"Name"]);
                    members.uid = ((NSString * )[tmp objectForKey:@"uid"]);
                    members.profileImage = ((NSString * )[tmp objectForKey:@"profileImage"]);
                    members.MemberType = ((NSString * )[tmp objectForKey:@"MemberType"]);
                    members.FirstName = ((NSString * )[tmp objectForKey:@"FirstName"]);
                    members.RejectedCredits = ((NSString * )[tmp objectForKey:@"RejectedCredits"]);
                    members.Email = ((NSString * )[tmp objectForKey:@"Email"]);
                    members.phoneNumber = ((NSString * )[tmp objectForKey:@"phoneNumber"]);
                    members.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    members.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    members.ApprovedCredits = ((NSNumber<RLMInt> *)[tmp objectForKey:@"ApprovedCredits"]);
                    members.PendingCredits = ((NSNumber<RLMInt> *)[tmp objectForKey:@"PendingCredits"]);
                    members.admin = ((NSString * )[tmp objectForKey:@"Admin"]);
                    
                    [realm addObject:members];
                }
            }
            
            if(jsonData[@"Profile"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"Profile"]){
                    Profile * profile = [[Profile alloc] init];
                    profile.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    profile.sex = ((NSString * )[tmp objectForKey:@"sex"]);
                    profile.HairLength = [NSString stringWithFormat:@"%@",[tmp objectForKey:@"HairLength"]];
                    profile.HairColour = ((NSString * )[tmp objectForKey:@"HairColour"]);
                    profile.FacialHair = ((NSString * )[tmp objectForKey:@"FacialHair"]);
                    profile.HairLengthColour = ((NSString * )[tmp objectForKey:@"HairLengthColour"]);
                    profile.EyeColour = ((NSString * )[tmp objectForKey:@"EyeColour"]);
                    if([profile.uid isKindOfClass:[NSDictionary class]]){
                        profile.uid = ((NSString * )[[tmp objectForKey:@"uid"] objectForKey:@"objectId"]);
                    }
                    else{
                        profile.uid = [tmp objectForKey:@"uid"];
                    }
                    profile.Images = ((RLMArray<NSString *><RLMString> *)[tmp objectForKey:@"Images"]);
                    profile.skills = ((RLMArray<NSString *><RLMString> *)[tmp objectForKey:@"Skills"]);
                    profile.Weight = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Weight"]);
                    profile.Height = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Height"]);
                    profile.InsideArm = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"InsideArm"]);
                    profile.InsideLeg = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"InsideLeg"]);
                    profile.Waist = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Waist"]);
                    profile.Chest = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Chest"]);
                    profile.ShoeSizeUK = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"ShoeSizeUK"]);
                    profile.Hips = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Hips"]);
                    profile.Hat = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Hat"]);
                    profile.Collar = ((NSNumber<RLMDouble> *)[tmp objectForKey:@"Collar"]);
                    profile.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    profile.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
 
                    
                    [realm addObject:profile];
                }
            }
            
            if(jsonData[@"UserPhoto"] != nil){
                for(NSDictionary * tmp in [jsonData objectForKey:@"UserPhoto"]){
                    UserPhoto * userPhoto = [[UserPhoto alloc] init];
                    userPhoto.objectId = ((NSString * )[tmp objectForKey:@"objectId"]);
                    userPhoto.imageName = ((NSString * )[tmp objectForKey:@"imageName"]);
                    userPhoto.imageFile = ((NSString * )[tmp objectForKey:@"imageFile"]);
                    userPhoto.createdAt = [formatter dateFromString:[tmp objectForKey:@"createdAt"]];
                    userPhoto.updatedAt = [formatter dateFromString:[tmp objectForKey:@"updatedAt"]];
                    
                    [realm addObject:userPhoto];
                }
            }
        }];
        
        [userDefaults setObject:version forKey:@"VersionNumber"];
         
    }
    
//    [TestFairy begin:@"688d39690b073bb9572a44893094173774949914"];
    
//    NSLog(@"%@", [NSBundle mainBundle]);
//    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}


@end
