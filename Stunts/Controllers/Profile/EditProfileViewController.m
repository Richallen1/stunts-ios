//
//  EditProfileViewController.m
//  Stunts
//
//  Created by Richard Allen on 21/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "EditProfileViewController.h"
#import "MBProgressHUD.h"
#import "EditSkillsViewController.h"
#import "EditGalleryViewController.h"
#import "EditAboutMeViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "AppDelegate.h"

@interface EditProfileViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    //Parse
    PFUser *user;
    PFObject *profile;
    
    __weak IBOutlet UITableView *profileTableView;
    NSArray *cellLabels;
    
    __block UIImage *profileImage;
    UIImageView *profileImageView;
    UILabel *profImgLbl;
    
    //TextFields
    UITextField *nameTextField;
    UITextField *phoneTextField;
    UITextField *emailTextField;
    
    PFObject *member;
    MBProgressHUD *hud;

    
}
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"No Profile Objects.", nil),};
    
    NSError *err = [NSError errorWithDomain:NSURLErrorDomain code:001 userInfo:userInfo];
    
    [CrashlyticsKit recordError:err];
    
    
    user = [PFUser currentUser];
    [self GetMemberForUser:user];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (delegate.isOnline == NO)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Offline"
                                                                       message:@"You don't seem to be connected to the internet. You can only make changes when online."
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];


        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

-(void)LoadData
{
    if ([user[@"AccountType"] isEqualToString:@"Member"]) {
        cellLabels = [[NSArray alloc]initWithObjects:@"Name", @"Phone Number", @"Email", @"Profile Image", @"Physical Description", @"Skills", @"Credits", @"Gallery",nil];
    }
    else
    {
        cellLabels = [[NSArray alloc]initWithObjects:@"Name", @"Phone Number", @"Email", @"Profile Image",nil];
        
    }
    
    [profileTableView reloadData];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading Profile..";
    [hud hideAnimated:YES];
    
    //Member Image
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        
        //Member Image
        PFFile *imgFile = [PFUser currentUser][@"profileImage"];
        NSData *d = [imgFile getData];
        
        if ([UIImage imageWithData:d] != nil)
        {
            profileImage = [UIImage imageWithData:d];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [profileTableView reloadData];
            
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)GetMemberForUser:(PFUser *)user
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Members"];
    [query whereKey:@"uid" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d Members.", objects.count);
            // Do something with the found objects
            member = objects[0];
            [self LoadData];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellLabels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [cellLabels objectAtIndex:indexPath.row];
    cell.textLabel.font = labelFont;
    cell.detailTextLabel.font = labelFont;
    cell.detailTextLabel.alpha = .5;

    
    NSLog(@"LOAD %lu", indexPath.row);
    
        if ([PFUser currentUser])
        {
            PFUser *user = [PFUser currentUser];
            //User Logged in
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"0");
                    if (!nameTextField) {
                        nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2-5, cell.frame.size.height)];
                        nameTextField.textAlignment = NSTextAlignmentRight;
                        nameTextField.font = labelFont;
                        [cell addSubview:nameTextField];
                    }
                    
                    nameTextField.text = user[@"Name"];
                    nameTextField.delegate = self;
                    
                    
                    return cell;
                    
                }
                    break;
                case 1:
                {
                    if (!phoneTextField)
                    {
                        phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2-5, cell.frame.size.height)];
                       phoneTextField.font = labelFont;
                        phoneTextField.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:phoneTextField];
                    }
                     phoneTextField.text = user[@"phone"];
                     phoneTextField.delegate = self;
                    
                }
                    break;
                case 2:
                {
                    if (!emailTextField) {
                        emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width-(self.view.frame.size.width/4), cell.frame.size.height)];
                        emailTextField.font = labelFont;
                        emailTextField.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:emailTextField];
                    }
                    emailTextField.text = user[@"email"];
                    emailTextField.delegate = self;
                }
                    break;
                case 3:
                {
                    
                    if (!profileImage) {
                        profImgLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2-5, cell.frame.size.height)];
                        profImgLbl.font = labelFont;
                        profImgLbl.text = @"Change Profile Image";
                        profImgLbl.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:profImgLbl];
                    }
                    else
                    {
                        [profImgLbl removeFromSuperview];
                        profImgLbl = nil;
                        
                        if (!profileImageView) {
                            profileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width - (cell.frame.size.height+10), 2, cell.frame.size.height-4, cell.frame.size.height-4)];
                            profileImageView.layer.cornerRadius = (cell.frame.size.height-4)/2;
                            profileImageView.clipsToBounds = YES;
                            [cell addSubview:profileImageView];
                        }
                        profileImageView.image = profileImage;
                        profileImageView.frame = CGRectMake(cell.frame.size.width - (cell.frame.size.height+10), 2, cell.frame.size.height-4, cell.frame.size.height-4);
                    }
                }

                    break;


                default:
                    cell.detailTextLabel.text = @"";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            
        }
    else
    {
        //User Not Logged in
    }

    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"Selected Index: %ld", (long)indexPath.row);
    
    switch (indexPath.row)
    {
        case 0:
        {
            // Edit Name
            
        }
            break;
        case 1:
        {
            //Phone Number
            
        }
            break;
        case 2:
        {
            //Email
            
        }
            break;
        case 3:
        {
            //Profile Image
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
            break;
        case 4:
        {
            //Physical Description
            [self performSegueWithIdentifier:@"show-edit-about" sender:self];
        }
            break;
        case 5:
        {
            //Skills
            
            //Get Profile
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Loading Profile..";
            
            NSLog(@"%@", member);
            PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
            [query whereKey:@"uid" equalTo:member];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %d Profiles.", objects.count);
                    // Do something with the found objects
                    profile = objects[0];
                    [hud hideAnimated:YES];
                    [self performSegueWithIdentifier:@"show-edit-skills" sender:self];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            break;
            
        }
        case 6:
        {
            //Credits
            
            [self performSegueWithIdentifier:@"show-edit-credits" sender:self];
            break;
        }
        case 7:
        {
            //Gallery
            //Get Gallery
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Loading Profile..";

            PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
            [query whereKey:@"uid" equalTo:member];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %d Profiles.", objects.count);
                    // Do something with the found objects
                    profile = objects[0];
                    [hud hideAnimated:YES];
                    [self performSegueWithIdentifier:@"show-edit-gallery" sender:self];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
            
        }
            break;
            
        default:
            break;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    profileImage = chosenImage;
    [profileTableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)Done:(id)sender
{
    NSLog(@"Done. Saving Profile");
    
    
    user[@"Name"] = nameTextField.text;
    user[@"phone"] = phoneTextField.text;
    user[@"email"] = emailTextField.text;
    
    NSData *imageData = UIImagePNGRepresentation(profileImageView.image);
    PFFile *imageFile = [PFFile fileWithName:@"profile-image" data:imageData];
    
    user[@"profileImage"] = imageFile;
    
    member[@"profileImage"] = imageFile;
    [member saveInBackground];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving Profile..";
    
    //Save
//    [user saveEventually];
//    NSLog(@"User Info Will Save eventually");
//    [self.navigationController popViewControllerAnimated:YES];
//    [hud hideAnimated:YES];
    
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"User Info Saved");
            [self.navigationController popViewControllerAnimated:YES];
            [hud hideAnimated:YES];
        } else {
            // There was a problem, check error.description
            NSLog(@"Error Saving User Info");
            [hud hideAnimated:YES];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops....."
                                                                           message:@"We seem to have hit an issue in setting up your account. Please try again. If the problem persists please contact app@thebritishstuntregister.com"
                                                                    preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];


            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"show-edit-about"])
    {
        EditAboutMeViewController *vc = segue.destinationViewController;
        vc.member = member;
    }
    if ([segue.identifier isEqualToString:@"show-edit-skills"]) {
        //Skills
        EditSkillsViewController *vc = segue.destinationViewController;
        vc.profile = profile;
    }
    if ([segue.identifier isEqualToString:@"show-edit-gallery"]) {
        //Skills
        EditGalleryViewController *vc = segue.destinationViewController;
        vc.profile = profile;
    }
    if ([segue.identifier isEqualToString:@"show-edit-credits"])
    {
        
    }
    
}



@end
