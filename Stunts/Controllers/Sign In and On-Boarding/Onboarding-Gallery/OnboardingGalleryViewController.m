//
//  OnboardingGalleryViewController.m
//  Stunts
//
//  Created by Richard Allen on 04/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "OnboardingGalleryViewController.h"
#import "MBProgressHUD.h"
#import "GKImagePicker.h"
#import "AboutMeViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "AppImports.h"

@interface OnboardingGalleryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UICollectionView *gallareyCollectionView;
    NSMutableArray *images;
    UIView *noImageView;
    __weak IBOutlet UIButton *addImageButton;
    __weak IBOutlet UIButton *editButton;
    BOOL editMode;
    __weak IBOutlet UILabel *infoLabel;
    __weak IBOutlet UILabel *yourImagesLabel;
    PFObject *profile;
    
}
@property (nonatomic, strong) GKImagePicker *imagePicker;
@end

@implementation OnboardingGalleryViewController
@synthesize member;

- (void)viewDidLoad {
    [super viewDidLoad];
    images = [[NSMutableArray alloc]init];
    editButton.hidden = YES;
    editMode = NO;
    [self displayAndHideCollectionImageView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return images.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageForCell = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    imageForCell.image = [images objectAtIndex:indexPath.row];
    [cell addSubview:imageForCell];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (editMode == YES)
    {
        //DeleteImage
        [images removeObjectAtIndex:indexPath.row];
        [gallareyCollectionView reloadData];
        [self editModePressed:self];
        if (images.count == 0) {
            [self displayAndHideCollectionImageView];
        }
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (editMode == YES)
        return YES;
    return NO;
}
-(void)displayAndHideCollectionImageView
{
    if (images.count == 0)
    {
        
        noImageView = [[UIView alloc]initWithFrame:CGRectMake(0, gallareyCollectionView.frame.size.height-5, gallareyCollectionView.frame.size.width, gallareyCollectionView.frame.size.height-5)];
        noImageView.backgroundColor = [UIColor whiteColor];
        
        UILabel *labelLine1 = [[UILabel alloc]initWithFrame:CGRectMake(0, noImageView.frame.size.height/2-20, noImageView.frame.size.width, 20)];
        labelLine1.text = @"You have not currently";
        labelLine1.font = [UIFont fontWithName:@"SFProText-Light" size:18];
        labelLine1.textAlignment = NSTextAlignmentCenter;
        
        UILabel *labelLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0, noImageView.frame.size.height/2, noImageView.frame.size.width, 20)];
        labelLine2.text = @"submitted any images yet.";
        labelLine2.font = [UIFont fontWithName:@"SFProText-Light" size:18];
        labelLine2.textAlignment = NSTextAlignmentCenter;
        
        [noImageView addSubview:labelLine1];
        [noImageView addSubview:labelLine2];
        
        [self.view addSubview:noImageView];
    }
    else
    {
        [noImageView removeFromSuperview];
        noImageView = nil;
    }
}

# pragma mark GKImagePicker Delegate Methods
- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image
{
    if (images.count == 0)
    {
        editButton.hidden = NO;
    }
    if (images.count == 2)
    {
        addImageButton.hidden = YES;
        addImageButton.userInteractionEnabled = YES;
    }
    [images addObject:image];
    [gallareyCollectionView reloadData];
    [self displayAndHideCollectionImageView];
    
    
    [self hideImagePicker];
}

- (void)hideImagePicker
{
    
    [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)AddImage
{
    if (images.count < 3)
    {
        self.imagePicker = [[GKImagePicker alloc] init];
        self.imagePicker.cropSize = CGSizeMake(280, 280);
        self.imagePicker.delegate = self;
        
        [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
        
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Too Many Images"
                                     message:@"At this time the maximum number of images is 3. If you wish to add another please delete one from the current collection."
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction
                                  actionWithTitle:@"Ok"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action) {
                                      
                                  }];
        
        [alert addAction:cancel];
        [self presentViewController: alert animated:YES completion:nil];
    }
}

- (IBAction)editModePressed:(id)sender
{
    if (editMode ==YES)
    {
        editMode = NO;
        infoLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Please Choose 3 Photos to ",@"present on your profile page."];
        editButton.hidden = YES;
    }
    else
    {
        editMode = YES;
        infoLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Press the Image you ",@"wish to delete."];
    }
}

#pragma mark - Navigation
-(IBAction)Next:(id)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"uid" equalTo:member];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved Profile");
            // Do something with the found objects
            if (objects.count == 0)
            {
                SCErrorController *sharedManager = [SCErrorController sharedManager];
                [sharedManager presentAlertWithOnboardingErrorCode:101 InPresenter:self withError:nil];
                return ;
            }
            profile = objects[0];
            profile[@"uid"] = member;
            
            int counter = 1;
            NSMutableArray * parseFileArray = [[NSMutableArray alloc]init];
            for (UIImage *img in images)
            {
                NSData *imageData = UIImagePNGRepresentation(img);
                PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"image - %d", counter] data:imageData];
                
                float imageSize = imageData.length;
                //Transform into Megabytes
                imageSize = imageSize/(1024*1024);
                NSLog(@"%f", imageSize);
                
                
                counter ++;
                [parseFileArray addObject:imageFile];
            }
            profile[@"Images"] = parseFileArray;
            
            //Show Saving HUD
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Saving";
            
            [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Profile Saved Successfully");
                    [PFUser currentUser][@"Onboarding_Skills"] = [NSNumber numberWithBool:YES];
                    [[PFUser currentUser] saveInBackground];
                    
                } else {
                    // There was a problem, check error.description
                    SCErrorController *sharedManager = [SCErrorController sharedManager];
                    [sharedManager presentAlertWithOnboardingErrorCode:102 InPresenter:self withError:error];
                    
                    
                }
            }];
            [hud hideAnimated:YES];
            [self performSegueWithIdentifier:@"gallery-to-credits-segue" sender:self];
            
            
        } else {
            // Log details of the failure
            NSLog(@"%@", error.description);
            SCErrorController *sharedManager = [SCErrorController sharedManager];
            [sharedManager presentAlertWithOnboardingErrorCode:101 InPresenter:self withError:error];
        }
    }];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gallery-to-credits-segue"])
    {
        AboutMeViewController *vc = segue.destinationViewController;
        vc.profile = profile;
    }
    
}


@end

