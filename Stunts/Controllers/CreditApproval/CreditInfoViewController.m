//
//  CreditInfoViewController.m
//  Stunts
//
//  Created by Richard Allen on 29/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "CreditInfoViewController.h"
#import "ContractViewController.h"
#import "MBProgressHUD.h"

@interface CreditInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    IBOutlet UITableView *creditInfoTableView;
    __weak IBOutlet UIButton *contractImageButton;
    UIImage *selectedImage;
    MBProgressHUD *hud;
    PFObject *currentCredit;
    
    //Popover
    UIView *backgroundDarkView;
    UIView *popoverContainerView;
    
    UITextView *rejectionReason;
}

@end

@implementation CreditInfoViewController
@synthesize credits;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self PopulateCredit:[credits objectAtIndex:0]];


}


-(void)PopulateCredit:(PFObject *)cred
{
    [contractImageButton setImage:nil forState:UIControlStateNormal];
    if (cred)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Loading Credit";
        currentCredit = cred;
        UIImage *__block contractImage;
        
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            // Perform long running process
            PFFile *imgFile = cred[@"Contract"];
            NSData *d = [imgFile getData];
            contractImage = [UIImage imageWithData:d];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                if (contractImage != nil)
                {
                    [contractImageButton setImage:contractImage forState:UIControlStateNormal];
                }
                
            });
        });
        [creditInfoTableView reloadData];
        [hud hideAnimated:YES];
    }
    else
    {
        NSLog(@"Error loading Credit");
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"Member";
            PFUser *user = [currentCredit[@"User"] fetch];
            cell.detailTextLabel.text = user[@"Name"];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"Production";
            cell.detailTextLabel.text = currentCredit[@"Production"];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Job Title";
            cell.detailTextLabel.text = currentCredit[@"JobRole"];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"Studio / Producer";
            cell.detailTextLabel.text = currentCredit[@"Producer"];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"Director";
            cell.detailTextLabel.text = currentCredit[@"Director"];
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (IBAction)approveCredit:(id)sender
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Approving Credit";
    [credits removeObject:currentCredit];
    [parent.credits removeObject:currentCredit];
    currentCredit[@"State"] = @"Approved";
    [currentCredit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [hud hideAnimated:YES];
            if (credits.count == 0)
            {
                //Done all credits for User
                [self completedCredits];
            }
            else
            {
                //Still Credits Remaining
                [self PopulateCredit:[credits objectAtIndex:0]];
            }
            
            
        } else {
            // There was a problem, check error.description
            NSLog(@"Error Submitting Credits");
        }
    }];


    
}
- (IBAction)declineCredit:(id)sender
{
    [self ShowPopoverForReasonOfRejection];
    
}

-(IBAction)ShowContract:(id)sender
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Getting Contract....";
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        PFFile *imgFile = currentCredit[@"Contract"];
        NSData *d = [imgFile getData];
        selectedImage = [UIImage imageWithData:d];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [hud hideAnimated:YES];
         [self performSegueWithIdentifier:@"show-contract-segue" sender:self];
            
        });
    });
   
}

-(void)ShowPopoverForReasonOfRejection
{
    
    
    backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0;
    [self.view addSubview:backgroundDarkView];
    
    popoverContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 335, 470)];
    popoverContainerView.backgroundColor = [UIColor whiteColor];
    popoverContainerView.layer.cornerRadius = 10;
    popoverContainerView.clipsToBounds = YES;
    [self CreateRejectView];
    [self.view addSubview:popoverContainerView];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        popoverContainerView.frame = CGRectMake(20, 100, 335, 470);
        
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
    }];
    
    
}

-(void)CreateRejectView
{
    NSLog(@"Credit to Reject: %@", currentCredit);
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(144, 13, 44, 44)];
    logo.image = [UIImage imageNamed:@"BSR-Logo50-Alpha"];
    [popoverContainerView addSubview:logo];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 72, 226, 43)];
    headerLabel.text = @"Reject a Credit";
    headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:30];
    [popoverContainerView addSubview:headerLabel];
    
    UILabel *seconndaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 115, 270, 50)];
    seconndaryLabel.text = @"Please give the member the reason for the rejection.";
    seconndaryLabel.font = [UIFont fontWithName:@"SFProText-Light" size:16];
    seconndaryLabel.numberOfLines = 0;
    seconndaryLabel.alpha = 0.5;
    [popoverContainerView addSubview:seconndaryLabel];
    
    /******* Maximum Label ********/
    UILabel *maxWordsLabel = [[UILabel alloc]initWithFrame:CGRectMake(207, 169, 110, 16)];
    maxWordsLabel.text = @"Max 200 Words";
    maxWordsLabel.alpha = 0.4;
    maxWordsLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    maxWordsLabel.numberOfLines = 0;
    [popoverContainerView addSubview:maxWordsLabel];
    
    /******* Rejection Reason ********/
    rejectionReason = [[UITextView alloc] initWithFrame:CGRectMake(20, 185, 299, 215)];
    rejectionReason.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    rejectionReason.backgroundColor = [UIColor groupTableViewBackgroundColor];
    rejectionReason.layer.cornerRadius = 5;
    rejectionReason.clipsToBounds = YES;
    rejectionReason.delegate = self;
    [popoverContainerView addSubview:rejectionReason];
    
    /******* Next Button ********/
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(47, 410, 242, 51)];
    [nextButton setImage:[UIImage imageNamed:@"save-button"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(rejectionNext:) forControlEvents:UIControlEventTouchUpInside];
    [popoverContainerView addSubview:nextButton];
    
}
-(void)rejectCredit
{
    NSLog(@"%@", currentCredit);
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Rejecting Credit";
    //long currentCreditIndex = [credits indexOfObject:currentCredit];
    currentCredit[@"State"] = @"Rejected";
    currentCredit[@"Reviewer"] = [PFUser currentUser];
    [parent.credits removeObject:currentCredit];
    [credits removeObject:currentCredit];
    currentCredit[@"RejectReason"] = rejectionReason.text;
    [currentCredit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [hud hideAnimated:YES];
            if (credits.count == 0)
            {
                //Done all credits for User
                [UIView animateWithDuration:0.4f animations:^{
                    
                    [backgroundDarkView setAlpha:0.0f];
                    popoverContainerView.frame = CGRectMake(20, self.view.frame.size.height, 335, 470);
                    rejectionReason.text = @"";
                    
                }
                                 completion:^(BOOL finished)
                 {
                     NSLog(@"Transition Complete");
                     backgroundDarkView = nil;
                     popoverContainerView = nil;
                 }];
                [self completedCredits];
            }
            else
            {
                //Still Credits Remaining
            
                [self PopulateCredit:[credits objectAtIndex:0]];
                [UIView animateWithDuration:0.4f animations:^{
                    
                    [backgroundDarkView setAlpha:0.0f];
                    popoverContainerView.frame = CGRectMake(20, self.view.frame.size.height, 335, 470);
                    rejectionReason.text = @"";
                    
                }
                                 completion:^(BOOL finished)
                 {
                     NSLog(@"Transition Complete");
                     backgroundDarkView = nil;
                     popoverContainerView = nil;
                 }];
            }
            [self AddRejectedCreditForNotification];
        } else {
            // There was a problem, check error.description
        }
    }];
}

-(void)AddRejectedCreditForNotification
{
    NSMutableArray *rejectedCredits;
    PFUser *user = currentCredit[@"User"];
    if (user[@"RejectedCredits"])
    {
        rejectedCredits = [[NSMutableArray alloc] initWithArray:user[@"RejectedCredits"]];
        [rejectedCredits addObject:currentCredit];
    }
    else
    {
        rejectedCredits = [[NSMutableArray alloc] init];
        [rejectedCredits addObject:currentCredit];
    }
    user[@"RejectedCredits"] = rejectedCredits;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Rejected Credits Saved");
        } else {
            // There was a problem, check error.description
            NSLog(@"Error: %@", error.description);
        }
    }];
    
}
-(void)rejectionNext:(id)sender
{
    if ([rejectionReason.text isEqualToString:@""])
    {
        //No Reason Given
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Reason Given"
                                                                       message:@"You haven't given a reason for your rejection. Please add one and click decline again. This will be passed on to the member."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {

                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self rejectCredit];
    
}
#pragma mark - TextField Delegate
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}
#pragma mark - Navigation

- (IBAction)nextCredit:(id)sender
{
    long currentCreditIndex = [credits indexOfObject:currentCredit];
    if (currentCreditIndex != [credits count]-1)
    {
        [self PopulateCredit:[credits objectAtIndex:currentCreditIndex+1]];
    }
    else
    {
        [self PopulateCredit:[credits objectAtIndex:0]];
    }
}
- (void)completedCredits
{
   //All Credits Approved or Rejected.
//    [parent.creditTableView reloadData];

    switch (parent.segmentControl.selectedSegmentIndex) {
        case 0:
            [parent GetUsersWithCreditsPending];
            break;
        case 1:
            [parent GetUsersWithCreditsApproved];
            break;
        case 2:
            [parent GetUsersWithCreditsRejected];
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"show-contract-segue"])
    {
        ContractViewController *vc = segue.destinationViewController;
        vc.contractImage = selectedImage;
    }
}


@end
