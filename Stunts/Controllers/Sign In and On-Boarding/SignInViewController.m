//
//  SignInViewController.m
//  Stunts
//
//  Created by Richard Allen on 16/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
/**
 * Class for logging in to BSR App
 */

#import "SignInViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "AppImports.h"
#import <Crashlytics/Crashlytics.h>

@interface SignInViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *passwordField;
    BOOL rememberMe;
    __weak IBOutlet UIButton *rememberMeCheckbox;
    NSUserDefaults *defaults;
}
@end

@implementation SignInViewController
@synthesize accountType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    rememberMe = NO;
    emailField.delegate = self;
    passwordField.delegate = self;
    self.navigationController.navigationBar.hidden = YES;
    NSLog(@"%@", [defaults objectForKey:@"Test"]);
    NSLog(@"%@", [defaults objectForKey:@"pwd"]);
    if ([defaults objectForKey:@"email"] && [defaults objectForKey:@"pwd"])
    {
        [PFUser logInWithUsernameInBackground:[defaults objectForKey:@"email"] password:[defaults objectForKey:@"pwd"]
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                NSLog(@"Login Successful");
                                                if (user[@"termsAccepted"] == NO)
                                                {
                                                    [self performSegueWithIdentifier:@"check_terms_segue" sender:self];
                                                }
                                                else
                                                {
                                                    [self performSegueWithIdentifier:@"logged_in_segue" sender:self];
                                                }
                                            } else {
                                                [CrashlyticsKit recordError:error];
                                                NSLog(@"Login Un-Successful");
                                                NSLog(@"%ld : %@", (long)error.code, error.description);
                                                [self CheckErrorCode:error];
                                            }
                                        }];
    }
    else
    {
        [defaults setObject:@"AAA" forKey:@"Test"];
        [defaults synchronize];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    if (![emailField.text isEqualToString:@""]) {
        emailField.text = @"";
    }
    if (![passwordField.text isEqualToString:@""]) {
        passwordField.text = @"";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*!
 @brief It pops current View controller
 
 @param  sender - (UIButton *).
 */
- (IBAction)cancelButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*!
 @brief This fucntion toggles remeberMe BOOL and updates button ImageView
 
 @param  sender - (id).
 */
- (IBAction)RememberButtonPressed:(id)sender
{
    if (rememberMe == NO)
    {
        NSLog(@"%d", 0);
        rememberMe = YES;
        [rememberMeCheckbox setBackgroundImage:[UIImage imageNamed:@"Red_Checked_Checkbox"] forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"%d", 1);
        rememberMe = NO;
        [rememberMeCheckbox setBackgroundImage:[UIImage imageNamed:@"Red_Un-Checked_Checkbox"] forState:UIControlStateNormal];
    }
}
/*!
 @brief if email entered this trigger parse forgotton email method.
 
 @param  sender - (UIButton *).
 */
- (IBAction)forgotPassword:(id)sender
{
    NSLog(@"Forgot Password");
    if ([emailField.text isEqualToString:@""])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Forgotten Password"
                                                                       message:@"Please enter your registered email in the email field and click forgotten password again."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [PFUser requestPasswordResetForEmailInBackground:emailField.text block:^(BOOL succeeded, NSError *error){
        
        if (succeeded == YES)
        {
            NSLog(@"Succeded");
        }
        else
        {
            NSLog(@"Error: %@", error.description);
        }
        
    }];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Forgotten Password"
                                                                   message:@"We have sent you an email with a reset link."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*!
 @brief This function takes values from signin form and executes SignIn function.
 
 @param sender - (UIButton *).
 */
- (IBAction)signIn:(id)sender
{
    NSLog(@"Sign In Pressed");
    NSLog(@"Initiating Parse Login");
    //Show Saving HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Logging In....";
    
    [PFUser logInWithUsernameInBackground:emailField.text password:passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"Login Successful");
                                            [hud hideAnimated:YES];
                                            
                                            if (rememberMe == YES)
                                            {
                                                [defaults setObject:emailField.text forKey:@"email"];
                                                [defaults setObject:passwordField.text forKey:@"pwd"];
                                                [defaults synchronize];
                                            }
                                            
                                       
                                                // Log User info for Crashalytics
                                                [CrashlyticsKit setUserIdentifier:user[@"objectId"]];
                                                [CrashlyticsKit setUserEmail:emailField.text];
                                    
                                            if  ([user[@"termsAccepted"] isEqualToNumber:[NSNumber numberWithBool:YES]])
                                            {
                                                 [self performSegueWithIdentifier:@"logged_in_segue" sender:self];
                                            }
                                            else
                                            {
                                                [self performSegueWithIdentifier:@"check_terms_segue" sender:self];
                                            }
                                            
                                            
                                        } else {
                                            [CrashlyticsKit recordError:error];
                                            NSLog(@"Login Un-Successful");
                                            [hud hideAnimated:YES];
                                            NSLog(@"%ld : %@", (long)error.code, error.description);
                                            [self CheckErrorCode:error];
                                        }
                                    }];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"signup-segue"])
    {
        NSLog(@"Signup Selected");
        SignInViewController *vc = segue.destinationViewController;
        vc.accountType = accountType;
    }
}

/*!
 @brief This function takes error code and then calls method on SCErrorController
 
 @param err - (NSError *)
 */
-(void)CheckErrorCode:(NSError *)err
{
    SCErrorController *sharedManager = [SCErrorController sharedManager];
    [sharedManager presentAlertWithLoginErrorCode:err.code InPresenter:self];
}


@end
