//
//  EditCreditsViewController.m
//  Stunts
//
//  Created by Richard Allen on 25/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "EditCreditsViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface EditCreditsViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    BOOL editMode;
    __block NSMutableArray *credits;
    __block NSMutableArray *creditsToDelete;
    
    __weak IBOutlet UITableView *creditsTableView;
    
    UIView *backgroundDarkView;
    UIView *addCreditView;
    
    //Text Fields
    UITextField *prodcutionTextField;
    UITextField *producerTextField;
    UITextField *jobTextField;
    UITextField *directorTextField;
    UIImage *contractImage;
    UILabel *contractButtonLabel;
    UIButton *addContractButton;
    
    MBProgressHUD *hud;
    
    UIView *noCreditView;
}
@end

@implementation EditCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    editMode = NO;
    credits = [[NSMutableArray alloc]init];
    creditsToDelete = [[NSMutableArray alloc]init];
    
    
    [self fetchCreditsForUser:[PFUser currentUser]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchCreditsForUser:(PFUser *)user
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Fetching Credits..";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
    [query whereKey:@"User" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu Credits.", (unsigned long)objects.count);
            // Do something with the found objects
            [hud hideAnimated:YES];
            if (objects.count == 0)
            {
                noCreditView = [[UIView alloc]initWithFrame:creditsTableView.frame];
                noCreditView.backgroundColor = [UIColor whiteColor];
                
                UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, noCreditView.frame.size.height/2-80, creditsTableView.frame.size.width, 160)];
                lbl.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.textColor = [UIColor blackColor];
                lbl.alpha = 0.4;
                lbl.text = @"No Credits To View";
                
                [noCreditView addSubview:lbl];
                
                [self.view addSubview:noCreditView];
            }
            else
            {
                for (PFObject *object in objects) {
                    [credits addObject:object];
                }
                [creditsTableView reloadData];
                
                if (noCreditView)
                {
                    [noCreditView removeFromSuperview];
                    noCreditView = nil;
                }
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
            
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    float f = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"%f", f);
    
        if (directorTextField.frame.origin.y+directorTextField.frame.size.height > f)
        {
            [addCreditView setFrame:CGRectMake(addCreditView.frame.origin.x, -20, addCreditView.frame.size.width, addCreditView.frame.size.height)];
        }
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [addCreditView setFrame:CGRectMake(addCreditView.frame.origin.x, 52, addCreditView.frame.size.width, addCreditView.frame.size.height)];
}
#pragma mark Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [credits count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    PFObject *credit = [credits objectAtIndex:indexPath.row];
    NSLog(@"Found Credit: %@", credit);
    
    cell.textLabel.text = credit[@"Production"];
    cell.detailTextLabel.text = credit[@"State"];
    
    cell.textLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    cell.detailTextLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editMode == YES)
    {
        PFObject *credit = [credits objectAtIndex:indexPath.row];
        [creditsToDelete addObject:credit];
        [credits removeObject:credit];
        [creditsTableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        PFObject *credit = [credits objectAtIndex:indexPath.row];
        [creditsToDelete addObject:credit];
        [credits removeObject:credit];
        [creditsTableView reloadData];
    }
}

- (IBAction)addCreditButton:(id)sender
{
    NSLog(@"Add Credit Pressed");
    
    if (!backgroundDarkView)
    {
        backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0;
        [self.view addSubview:backgroundDarkView];
        
        addCreditView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, self.view.frame.size.width-40, 570)];
        addCreditView.backgroundColor = [UIColor whiteColor];
        addCreditView.layer.cornerRadius = 10;
        addCreditView.clipsToBounds = YES;
        [self CreateCreditView];
        [self.view addSubview:addCreditView];
    }
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        addCreditView.frame = CGRectMake(20, 52, self.view.frame.size.width-40, 570);
        
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
    }];
    
}

-(void)CreateCreditView
{
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [addCreditView addSubview:logo];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 72, 226, 43)];
    headerLabel.text = @"Add a Credit";
    headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:36];
    [addCreditView addSubview:headerLabel];
    
    UILabel *seconndaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 115, 270, 50)];
    seconndaryLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Please add the required information ", @"and press save."];
    seconndaryLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    seconndaryLabel.numberOfLines = 0;
    seconndaryLabel.alpha = 0.5;
    [addCreditView addSubview:seconndaryLabel];
    
    /******* Production Name Cell ********/
    UILabel *productionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.65, 182, 94.17, 20)];
    productionLabel.text = @"Project Name";
    productionLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    productionLabel.numberOfLines = 0;
    [addCreditView addSubview:productionLabel];
    
    prodcutionTextField = [[UITextField alloc] initWithFrame:CGRectMake(109, 180, 217, 24)];
    prodcutionTextField.textAlignment = NSTextAlignmentRight;
    prodcutionTextField.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    prodcutionTextField.borderStyle = UITextBorderStyleNone;
    prodcutionTextField.delegate = self;
    [addCreditView addSubview:prodcutionTextField];
    
    UIView *separator1 = [[UIView alloc]initWithFrame:CGRectMake(7, 208, 320, 1)];
    separator1.backgroundColor = [UIColor blackColor];
    separator1.alpha = 0.1;
    [addCreditView addSubview:separator1];
    
    /******* Producer Cell ********/
    UILabel *producerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 218, 95, 40)];
    producerLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Producer /", @"Studio"];
    producerLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    producerLabel.numberOfLines = 0;
    [addCreditView addSubview:producerLabel];
    
    producerTextField = [[UITextField alloc] initWithFrame:CGRectMake(109, 230, 217, 24)];
    producerTextField.textAlignment = NSTextAlignmentRight;
    producerTextField.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    producerTextField.borderStyle = UITextBorderStyleNone;
    producerTextField.delegate = self;
    [addCreditView addSubview:producerTextField];
    
    UIView *separator2 = [[UIView alloc]initWithFrame:CGRectMake(7, 261, 320, 1)];
    separator2.backgroundColor = [UIColor blackColor];
    separator2.alpha = 0.1;
    [addCreditView addSubview:separator2];
    
    /******* Job Cell ********/
    UILabel *jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.65, 285, 94.17, 20)];
    jobLabel.text = @"Job Role";
    jobLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    jobLabel.numberOfLines = 0;
    [addCreditView addSubview:jobLabel];
    
    jobTextField = [[UITextField alloc] initWithFrame:CGRectMake(109, 281, 217, 24)];
    jobTextField.textAlignment = NSTextAlignmentRight;
    jobTextField.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    jobTextField.borderStyle = UITextBorderStyleNone;
    jobTextField.delegate = self;
    [addCreditView addSubview:jobTextField];
    
    UIView *separator3 = [[UIView alloc]initWithFrame:CGRectMake(7, 311, 320, 1)];
    separator3.backgroundColor = [UIColor blackColor];
    separator3.alpha = 0.1;
    [addCreditView addSubview:separator3];
    
    /******* Director Cell ********/
    UILabel *directorLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.65, 347, 94.17, 20)];
    directorLabel.text = @"Co-Ordinator";
    directorLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    directorLabel.numberOfLines = 0;
    [addCreditView addSubview:directorLabel];
    
    directorTextField = [[UITextField alloc] initWithFrame:CGRectMake(109, 342, 217, 24)];
    directorTextField.textAlignment = NSTextAlignmentRight;
    directorTextField.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    directorTextField.borderStyle = UITextBorderStyleNone;
    directorTextField.delegate = self;
    [addCreditView addSubview:directorTextField];
    
    UIView *separator4 = [[UIView alloc]initWithFrame:CGRectMake(7, 373, 320, 1)];
    separator4.backgroundColor = [UIColor blackColor];
    separator4.alpha = 0.1;
    [addCreditView addSubview:separator4];
    
    /******* Add Contract Page ********/
    addContractButton = [[UIButton alloc]initWithFrame:CGRectMake(26, 397, 71, 71)];
    [addContractButton setImage:[UIImage imageNamed:@"contract-button78"] forState:UIControlStateNormal];
    [addContractButton addTarget:self action:@selector(addContractImage) forControlEvents:UIControlEventTouchUpInside];
    [addCreditView addSubview:addContractButton];
    
    UILabel *contractButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(109, 409, 136, 50)];
    contractButtonLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Upload page", @"one of contract"];
    contractButtonLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    contractButtonLabel.numberOfLines = 0;
    contractButtonLabel.alpha = 0.5;
    [addCreditView addSubview:contractButtonLabel];
    
    /******* Save Button ********/
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(47, 497, 242, 51)];
    [saveButton setImage:[UIImage imageNamed:@"save-button"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(SaveCredit) forControlEvents:UIControlEventTouchUpInside];
    [addCreditView addSubview:saveButton];
    
    
    
    
    
}

-(void)addContractImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image Selected");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    contractImage = chosenImage;
    [addContractButton setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Image Selection Cancelled");
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)SaveCredit
{
    
    NSString *errorString;
    if ([prodcutionTextField.text isEqualToString:@""])
    {
        errorString = @"Please enter a production name.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                       message:errorString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([producerTextField.text isEqualToString:@""])
    {
        errorString = @"Please enter the Producer or Studio that emaployed you.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                       message:errorString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([jobTextField.text isEqualToString:@""])
    {
        errorString = @"Please enter your job title on this project.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                       message:errorString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([directorTextField.text isEqualToString:@""])
    {
        errorString = @"Please enter the name of the director on the project.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                       message:errorString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (!contractImage)
    {
        errorString = @"Please choose an image of your contract from your photos.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                       message:errorString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    PFObject *credit = [PFObject objectWithClassName:@"Credits"];
    credit[@"User"] = [PFUser currentUser];
    credit[@"Member"] = [PFUser currentUser][@"Member"];
    credit[@"Production"] = prodcutionTextField.text;
    credit[@"Producer"] = producerTextField.text;
    credit[@"JobRole"] = jobTextField.text;
    credit[@"Coordinator"] = directorTextField.text;
    credit[@"Imported"] = [NSNumber numberWithBool:NO];
    credit[@"State"] = @"Pending";
    
    //Image
    NSData *imageData = UIImagePNGRepresentation(contractImage);
    PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"Contract - %@", prodcutionTextField.text] data:imageData];
    credit[@"Contract"] = imageFile;

    
    [credits addObject:credit];
    [creditsTableView reloadData];
    

    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height, self.view.frame.size.width-40, 570);
        addCreditView = nil;
        backgroundDarkView = nil;
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
        if (noCreditView)
        {
            [noCreditView removeFromSuperview];
            noCreditView = nil;
        }
        
    }];
}

-(IBAction)nextButtonPressed
{
    //Show Saving HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Submitting Credits";
    
    int __block creditsToSave = credits.count;
    
    if (creditsToSave == 0 && (creditsToDelete.count != 0))
    {
        [self deleteCreditsForDeletion];
        return;
    }
    else if (creditsToSave == 0 && (creditsToDelete.count == 0))
    {
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    for (PFObject *credit in credits)
    {
        [credit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                NSLog(@"Credit Saved");
                creditsToSave --;
                if (creditsToSave == 0)
                {
                    [self deleteCreditsForDeletion];
                    
                }
            } else {
                // There was a problem, check error.description
                [hud hideAnimated:YES];
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops...."
                                                                               message:[NSString stringWithFormat: @"We seem to have hit an error please try again. If the problem persist please contact britishstuntapp@gmail.com (code: %ld", (long)error.code]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
    
    
}

-(void)deleteCreditsForDeletion
{
    int __block creditsToDeleteCount = creditsToDelete.count;
    
    if (creditsToDeleteCount == 0)
    {
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    for (PFObject *credit in creditsToDelete)
    {
        [credit deleteInBackground];
    }
    [hud hideAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}




#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
@end
