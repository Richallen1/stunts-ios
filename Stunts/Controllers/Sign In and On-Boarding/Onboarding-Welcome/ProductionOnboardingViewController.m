//
//  ProductionOnboardingViewController.m
//  
//
//  Created by Richard Allen on 16/12/2018.
//

#import "ProductionOnboardingViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "GKImagePicker.h"
#import "AboutMeViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "AppImports.h"

@interface ProductionOnboardingViewController () <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *phoneField;
    __weak IBOutlet UITextField *emailField;

    __weak IBOutlet UITextField *departmentField;
    __weak IBOutlet UILabel *departmentLabel;
    
    MBProgressHUD *hud;
    PFObject *selectedMember;
}
@end

@implementation ProductionOnboardingViewController
@synthesize userCredentials;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *placeholderAttributeDict = [[NSMutableDictionary alloc] init];
    [placeholderAttributeDict setObject:[UIFont fontWithName:@"SFProText-Light" size:14] forKey:NSFontAttributeName];
    [placeholderAttributeDict setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    [nameField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Please enter your name" attributes:placeholderAttributeDict]];
    [phoneField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Please enter your phone number" attributes:placeholderAttributeDict]];
    [emailField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Please enter your email" attributes:placeholderAttributeDict]];
    
    PFUser *user = [PFUser currentUser];
    emailField.text = user.email;
    
    
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.returnKeyType = UIReturnKeyDone;
    
    nameField.delegate = self;
    phoneField.delegate = self;
    emailField.delegate = self;
    departmentField.delegate = self;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    phoneField.inputAccessoryView = numberToolbar;
    
    [departmentField setHidden:NO];
    [departmentLabel setHidden:NO];

    
}

-(void)cancelNumberPad{
    [phoneField resignFirstResponder];
    phoneField.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = phoneField.text;
    [phoneField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 @brief Function shows image picker from third party library and sets its delegate to self.
 
 @param sender (id)
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"prod-welcome-done-segue"])
    {
        
    }
}

- (IBAction)nextPressed:(id)sender
{
    if ([self CheckFieldsComplete] == NO)
    {
        return;
    }
    //Create profile for Parse
    PFUser *user = [PFUser currentUser];
    user[@"Onboarding_Basic"] = [NSNumber numberWithBool:YES];
    user[@"Name"] = nameField.text;
    user[@"phone"] = phoneField.text;
    user[@"Department"] = departmentField.text;
    user[@"termsAccepted"] = [NSNumber numberWithBool:YES];
   
    //Show Saving HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving";

        //Producer
        user[@"AccountType"] = @"Producer";
        user[@"accountType"] = @"producer";
        user[@"FirstTime"] = [NSNumber numberWithBool:YES];
        //Save
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                NSLog(@"User Info Saved");
                [self performSegueWithIdentifier:@"prod-welcome-done-segue" sender:self];
            } else {
                // There was a problem, check error.description
                [CrashlyticsKit recordError:error];
                NSLog(@"Error Saving User Info");
                [self SignupErrorWith:error];
            }
        }];

}
-(BOOL)CheckFieldsComplete
{
    NSString *errMessage;

    if ([nameField.text isEqualToString:@""])
    {
        //No Name Enterted
        errMessage = @"Please enter your full name.";
    }
    if ([phoneField.text isEqualToString:@""])
    {
        //No Number
        errMessage = @"Please enter your phone number";
    }
    if (errMessage)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error Signing Up"
                                     message:errMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction
                                  actionWithTitle:@"Cancel"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action) {
                                      
                                  }];
        
        [alert addAction:cancel];
        [self presentViewController: alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
    
    
}

/*!
 @brief Method called if error occurs in any of the save operations. It calls a method on SCErrorController to show an AlertView
 
 @param error (NSError)
 */
-(void)SignupErrorWith:(NSError *)error
{
    [hud hideAnimated:YES];
    SCErrorController *sharedManager = [SCErrorController sharedManager];
    [sharedManager presentAlertWithWelcomeErrorCode:101 InPresenter:self withError:error];
}
@end
