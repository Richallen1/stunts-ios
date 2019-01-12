//
//  OnboardingCreditsViewController.m
//  Stunts
//
//  Created by Richard Allen on 04/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "OnboardingCreditsViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <Crashlytics/Crashlytics.h>
#import "AppImports.h"

@interface OnboardingCreditsViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    NSMutableArray *credits;
    NSMutableArray *preApprovedCreditsFound;
    __weak IBOutlet UITableView *creditsTableView;
    
    UIView *backgroundDarkView;
    UIView *addCreditView;
    
    //Text Fields
    UITextField *prodcutionTextField;
    UITextField *producerTextField;
    UITextField *jobTextField;
    UITextField *CoordinatorTextField;
    UIImage *contractImage;
    UILabel *contractButtonLabel;
    UIButton *addContractButton;
    
    SCErrorController *sharedManager;
}
@end

@implementation OnboardingCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    credits = [[NSMutableArray alloc]init];
    SCErrorController *sharedManager = [SCErrorController sharedManager];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Credits";
    [hud showAnimated:YES];
    
    NSString *userName = [PFUser currentUser][@"Name"];
    NSArray *terms = [userName componentsSeparatedByString:@" "];
    NSString *firstName = [terms objectAtIndex:0];
    NSString *lastName = [terms objectAtIndex:1];
    
    PFQuery *query = [PFQuery queryWithClassName:@"PreApprovedCredits"];
    [query whereKey:@"FirstName" equalTo:firstName];
    [query whereKey:@"LastName" equalTo:lastName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [hud hideAnimated:YES];
        [self ShowCreditInfo];
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if (objects.count > 0)
            {
                for (PFObject *obj in objects)
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setObject:[PFUser currentUser] forKey:@"User"];
                    [dict setObject:obj[@"Production"] forKey:@"Production"];
                    [dict setObject:obj[@"JobRole"] forKey:@"JobRole"];
                    [dict setObject:@"Approved" forKey:@"State"];
                    [obj delete];
   
                    [credits addObject:dict];
                }
            
                [creditsTableView reloadData];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    return;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowCreditInfo
{

    if (!backgroundDarkView)
    {
        backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0;
        [self.view addSubview:backgroundDarkView];
        
        addCreditView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 335, 200)];
        addCreditView.backgroundColor = [UIColor whiteColor];
        addCreditView.layer.cornerRadius = 10;
        addCreditView.clipsToBounds = YES;
        [self.view addSubview:addCreditView];
    }
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [addCreditView addSubview:logo];

    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, addCreditView.frame.size.width-20, 100)];
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = @" You will need to submit a photo of the front page of your contract. These will then be verified by the British Stunt Register comittee. We have loaded in your pre verified credits";
    infoLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    infoLabel.numberOfLines = 0;
    [addCreditView addSubview:infoLabel];
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(47, addCreditView.frame.size.height-55, 242, 51)];
    [saveButton setImage:[UIImage imageNamed:@"ok_Button"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(acknowledgeMessage:) forControlEvents:UIControlEventTouchUpInside];
    [addCreditView addSubview:saveButton];
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        addCreditView.frame = CGRectMake(20, self.view.bounds.size.height/2-100, 335, 200);
        
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
    }];
    
    
}

-(void)acknowledgeMessage:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^
    {
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.bounds.size.height, 335, 200);
    }
    completion:^(BOOL finished)
    {
        NSLog(@"Transition Complete");
        addCreditView = nil;
        backgroundDarkView = nil;
    }];
    
    
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    float f = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"%f", f);
    
    if (CoordinatorTextField.frame.origin.y+CoordinatorTextField.frame.size.height > f)
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
    NSMutableDictionary *currentDict = [credits objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [currentDict objectForKey:@"Production"];
    cell.detailTextLabel.text = [currentDict objectForKey:@"State"];
    
    cell.textLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    cell.detailTextLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    
    
    return cell;
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
        
        addCreditView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 335, 570)];
        addCreditView.backgroundColor = [UIColor whiteColor];
        addCreditView.layer.cornerRadius = 10;
        addCreditView.clipsToBounds = YES;
        [self CreateCreditView];
        [self.view addSubview:addCreditView];
    }
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        addCreditView.frame = CGRectMake(20, 52, 335, 570);
        
        
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
    [addCreditView addSubview:jobTextField];
    
    UIView *separator3 = [[UIView alloc]initWithFrame:CGRectMake(7, 311, 320, 1)];
    separator3.backgroundColor = [UIColor blackColor];
    separator3.alpha = 0.1;
    [addCreditView addSubview:separator3];
    
     /******* Coordinator Cell ********/
    UILabel *CoordinatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.65, 347, 94.17, 20)];
    CoordinatorLabel.text = @"Coordinator";
    CoordinatorLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    CoordinatorLabel.numberOfLines = 0;
    [addCreditView addSubview:CoordinatorLabel];
    
    CoordinatorTextField = [[UITextField alloc] initWithFrame:CGRectMake(109, 342, 217, 24)];
    CoordinatorTextField.textAlignment = NSTextAlignmentRight;
    CoordinatorTextField.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    CoordinatorTextField.borderStyle = UITextBorderStyleNone;
    [addCreditView addSubview:CoordinatorTextField];
    
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
    
    //Set Delegates
    prodcutionTextField.delegate = self;
    producerTextField.delegate = self;
    jobTextField.delegate = self;
    CoordinatorTextField.delegate = self;
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
    if ([prodcutionTextField.text isEqualToString:@""])
    {
        [sharedManager presentAlertWithOnboardingErrorCode:101 InPresenter:self withError:nil];
        return;
    }
    if ([producerTextField.text isEqualToString:@""])
    {
        [sharedManager presentAlertWithOnboardingErrorCode:102 InPresenter:self withError:nil];
        return;
    }
    if ([jobTextField.text isEqualToString:@""])
    {
        [sharedManager presentAlertWithOnboardingErrorCode:103 InPresenter:self withError:nil];
        return;
    }
    if ([CoordinatorTextField.text isEqualToString:@""])
    {
        [sharedManager presentAlertWithOnboardingErrorCode:104 InPresenter:self withError:nil];
        return;
    }
    if (!contractImage)
    {
        [sharedManager presentAlertWithOnboardingErrorCode:105 InPresenter:self withError:nil];
        return;
    }

    NSMutableDictionary *credit = [[NSMutableDictionary alloc]init];
    [credit setObject:prodcutionTextField.text forKey:@"Production"];
    [credit setObject:jobTextField.text forKey:@"JobRole"];
//    [credit setObject:producerTextField.text forKey:@"Producer"];
//    [credit setObject:CoordinatorTextField.text forKey:@"Coordinator"];
    [credit setObject:contractImage forKey:@"Contract"];
    [credit setObject:@"Pending" forKey:@"State"];
    
    [credits addObject:credit];
    [creditsTableView reloadData];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height, 335, 570);
        addCreditView = nil;
        backgroundDarkView = nil;
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
}

-(IBAction)nextButtonPressed
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving Credits";
    [hud showAnimated:YES];
    
    backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0;
    [self.view addSubview:backgroundDarkView];
    
    addCreditView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 335, 335)];
    addCreditView.backgroundColor = [UIColor whiteColor];
    addCreditView.layer.cornerRadius = 10;
    addCreditView.clipsToBounds = YES;
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [addCreditView addSubview:logo];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(79, 77, 175, 43)];
    headerLabel.text = @"Complete";
    headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:36];
    [addCreditView addSubview:headerLabel];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 131, 270, 100)];
    infoLabel.text = [NSString stringWithFormat:@"You’re all set! You have %lu pending credits. These will only show on your profile once they have been approved.", (unsigned long)credits.count];
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    [addCreditView addSubview:infoLabel];
    
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(21, 245, 292, 45)];
    [doneButton setImage:[UIImage imageNamed:@"Done-Button"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(creditCompletePopoverComplete:) forControlEvents:UIControlEventTouchUpInside];
    [addCreditView addSubview:doneButton];
    
    [self.view addSubview:addCreditView];
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height/2-167, 335, 335);
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
    
    
    
}

-(void)PopoverDoneButton
{
    [self performSegueWithIdentifier:@"creditsDone" sender:self];
}

-(void)creditCompletePopoverComplete:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height, 335, 335);
        addCreditView = nil;
        backgroundDarkView = nil;
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        //[self performSegueWithIdentifier:@"creditsDone" sender:self];
        
        if (credits.count == 0)
        {
            [self performSegueWithIdentifier:@"creditsDone" sender:self];
            return;
        }
        
        //Show Saving HUD
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Submitting Credits";


        int __block creditsToSave = credits.count;
        
        for (NSMutableDictionary *creditDict in credits)
        {
            PFObject *credit = [PFObject objectWithClassName:@"Credits"];
            credit[@"Production"] = [creditDict objectForKey:@"Production"];
            credit[@"JobRole"] = [creditDict objectForKey:@"JobRole"];;
            credit[@"State"] = [creditDict objectForKey:@"State"];
            credit[@"User"] = [PFUser currentUser];
            
            if ([creditDict objectForKey:@"Contract"])
            {
                //Image
                NSData *imageData = UIImagePNGRepresentation([creditDict objectForKey:@"Contract"]);
                PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"Contract - %@", [creditDict objectForKey:@"Production"]] data:imageData];
                credit[@"Contract"] = imageFile;
            }
            
            
            [credit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Credit Saved");
                    creditsToSave --;
                    if (creditsToSave == 0)
                    {
                        //END
                        [hud hideAnimated:YES];
                        [self performSegueWithIdentifier:@"creditsDone" sender:self];
                    }
                    [PFUser currentUser][@"Onboarding_Credit"] = [NSNumber numberWithBool:YES];
                    [[PFUser currentUser] saveInBackground];
                } else {
                    // There was a problem, check error.description
                    [sharedManager presentAlertWithOnboardingErrorCode:201 InPresenter:self withError:error];
                    [hud hideAnimated:YES];
                }
            }];
        }
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"creditsDone"])
    {
        
        
    }
}


@end
