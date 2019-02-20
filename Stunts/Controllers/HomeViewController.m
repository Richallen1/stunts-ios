//
//  HomeViewController.m
//  Stunts
//
//  Created by Richard Allen on 27/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "HomeViewController.h"
#import "MembersCollectionViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import <Crashlytics/Crashlytics.h>
#import "AppImports.h"
#import "AppDelegate.h"
#import <Realm/Realm.h>
#import "Members.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UITableView *homeTableView;
    int selectedIndex;
    UIView *userMenuPopover;
    
    //Popover
    UIView *backgroundDarkView;
    UIView *popoverContainerView;
    UIView *addCreditView;
    
    //Add Credit
    UITextField *prodcutionTextField;
    UITextField *producerTextField;
    UITextField *jobTextField;
    UITextField *CoordinatorTextField;
    UIImage *contractImage;
    UILabel *contractButtonLabel;
    UIButton *addContractButton;
    
    PFObject *rejectedCredit;
    SCErrorController *sharedManager;
    
    //Popover for Prodcution User
    UIView *popoverView;
    BOOL isProdFirstTime;
    
    __block AppDelegate *delegate;
}
@end

@implementation HomeViewController
@synthesize isProdFirstTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    NSLog(@"%@", self.tabBarController.viewControllers);
    NSLog(@"%lu", self.tabBarController.viewControllers.count);
    
    [self CheckTermsAccepted];
 
    NSMutableArray *newTabs = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
    NSLog(@"TABS: %lu", (unsigned long)newTabs.count);
    
    if (![PFUser currentUser][@"Admin"] == YES)
    {
        NSMutableArray *newTabs = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [newTabs removeObjectAtIndex: 4];
        [self.tabBarController setViewControllers:newTabs];
    }
    else
    {
        [self CheckForPendingCredits];
    }
    NSLog(@"%@", [PFUser currentUser][@"AccountType"]);
    if([[[PFUser currentUser][@"AccountType"] lowercaseString] isEqualToString:@"producer"] == YES){
        NSMutableArray *newTabs = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [newTabs removeObjectAtIndex:1];
        [self.tabBarController setViewControllers:newTabs];
    }
    
    [self CheckForRejectedCredits];
    sharedManager = [SCErrorController sharedManager];
    
    if ([[PFUser currentUser][@"AccountType"] isEqualToString:@"Producer"])
    {
        if ([[PFUser currentUser][@"FirstTime"] boolValue] == YES)
        {
            isProdFirstTime = YES;
            [self initProdPopover];
        }
        
    }
    
//    [self GetLists];
    
}
-(void)ShowRedDotForCreditsIcon
{
    //Show Red Dot If Credits Pending.
    float iconFrameStart = (self.tabBarController.tabBar.frame.size.width/4)*3;
    float iconSize = self.tabBarController.tabBar.frame.size.width-iconFrameStart;
    
    UIView *redDot = [[UIView alloc]initWithFrame:CGRectMake((iconFrameStart+(iconSize/2)+10), 3, 15, 15)];
    redDot.layer.cornerRadius = 7.5;
    redDot.clipsToBounds = YES;
    redDot.backgroundColor = [UIColor redColor];
    [self.tabBarController.tabBar addSubview:redDot];
}
-(void)viewDidAppear:(BOOL)animated
{
    //[self CheckIfOnboardingComplete];
    if (rejectedCredit)
    {
        if (!backgroundDarkView)
        {
            backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
            backgroundDarkView.backgroundColor = [UIColor blackColor];
            backgroundDarkView.alpha = 0;
            [self.view addSubview:backgroundDarkView];
            
            
            popoverContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 335, 527)];
            popoverContainerView.backgroundColor = [UIColor whiteColor];
            popoverContainerView.layer.cornerRadius = 10;
            popoverContainerView.clipsToBounds = YES;
            [self BuildNotificationView];
            [self.view addSubview:popoverContainerView];
            
            [UIView animateWithDuration:0.4f animations:^{
                
                [backgroundDarkView setAlpha:0.4f];
                popoverContainerView.frame = CGRectMake(20, (self.view.bounds.size.height/2)-263, 335, 527);
                
                
            } completion:^(BOOL finished) {
                
                NSLog(@"Transition Complete");
            }];
        }
    }
    if (isProdFirstTime == YES)
    {
        [self AnimatePopoverOnScreen];
    }
}

-(void)initProdPopover
{
    backgroundDarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0;
    
    [self.view addSubview:backgroundDarkView];
    
    
    popoverView = [[UIView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height, 327, 486)];
    popoverView.backgroundColor = [UIColor whiteColor];
    popoverView.layer.cornerRadius = 25;
    popoverView.clipsToBounds = YES;
    
    [self.view addSubview:popoverView];
    
    UIImageView* image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BSR-Logo50"]];
    image.frame = CGRectMake(163 - (image.frame.size.width / 2.0), 30, image.frame.size.width, image.frame.size.height);
    [popoverView addSubview:image];
    
    UILabel *headerLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(26, 100, 263, 32)];
    headerLabel1.text = @"Welcome";
    headerLabel1.font = [UIFont fontWithName:@"SFProText-Bold" size:26];
    [popoverView addSubview:headerLabel1];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 136, 263, 200)];
    infoLabel.text = @"Welcome the the British Stunt Register app. We are pleased to be opening this up to the members.\n\nThis is the public version and so if anything doesn’t seem quite right or you experience any issues please email: ";
    infoLabel.numberOfLines = 0;
    [infoLabel setTextColor:UIColorFromRGB(0X000000)];
    infoLabel.font = [UIFont fontWithName:@"SFProText" size:14];
    [popoverView addSubview:infoLabel];
    
    UILabel *infoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(23, 334, 263, 70)];
    
    infoLabel2.text = @"app@thebritishstuntregister.com";
    infoLabel2.numberOfLines = 0;
    [infoLabel2 setTextColor:UIColorFromRGB(0X000000)];
    infoLabel2.font = [UIFont fontWithName:@"SFProText" size:14];
    [popoverView addSubview:infoLabel2];
    
    
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(59, 430, 210, 41)];
    [doneButton setImage:[UIImage imageNamed:@"Done_List_242"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(AnimatePopoverOffScreen:) forControlEvents:UIControlEventTouchUpInside];
    [popoverView addSubview:doneButton];
    
}

-(void)AnimatePopoverOnScreen
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        popoverView.frame = CGRectMake(20, 100, 327, 486);
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
        
    }];
}

-(void)AnimatePopoverOffScreen:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        popoverView.frame = CGRectMake(20, self.view.frame.size.height, 327, 486);
        
    } completion:^(BOOL finished) {
        [PFUser currentUser][@"FirstTime"] = [NSNumber numberWithBool:YES];
        [[PFUser currentUser] save];
        isProdFirstTime = NO;
        NSLog(@"Transition Complete");
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Credit Functions
-(void)CheckForRejectedCredits
{
 
    NSArray *rejectedCredits = [PFUser currentUser][@"RejectedCredits"];
    NSLog(@"%@", [PFUser currentUser]);
    if (rejectedCredits.count > 0)
    {
        rejectedCredit = [rejectedCredits[0] fetch];
        NSLog(@"%@", rejectedCredit);
    }
}

-(void)BuildNotificationView
{
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [popoverContainerView addSubview:logo];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(295, 13, 25, 25)];
    [closeButton setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePopover:) forControlEvents:UIControlEventTouchUpInside];
    [popoverContainerView addSubview:closeButton];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 72, 282, 43)];
    headerLabel.text = @"Credit Rejected";
    headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:30];
    [popoverContainerView addSubview:headerLabel];
    
    UILabel *seconndaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 110, 270, 50)];
    seconndaryLabel.text = @"One of your credits has been rejected. See details below:";
    seconndaryLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    seconndaryLabel.numberOfLines = 0;
    seconndaryLabel.alpha = 0.6;
    [popoverContainerView addSubview:seconndaryLabel];
    
    /******* Production ********/
    UILabel *productionHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 188, 99, 19)];
    productionHeaderLabel.text = @"Production:";
    productionHeaderLabel.alpha = 0.6;
    productionHeaderLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    productionHeaderLabel.numberOfLines = 0;
    [popoverContainerView addSubview:productionHeaderLabel];
    
    UILabel *productionLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 207, 310, 19)];
    productionLabel.text = rejectedCredit[@"Production"];
    productionLabel.alpha = 0.6;
    productionLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    productionLabel.textAlignment = NSTextAlignmentRight;
    productionLabel.numberOfLines = 0;
    [popoverContainerView addSubview:productionLabel];
    
    /******* Rejection Reason ********/
    UILabel *reasonHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 245, 270, 19)];
    reasonHeaderLabel.text = @"Reason for Rejection:";
    reasonHeaderLabel.alpha = 0.6;
    reasonHeaderLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    reasonHeaderLabel.numberOfLines = 0;
    [popoverContainerView addSubview:reasonHeaderLabel];
    
    UITextView *reasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(16, 267, 299, 122)];
    reasonTextView.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    reasonTextView.text = rejectedCredit[@"RejectReason"];
    reasonTextView.editable = NO;
    reasonTextView.layer.cornerRadius = 5;
    reasonTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    reasonTextView.clipsToBounds = YES;
    [popoverContainerView addSubview:reasonTextView];
    
    /******* Reviewer ********/
    UILabel *reviewerHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 421, 78, 19)];
    reviewerHeaderLabel.text = @"Reviewer:";
    reviewerHeaderLabel.alpha = 0.6;
    reviewerHeaderLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    reviewerHeaderLabel.textAlignment = NSTextAlignmentRight;
    reviewerHeaderLabel.numberOfLines = 0;
    [popoverContainerView addSubview:reviewerHeaderLabel];
    
    PFUser *reviewer = [rejectedCredit[@"Reviewer"] fetch];
    
    UILabel *reviewerLabel = [[UILabel alloc]initWithFrame:CGRectMake(181, 421, 147, 19)];
    reviewerLabel.text = reviewer[@"Name"];
    reviewerLabel.alpha = 0.6;
    reviewerLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    reviewerLabel.textAlignment = NSTextAlignmentRight;
    reviewerLabel.numberOfLines = 0;
    reviewerLabel.textAlignment = NSTextAlignmentRight;
    [popoverContainerView addSubview:reviewerLabel];
    
    /******* Next Button ********/
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(51, 462, 242, 51)];
    [nextButton setImage:[UIImage imageNamed:@"resubmit-credit"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(resubmitCredit:) forControlEvents:UIControlEventTouchUpInside];
    [popoverContainerView addSubview:nextButton];
    
}
-(void)closePopover:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        popoverContainerView.frame = CGRectMake(20, self.view.frame.size.height, 335, 527);
        
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        backgroundDarkView = nil;
        popoverContainerView = nil;
        
    }];
}

-(void)resubmitCredit:(id)sender
{
    NSMutableArray *rejectedCredits = [[NSMutableArray alloc]initWithArray:[PFUser currentUser][@"RejectedCredits"]];
    [rejectedCredits removeObject:rejectedCredit];
    
    [PFUser currentUser][@"RejectedCredits"] = [NSArray arrayWithArray:rejectedCredits];
    
    //Save User
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"User Saved");
            
            //Delete Rejected Credit
            [rejectedCredit deleteInBackground];
            rejectedCredit = nil;
            
            //Show Credit Info
            [self AddNewCredit];
            
        } else {
            // There was a problem, check error.description
            NSLog(@"Error Saving User: %@", error.description);
        }
    }];
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        popoverContainerView.frame = CGRectMake(20, self.view.frame.size.height, 335, 527);
        
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
}

#pragma mark - Add Credit Methods
-(void)AddNewCredit
{
    if (!backgroundDarkView)
    {
        backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0;
        [self.view addSubview:backgroundDarkView];
    }
    if (!addCreditView)
    {
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
        
        NSLog(@"Show Add CreditTransition Complete");
    }];
}

-(void)CreateCreditView
{
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [addCreditView addSubview:logo];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 12, 40, 40)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(CloseCreditView:) forControlEvents:UIControlEventTouchUpInside];
    [addCreditView addSubview:closeButton];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)CloseCreditView:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height, 335, 570);
        
    } completion:^(BOOL finished) {
        [addCreditView removeFromSuperview];
        [backgroundDarkView removeFromSuperview];
        addCreditView = nil;
        backgroundDarkView = nil;
        NSLog(@"Transition Complete");
        
    }];
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
    //Show Saving HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Submitting Credits";

    PFObject *credit = [PFObject objectWithClassName:@"Credits"];
    credit[@"Production"] = prodcutionTextField.text;
    credit[@"Producer"] = producerTextField.text;
    credit[@"JobRole"] = jobTextField.text;
    credit[@"Coordinator"] = CoordinatorTextField.text;
    credit[@"State"] = @"Pending";
    credit[@"User"] = [PFUser currentUser];
    
    //Image
    NSData *imageData = UIImagePNGRepresentation(contractImage);
    PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"Contract - %@", prodcutionTextField.text] data:imageData];
    credit[@"Contract"] = imageFile;
    
    [credit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Credit Saved");
            
                //END
                [hud hideAnimated:YES];
            
          
        } else {
            // There was a problem, check error.description
            [CrashlyticsKit recordError:error];
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
    
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        addCreditView.frame = CGRectMake(20, self.view.frame.size.height, 335, 570);
        
    } completion:^(BOOL finished) {
        [addCreditView removeFromSuperview];
        [backgroundDarkView removeFromSuperview];
        addCreditView = nil;
        backgroundDarkView = nil;
        NSLog(@"Transition Complete");
        
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    /*Background To Cell*/
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, cell.frame.size.width-20, cell.frame.size.height-10)];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundView.clipsToBounds = YES;
    backgroundView.layer.cornerRadius = 8;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    /*Alpha Mask*/
    UIView *blackMaskAlpha = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height)];
    blackMaskAlpha.backgroundColor = [UIColor blackColor];
    blackMaskAlpha.alpha = 0.4;
    
    /*Category and Member Count Labels*/
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height/2-20, cell.frame.size.width, 25)];
    categoryLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:30];
    categoryLabel.textColor = [UIColor whiteColor];
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *membersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height/2+20, cell.frame.size.width, 20)];
    membersCountLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:18];
    membersCountLabel.textColor = [UIColor whiteColor];
    membersCountLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSLog(@"%@", cell);
    switch (indexPath.row)
    {
        case 0:
        {
            backgroundView.image = [UIImage imageNamed:@"MaleMembersButton"];
            categoryLabel.text = @"Male";
            membersCountLabel.text = [self getMembersCount:@"Male"];
        }
            break;
        case 1:
        {
            backgroundView.image = [UIImage imageNamed:@"FemaleMembersButton"];
            categoryLabel.text = @"Female";
            membersCountLabel.text = [self getMembersCount:@"Female"];
        }
            break;
        case 2:
        {
            backgroundView.image = [UIImage imageNamed:@"AllPerformersButton"];
            categoryLabel.text = @"All Performers";
            membersCountLabel.text = [self getMembersCount:@"All"];
        }
            break;
            
        default:
            break;
    }
    
    [backgroundView addSubview:blackMaskAlpha];
    [cell addSubview:backgroundView];
    [cell addSubview:categoryLabel];
    [cell addSubview:membersCountLabel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    NSLog(@"%f", tabBarHeight);
    float useableTableViewHeight = tableView.frame.size.height - tabBarHeight;
    return useableTableViewHeight/3;
}

-(NSString *)getMembersCount:(NSString *)type
{
    if ([type isEqualToString:@"Male"])
        //return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members objectsWhere:@"Sex = 'Male'"].count];
        return @"367 Members";
    if ([type isEqualToString:@"Female"])
        //return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members objectsWhere:@"Sex = 'Female'"].count];
        return @"75 Members";
    if ([type isEqualToString:@"All"])
        //return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members allObjects].count];
        return @"442 Members";
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"show-member-segue" sender:self];
}

#pragma mark - Actions
- (IBAction)ShowUserProfile:(id)sender
{
    NSLog(@"Show User Menu");
    
    
    if (userMenuPopover)
    {
        [self ShowHideUserMenu];
    }
    else
    {
        //Show Menu
        userMenuPopover = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-125, -150, 120, 120)];
        userMenuPopover.backgroundColor = [UIColor whiteColor];
        userMenuPopover.layer.cornerRadius = 5;
        
        [self.view addSubview:userMenuPopover];
        //Profile Icon
        UIImageView *profileIcon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 20, 20)];
        profileIcon.image = [UIImage imageNamed:@"User50"];
        [userMenuPopover addSubview:profileIcon];
        
        //Edit Profile
        UIButton *editProfile = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, userMenuPopover.frame.size.width-25, 20)];
        [editProfile setTitle:@"Edit Profile" forState:UIControlStateNormal];
        editProfile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [editProfile.titleLabel setFont:[UIFont fontWithName:@"SFProText-Light" size:14]];
        [editProfile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editProfile addTarget:self action:@selector(editProfileButton:) forControlEvents:UIControlEventTouchUpInside];
        [userMenuPopover addSubview:editProfile];
        
        //Separator
        UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(5, 60, userMenuPopover.frame.size.width-10, .7)];
        separator.backgroundColor = [UIColor blackColor];
        separator.alpha = 0.3;
        [userMenuPopover addSubview:separator];
        
        //Logout Icon
        UIImageView *logoutIcon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 65, 20, 20)];
        logoutIcon.image = [UIImage imageNamed:@"logout25"];
        [userMenuPopover addSubview:logoutIcon];
        
        //Logout
        UIButton *logoutProfile = [[UIButton alloc]initWithFrame:CGRectMake(30, 65, userMenuPopover.frame.size.width-25, 20)];
        [logoutProfile setTitle:@"Logout" forState:UIControlStateNormal];
        logoutProfile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [logoutProfile.titleLabel setFont:[UIFont fontWithName:@"SFProText-Light" size:14]];
        [logoutProfile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [logoutProfile addTarget:self action:@selector(Logout:) forControlEvents:UIControlEventTouchUpInside];
        [userMenuPopover addSubview:logoutProfile];
        
        
        
        if([[PFUser currentUser] objectForKey:@"AccountType"] != NULL && [[[[PFUser currentUser] objectForKey:@"AccountType"] lowercaseString]  isEqual: @"producer"]){
            userMenuPopover.frame = CGRectMake(self.view.frame.size.width-125, homeTableView.frame.origin.y-5, 120, 60);
            [profileIcon removeFromSuperview];
            [editProfile removeFromSuperview];
            [separator removeFromSuperview];
            logoutProfile.frame = CGRectMake(30, 5, userMenuPopover.frame.size.width - 25, 20);
            logoutIcon.frame = CGRectMake(5, 5, 20, 20);
        }
        
        
        [UIView animateWithDuration:0.4f animations:^{
            userMenuPopover.frame = CGRectMake(self.view.frame.size.width-125, homeTableView.frame.origin.y-5, userMenuPopover.frame.size.width, userMenuPopover.frame.size.height);
            //        userMenuPopover.layer.masksToBounds = NO;
            //        userMenuPopover.layer.shadowOffset = CGSizeMake(-15, 20);
            //        userMenuPopover.layer.shadowRadius = 5;
            //        userMenuPopover.layer.shadowOpacity = 0.5;
            
        } completion:^(BOOL finished) {
            NSLog(@"Transition Complete");
            
        }];
    }
}

-(void)ShowHideUserMenu
{
    if (userMenuPopover.frame.origin.y == -150)
    {
        [UIView animateWithDuration:0.4f animations:^{
            userMenuPopover.frame = CGRectMake(self.view.frame.size.width-125, homeTableView.frame.origin.y-5, userMenuPopover.frame.size.width, userMenuPopover.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            NSLog(@"Transition Complete");
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4f animations:^{
            userMenuPopover.frame = CGRectMake(self.view.frame.size.width-125, -150, userMenuPopover.frame.size.width, userMenuPopover.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            NSLog(@"Transition Complete");
            
        }];
    }
}


-(void)editProfileButton:(id)sender
{
    [self ShowHideUserMenu];
    [self performSegueWithIdentifier:@"show-edit-profile" sender:self];
}

-(void)Logout:(id)sender
{
    [self ShowHideUserMenu];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pwd"];
    [PFUser logOut];
}

-(void)CheckForPendingCredits
{
    PFQuery *query = [PFQuery queryWithClassName:@"Credits"];
    [query whereKey:@"State" equalTo:@"Pending"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            if (objects.count != 0)
            {
                [self ShowRedDotForCreditsIcon];
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
-(void)CheckTermsAccepted
{
//    if (([PFUser currentUser][@"TermsAccepted"] == FALSE) || ([PFUser currentUser][@"TermsAccepted"] == nil))
//    {
//        //Show Terms Popover
//        if (!backgroundDarkView)
//        {
//            backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
//            backgroundDarkView.backgroundColor = [UIColor blackColor];
//            backgroundDarkView.alpha = 0;
//            [self.view addSubview:backgroundDarkView];
//        }
//        
//            UIView *termsPopover = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height-130)];
//            termsPopover.backgroundColor = [UIColor whiteColor];
//            termsPopover.layer.cornerRadius = 10;
//            termsPopover.clipsToBounds = YES;
//        
//        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
//        logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
//        [termsPopover addSubview:logo];
//        
//        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 72, termsPopover.frame.size.width-20, 43)];
//        headerLabel.text = @"Rules and Constitution";
//        headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:26];
//        [termsPopover addSubview:headerLabel];
//        
//        UILabel *seconndaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 115, termsPopover.frame.size.width-20, 100)];
//        seconndaryLabel.text = [NSString stringWithFormat:@"Please read and accept the current Rules and Constitution of the BSR. This is required to continue using the app."];
//        seconndaryLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
//        seconndaryLabel.numberOfLines = 0;
//        seconndaryLabel.alpha = 0.5;
//        [termsPopover addSubview:seconndaryLabel];
//        
//            
//            [self.view addSubview:termsPopover];
//    
//        
//        [UIView animateWithDuration:0.4f animations:^{
//            
//            [backgroundDarkView setAlpha:0.4f];
//            termsPopover.frame = CGRectMake(10, 40, self.view.frame.size.width-20, self.view.frame.size.height-130);
//            
//        } completion:^(BOOL finished) {
//            
//            NSLog(@"Show Terms Transition Complete");
//        }];
//    }
    
    
}

//#pragma mark Check Onboarding Complete
//-(void)CheckIfOnboardingComplete
//{
//    
//    PFUser *currentUser = [PFUser currentUser];
//  
//    if (currentUser[@"Onboarding_About"] == NO)
//    {
//        //About Not Complete
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Error Logging In"
//                                     message:@"It looks like you haven't finished the about you part of the setup process. Do you want to finish the setup now?"
//                                     preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok, Finish now"
//                                                           style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             [self performSegueWithIdentifier:@"finish-about-segue" sender:self];
//                                                         }];
//        
//        UIAlertAction *cancel = [UIAlertAction
//                                 actionWithTitle:@"I'll do this later"
//                                 style:UIAlertActionStyleCancel
//                                 handler:^(UIAlertAction * action) {
//                                     
//                                 }];
//        
//        [alert addAction:okButton];
//        [alert addAction:cancel];
//        [self presentViewController: alert animated:YES completion:nil];
//        return;
//    }
//    else if (currentUser[@"Onboarding_Skills-Gallery"] == NO)
//    {
//        //Skills-Gallery Not Complete
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Error Logging In"
//                                     message:@"It looks like you haven't finished the skills and gallery part of the setup process. Do you want to finish the setup now?"
//                                     preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok, Finish now"
//                                                           style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             
//                                                         }];
//        
//        UIAlertAction *cancel = [UIAlertAction
//                                 actionWithTitle:@"I'll do this later"
//                                 style:UIAlertActionStyleCancel
//                                 handler:^(UIAlertAction * action) {
//                                     
//                                 }];
//        
//        [alert addAction:okButton];
//        [alert addAction:cancel];
//        [self presentViewController: alert animated:YES completion:nil];
//        return;
//    }
//    else if (currentUser[@"Onboarding_Credits"] == NO)
//    {
//        //Credits Not Complete
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Setup Not Complete"
//                                     message:@"It looks like you haven't finished the credits part of the setup process. Do you want to finish the setup now?"
//                                     preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok, Finish now"
//                                                           style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             
//                                                         }];
//        
//        UIAlertAction *cancel = [UIAlertAction
//                                 actionWithTitle:@"I'll do this later"
//                                 style:UIAlertActionStyleCancel
//                                 handler:^(UIAlertAction * action) {
//                                     
//                                 }];
//        
//        [alert addAction:okButton];
//        [alert addAction:cancel];
//        [self presentViewController: alert animated:YES completion:nil];
//        return;
//    }
//
//    
//}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show-member-segue"])
    {
        MembersCollectionViewController *vc = segue.destinationViewController;
        vc.type = selectedIndex;
    }
}

@end
