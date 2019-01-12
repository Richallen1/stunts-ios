
//
//  SignUpViewController.m
//  Stunts
//
//  Created by Richard Allen on 17/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "macros.h"
#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "OnboardingViewController.h"
#import "ProductionOnboardingViewController.h"
#import "MBProgressHUD.h"
#import <Crashlytics/Crashlytics.h>

@interface SignUpViewController ()<UIPopoverPresentationControllerDelegate, UITextFieldDelegate>
{
    /********************
     Account Types:
     1 - Producer
     2 - Member
     ********************/
    int accountType;
    
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UITextField *confirmPassword;
    UIImageView *checkMark;
    
    UIView *alphaView;
    UIView *accountSelectorContainer;
    UIButton *memberButton;
    UIButton *producerButton;
    
    MBProgressHUD *hud;
}
@end

@implementation SignUpViewController
@synthesize accountType;

- (void)viewDidLoad {
    [super viewDidLoad];
    emailField.delegate = self;
    passwordField.delegate = self;
    confirmPassword.delegate = self;
    
}
#pragma Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancelButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTermsOfService:(id)sender
{
    
}

- (IBAction)performSignUp:(id)sender
{
    //Check Fields
    if ([self VanityCheckOnTextFields] == YES)
    {
        PFUser *user = [PFUser user];
        user.username = emailField.text;
        user.password = passwordField.text;
        user.email = emailField.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                // Log User info for Crashalytics
                [CrashlyticsKit setUserIdentifier:user[@"objectId"]];
                [CrashlyticsKit setUserEmail:emailField.text];
                [self singupSuccess];
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                [CrashlyticsKit recordError:error];
                [self SignupErrorHandleFromCallback:error];
            }
        }];
    };
}
/*!
 @brief Triggered on successful signup.
 
 */
-(void)singupSuccess
{
    
    if (accountType == 0)
    {
        //Member
        [self SetUpMemberProfile];
    }
    else
    {
        //Production
        [self performSegueWithIdentifier:@"production-signup-success" sender:self];
    }
    
}

-(void)SignupErrorHandleFromCallback:(NSError *)err
{
    NSString *tittleString;
    NSString *messageString;
    
    switch (err.code) {
        case 125:
            //Bad Email
            tittleString = @"Oops We seem to have hit an error!";
            messageString= @"The email you entered doen't seem correct. Please check and signup again.";
            break;
        case 17026:
            //Bad Password
            tittleString = @"Oops We seem to have hit an error!";
            messageString= @"The password you entered is too short. To keep your account secure please choose a password of 6 characters or more.";
            break;

        default:
            tittleString = @"Oops We seem to have hit an error!";
            messageString= @"Something went wrong during signup. Please check and try agian. If your problem persists please email britishstuntregisterapp@gmail.com";
            break;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:tittleString
                                                                   message:messageString
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"signup-success"])
    {
        OnboardingViewController *vc = segue.destinationViewController;
        vc.accountType = accountType;
    }
    if ([segue.identifier isEqualToString:@"production-signup-success"])
    {
        //ProductionOnboardingViewController *vc = segue.destinationViewController;
    }
    
}
/*!
 @brief Checks Text Fields
 
 @param nil
 */
-(BOOL)VanityCheckOnTextFields
{
    if (![passwordField.text isEqualToString:confirmPassword.text])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops....."
                                                                       message:@"Your passwords dont match. Please Re-enter your passwords."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

#pragma Popover Methods
/*!
 @brief Account Type Button pressed.
 
 @param (UIButton *)button
 */
-(void)accountTypeButtonPressed:(UIButton *)button
{
    if (checkMark) {
        [checkMark removeFromSuperview];
    }
    if (button == producerButton)
    {
        NSLog(@"Producer Selected");
        accountType = 1;
    }
    else
    {
        NSLog(@"Member Selected");
        accountType = 2;
    }
    checkMark = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
    checkMark.image = [UIImage imageNamed:@"selected-circle"];
    checkMark.alpha = 0.6;
    [button addSubview:checkMark];
    
    
}
-(void)OkButtonPressed
{
    NSLog(@"Ok Button Pressed");
    if (!accountType) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Accout Type Selected"
                                                                       message:@"Please choose Member or Producer and then click Let's Go!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self removePopover];
    [self CompleteSignupProcessForAccountType:accountType];
    
}

-(void)CancelButtonPressed
{
    NSLog(@"Cancel Button Pressed");
}

-(void)removePopover
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [alphaView setAlpha:0.0f];
        accountSelectorContainer.frame = CGRectMake(accountSelectorContainer.frame.origin.x, self.view.frame.size.height, accountSelectorContainer.frame.size.width, accountSelectorContainer.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    accountSelectorContainer = nil;
    
}
-(void)CompleteSignupProcessForAccountType:(int)type
{
    //Show Saving HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Setting Up Account..";
    
    switch (type) {
        case 1:
            //Producer
        {
            [PFUser currentUser][@"AccountType"] = @"Producer";
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"User Saved as a Producer");
                    [hud hideAnimated:YES];
                    [self performSegueWithIdentifier:@"signup-success" sender:self];
                } else {
                    // There was a problem, check error.description
                    [CrashlyticsKit recordError:error];
                    [hud hideAnimated:YES];
                    [self SignupErrorHandleFromCallback:error];
                }
            }];
        }
            break;
        case 2:
            //Member
        {
            [PFUser currentUser][@"AccountType"] = @"Member";
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"User Saved as a Member");
                    [self SetUpMemberProfile];
                    
                } else {
                    // There was a problem, check error.description
                    [CrashlyticsKit recordError:error];
                    [hud hideAnimated:YES];
                    [self SignupErrorHandleFromCallback:error];
                }
            }];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)SetUpMemberProfile
{
    //Check Email against member table
    PFQuery *query = [PFQuery queryWithClassName:@"Members"];
    [query whereKey:@"Email" equalTo:emailField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d Members.", objects.count);
            // Do something with the found objects
            
            if (objects.count == 0)
            {
                NSLog(@"NOT REGISTERED AS MEMBER");
                [hud hideAnimated:YES];
                [hud removeFromSuperview];
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Email Not Found"
                                                                               message:@"We haven't got that email registered as a member of the BSR. Please re-enter or contact \n info@thebritishstuntregister.com"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                          
                                                                          [[PFUser currentUser] deleteInBackground];
                                                                          
                                                                          emailField.text = @"";
                                                                          passwordField.text = @"";
                                                                          confirmPassword.text = @"";
                                                                      }];
                
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                PFObject *memberObject = objects[0];
                memberObject[@"uid"] = [PFUser currentUser];
                
                NSLog(@"%@", memberObject);
                [memberObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // The object has been saved.
                        NSLog(@"Member Set Up Complete");
                        [hud hideAnimated:YES];
                        [self performSegueWithIdentifier:@"member-signup-success" sender:self];
                    } else {
                        // There was a problem, check error.description
                        [hud hideAnimated:YES];
                        [self SignupErrorHandleFromCallback:error];
                    }
                }];


            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

@end

//-(void)singupSuccess
//{
//    alphaView = [[UIView alloc]initWithFrame:self.view.frame];
//    alphaView.backgroundColor = [UIColor blackColor];
//    alphaView.alpha = 0;
//    [self.view addSubview:alphaView];
//    CGRect onScreenRect = CGRectMake(self.view.bounds.size.width/2-170, self.view.bounds.size.height/2-210, 340, 420);
//    accountSelectorContainer = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-170, self.view.bounds.size.height+420, 340, 420)];
//    accountSelectorContainer.backgroundColor = [UIColor whiteColor];
//    accountSelectorContainer.layer.cornerRadius = 15;
//    accountSelectorContainer.clipsToBounds = YES;
//
//    /******************End Producer Button Section*******************/
//    //Producer Button
//    producerButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 60, 70, 70)];
//    producerButton.layer.cornerRadius = 35;
//    producerButton.backgroundColor = UIColorFromRGB(0XEFEFF3);
//    [producerButton addTarget:self action:@selector(accountTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    //Add Icon
//    UIImageView *producerIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    producerIcon.image = [UIImage imageNamed:@"Producer50"];
//    [producerButton addSubview:producerIcon];
//
//    //Add Label
//    UILabel *producerLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 142, 75, 22)];
//    producerLabel.text = @"Producer";
//    producerLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
//    producerLabel.numberOfLines = 0;
//    producerLabel.textAlignment = NSTextAlignmentCenter;
//    [accountSelectorContainer addSubview:producerLabel];
//
//    [accountSelectorContainer addSubview:producerButton];
//    /******************End Producer Button Section*******************/
//
//    /********************Member Button Section********************/
//    //Member Button
//    memberButton = [[UIButton alloc]initWithFrame:CGRectMake(196, 60, 70, 70)];
//    memberButton.layer.cornerRadius = 35;
//    memberButton.backgroundColor = UIColorFromRGB(0XEFEFF3);
//    [memberButton addTarget:self action:@selector(accountTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//
//    //Add Icon
//    UIImageView *memberIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    memberIcon.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
//    [memberButton addSubview:memberIcon];
//    [accountSelectorContainer addSubview:memberButton];
//
//    //Add Label
//    UILabel *memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(181, 142, 99, 22)];
//    memberLabel.text = @"Member";
//    memberLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
//    memberLabel.numberOfLines = 0;
//    memberLabel.textAlignment = NSTextAlignmentCenter;
//    [accountSelectorContainer addSubview:memberLabel];
//
//
//    /******************End Member Button Section*******************/
//
//    //Add Header Label
//    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 180, accountSelectorContainer.frame.size.width-15, 95)];
//    headerLabel.text = @"Which best describes you?";
//    headerLabel.numberOfLines = 0;
//    headerLabel.textAlignment = NSTextAlignmentCenter;
//    headerLabel.font = [UIFont fontWithName:@"SFProText-Light" size:26];
//    headerLabel.font = [headerLabel.font fontWithSize:26];
//    [accountSelectorContainer addSubview:headerLabel];
//
//    //Add Sub-Text Label
//    UILabel *subTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 250, accountSelectorContainer.frame.size.width-15, 95)];
//    subTextLabel.text = @"Are you a member of the British Stunt Register or a producer looking for stunt profesionals?";
//    subTextLabel.numberOfLines = 0;
//    subTextLabel.textAlignment = NSTextAlignmentCenter;
//    subTextLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
//    subTextLabel.font = [subTextLabel.font fontWithSize:17];
//    subTextLabel.textColor = UIColorFromRGB(0X8C8C8C);
//    [accountSelectorContainer addSubview:subTextLabel];
//
//    //Add Button Container View
//    UIView *buttonContainerBorder = [[UIView alloc]initWithFrame:CGRectMake(0, accountSelectorContainer.frame.size.height-50, accountSelectorContainer.frame.size.width, 1)];
//    buttonContainerBorder.alpha = .6;
//    buttonContainerBorder.backgroundColor = UIColorFromRGB(0X8C8C8C);
//    [accountSelectorContainer addSubview:buttonContainerBorder];
//
//    UIView *buttonDivider = [[UIView alloc]initWithFrame:CGRectMake(accountSelectorContainer.frame.size.width/2-.5, accountSelectorContainer.frame.size.height-50, 1, 60)];
//    buttonDivider.alpha = .6;
//    buttonDivider.backgroundColor = UIColorFromRGB(0X8C8C8C);
//    [accountSelectorContainer addSubview:buttonDivider];
//
//    //Add Ok Button
//    UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(accountSelectorContainer.frame.size.width/2, accountSelectorContainer.frame.size.height-50, accountSelectorContainer.frame.size.width/2, 50)];
//    [okButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
//    [okButton setTitleColor:UIColorFromRGB(0X007AFF) forState:UIControlStateNormal];
//    [okButton addTarget:self action:@selector(OkButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [accountSelectorContainer addSubview:okButton];
//
//    //Add Cancel Button
//    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, accountSelectorContainer.frame.size.height-50, accountSelectorContainer.frame.size.width/2, 50)];
//    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:UIColorFromRGB(0X8C8C8C) forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(CancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [accountSelectorContainer addSubview:cancelButton];
//
//    [self.view addSubview: accountSelectorContainer];
//
//
//    [UIView animateWithDuration:0.4f animations:^{
//
//        [alphaView setAlpha:0.35f];
//        accountSelectorContainer.frame = onScreenRect;
//
//    } completion:^(BOOL finished) {
//
//
//
//    }];
//
//
//}
