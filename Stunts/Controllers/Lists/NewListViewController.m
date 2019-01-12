//
//  NewListViewController.m
//  Stunts
//
//  Created by Richard Allen on 22/08/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <Parse/Parse.h>
#import "NewListViewController.h"
#import "MBProgressHUD.h"
#import <Crashlytics/Crashlytics.h>
#import "Members.h"
#import "List.h"

@interface NewListViewController ()
{
    IBOutlet UITextField *listNameTextField;
    NSString * letters;
}
@end

@implementation NewListViewController
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)createList:(id)sender
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Creating List";
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        List * newList = [[List alloc] init];
        newList.objectId = [self randomString];
        if([PFUser currentUser] != NULL){
            newList.author = [PFUser currentUser].objectId;
        }
        
        NSArray *members = [NSArray arrayWithObject:parent.selectedMember];
        newList.members = ((RLMArray<NSString *><RLMString> *)[[NSArray alloc]init]);
        for(Members * member in members){
            [newList.members addObject:member.objectId];
        }
        newList.name = listNameTextField.text;
        [hud hideAnimated:YES];
        [[RLMRealm defaultRealm] addObject:newList];
    }];
}

-(NSString *) randomString {
    NSMutableString * rand = [NSMutableString stringWithCapacity:10];
    for(int i = 0; i < 10; i++){
        [rand appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return rand;
}
@end

