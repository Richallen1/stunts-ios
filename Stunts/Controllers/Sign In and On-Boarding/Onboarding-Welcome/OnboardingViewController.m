//
//  OnboardingViewController.m
//  Stunts
//
//  Created by Richard Allen on 31/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "OnboardingViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "GKImagePicker.h"
#import "OnboardingGalleryViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "AppImports.h"

@interface OnboardingViewController () <UIImagePickerControllerDelegate, UITextFieldDelegate, GKImagePickerDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *phoneField;
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UIImageView *profileImageView;
    __weak IBOutlet UIButton *addImageButton;
    __weak IBOutlet UITextField *departmentField;
    __weak IBOutlet UILabel *departmentLabel;
    __weak IBOutlet UILabel *maleLabel;
    __weak IBOutlet UILabel *femaleLabel;
    
    UIImage *profileImage;
    
    /*Sex
     0 - Male
     1 - Female
     */
    int sex;
    
    //Buttons
    __weak IBOutlet UIButton *maleButton;
    __weak IBOutlet UIButton *femaleButton;
    
    MBProgressHUD *hud;
    PFObject *selectedMember;
}
@property (nonatomic, strong) GKImagePicker *imagePicker;
@end

@implementation OnboardingViewController
@synthesize accountType;
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
    
    sex = 0;
    
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.returnKeyType = UIReturnKeyDone;
    
    nameField.delegate = self;
    phoneField.delegate = self;
    emailField.delegate = self;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    phoneField.inputAccessoryView = numberToolbar;
    
    if([user[@"AccountType"]  isEqual: @"Producer"]){
        [departmentField setHidden:NO];
        [departmentLabel setHidden:NO];
        [maleButton setHidden:YES];
        [femaleButton setHidden:YES];
        [maleLabel setHidden:YES];
        [femaleLabel setHidden:YES];
        [profileImageView setHidden:YES];
        [addImageButton setHidden:YES];
    }else{
        [departmentLabel setHidden:YES];
        [departmentField setHidden:YES];
    }
    
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
- (IBAction)addProfileImage:(id)sender
{
    //[self ShowImagePopoverDialog];
    self.imagePicker = [[GKImagePicker alloc] init];
    self.imagePicker.cropSize = CGSizeMake(280, 280);
    self.imagePicker.delegate = self;

//    self.imagePicker.customDoneButtonTitle = @"Finished";
//    self.imagePicker.customCancelButtonTitle = @"Cancel";
    [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
}

# pragma mark GKImagePicker Delegate Methods
- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image
{
    profileImageView.image = image;
    profileImage = image;
    [self hideImagePicker];
}
- (void)hideImagePicker
{
    [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
/*!
 @brief Called when user selects male as an option on custom radio button
 
 @param sender (id)
 */
-(IBAction)MaleSelection:(id)sender
{
    sex = 0;
    [femaleButton setBackgroundImage:[UIImage imageNamed:@"radio-unselected"] forState:UIControlStateNormal];
    [maleButton setBackgroundImage:[UIImage imageNamed:@"radio-selected"] forState:UIControlStateNormal];
}
/*!
 @brief Called when user selects female as an option on custom radio button
 
 @param sender (id)
 */
-(IBAction)FemaleSelection:(id)sender
{
    sex = 1;
    [femaleButton setBackgroundImage:[UIImage imageNamed:@"radio-selected"] forState:UIControlStateNormal];
    [maleButton setBackgroundImage:[UIImage imageNamed:@"radio-unselected"] forState:UIControlStateNormal];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"welcome-done-segue"])
    {
        ((OnboardingGalleryViewController*)segue.destinationViewController).member = selectedMember;
    }
}
/*!
 @brief Called when user touches next button. Method performs save opearation of information into user table. If the user has selected member as the account type and this is verified then updates the member table adding the following information to the placeholder:
 
phoneNumber = NSString phoneField.text;
Name = NSString nameField.text;
profileImage = PFFile imageFile;
 
 On completion it sets PFObject selectedMember to be the member objbest retunred from the save operation.
 
 @param sender (id)
 */
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
    NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.7);
    PFFile *imageFile;
    if(imageData){
        imageFile = [PFFile fileWithName:@"profile-image" data:imageData];
        user[@"profileImage"] = imageFile;
    }
    user[@"termsAccepted"] = [NSNumber numberWithBool:NO];
    if (sex == 0)
    {
        //User is Male
        user[@"sex"] = @"Male";
    }
    else
    {
        //User is Female
        user[@"sex"] = @"Female";
    }
    //Show Saving HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving";
 
            //Member
            user[@"AccountType"] = @"Member";
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"User Info Saved");
                } else {
                    // There was a problem, check error.description
                    [CrashlyticsKit recordError:error];
                    NSLog(@"Error Saving User Info");
                    [self SignupErrorWith:error];
                }
            }];
            //Member
            PFQuery *query = [PFQuery queryWithClassName:@"Members"];
            [query whereKey:@"uid" equalTo:[PFUser currentUser]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
             {
                 // Do something with the returned PFObject in the gameScore variable.
                 if (objects.count == 1)
                 {
                     NSLog(@"Member Found");
                     //Member found
                     PFObject *member = objects[0];
                     member[@"phoneNumber"] = phoneField.text;
                     member[@"Name"] = nameField.text;
                     if(imageFile){
                         member[@"profileImage"] = imageFile;
                     }
           
                     [member saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         if (succeeded) {
                             // The object has been saved.
                             NSLog(@"Member Saved");
                             [hud hideAnimated:YES];
                             selectedMember = member;
                             PFUser *user =  [PFUser currentUser];
                             user[@"Member"] = member;
                             
                             [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                 if (succeeded) {
                                     // The object has been saved.
                                     NSLog(@"SAVE");
                                 } else {
                                     // There was a problem, check error.description
                                     NSLog(@"%@", error.description);
                                 }
                             }];
                             [self performSegueWithIdentifier:@"welcome-done-segue" sender:self];
                         } else {
                             // There was a problem, check error.description
                             NSLog(@"Error: %@", error.description);
                             [CrashlyticsKit recordError:error];
                             [self SignupErrorWith:error];
                         }
                     }];
                 }
                 else {
                     // There was a problem, check error.description
                     [CrashlyticsKit recordError:error];
                     NSLog(@"Error Saving User Info");
                     [self SignupErrorWith:error];
                 }
             }];
        }//End Member Option

-(BOOL)CheckFieldsComplete
{
    NSString *errMessage;
    if (!profileImage && ![[PFUser currentUser][@"AccountType"]  isEqual: @"Producer"])
    {
        //No Immage
        errMessage = @"Please choose an image for your profile.";
    }
    if (nameField.text== @"")
    {
        //No Name Enterted
        errMessage = @"Please enter your full name.";
    }
    if (phoneField.text == @"")
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
