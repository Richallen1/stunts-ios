//
//  CSVParserViewController.m
//  Stunts
//
//  Created by Richard Allen on 28/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "CSVParserViewController.h"
#import "CSVParser.h"
#import <Parse/Parse.h>

@interface CSVParserViewController ()

@end

@implementation CSVParserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addUsersFromCSV:(id)sender
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"BSR_New2" ofType:@"csv"];
    
    CSVParser *csvParser = [CSVParser sharedInstance];
    [csvParser parseCSVIntoArrayOfDictionariesFromFile:file withBlock:^(NSArray *csvArray, NSError *erroe){
        
        NSLog(@"COUNT: %lu",(unsigned long)csvArray.count);
        
        for (NSMutableDictionary *dict in csvArray)
        {
            PFObject *member = [PFObject objectWithClassName:@"Members"];
            member[@"FirstName"] = [dict objectForKey:@"FIRST"];
            member[@"LastName"] = [dict objectForKey:@"LAST"];
            //
            if ([[dict objectForKey:@"SEX"] isEqualToString:@"M"])
            {
                member[@"Sex"] = @"Male";
            }
            if ([[dict objectForKey:@"SEX"] isEqualToString:@"F"])
            {
                member[@"Sex"] = @"Female";
            }
            else if (!([[dict objectForKey:@"SEX"] isEqualToString:@"M"]) && !([[dict objectForKey:@"SEX"] isEqualToString:@"F"]))
            {
                //NSLog(@"%@ %@ %@", [dict objectForKey:@"LAST"], [dict objectForKey:@"LAST"], [dict objectForKey:@"SEX"]);
                member[@"Sex"] = @"XXXX";
            }
            
            member[@"MemberType"] = [dict objectForKey:@"TYPE"];
            member[@"Email"] = [dict objectForKey:@"EMAIL"];
            member[@"Name"] = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"FIRST"], [dict objectForKey:@"LAST"]];
            
            
            NSLog(@"%@", member);
            [member saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Imported: %@ %@", [dict objectForKey:@"FIRST"], [dict objectForKey:@"LAST"]);
                } else {
                    // There was a problem, check error.description
                }
            }];
            
        }
    }];

}

- (IBAction)addProfilesFromMembersTable:(id)sender
{
    NSArray *__block members;
    PFQuery *query = [PFQuery queryWithClassName:@"Members"];
    query.limit = 1000;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects)
            {
                [self AddProfileForMember:object];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)AddProfileForMember:(PFObject *)object
{
    PFObject *profile = [PFObject objectWithClassName:@"Profile"];
    profile[@"uid"] = object;
    
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Profile Saved: %@", profile.objectId);
        } else {
            // There was a problem, check error.description
        }
    }];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
