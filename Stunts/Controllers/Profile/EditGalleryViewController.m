//
//  EditGalleryViewController.m
//  Stunts
//
//  Created by Richard Allen on 25/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "EditGalleryViewController.h"
#import "MBProgressHUD.h"
#import "GKImagePicker.h"


@interface EditGalleryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UICollectionView *gallareyCollectionView;
    __block NSMutableArray *images;
    UIView *noImageView;
    __weak IBOutlet UIButton *addImageButton;
    __weak IBOutlet UIButton *editButton;
    BOOL editMode;
    __weak IBOutlet UILabel *infoLabel;
}
@property (nonatomic, strong) GKImagePicker *imagePicker;
@end

@implementation EditGalleryViewController
@synthesize profile;


- (void)viewDidLoad {
    [super viewDidLoad];
    images = [[NSMutableArray alloc]init];
    editButton.hidden = YES;
    editMode = NO;
    [self displayAndHideCollectionImageView];
    [self LoadImages];
}

-(void)LoadImages
{
    NSLog(@"%@", profile[@"Images"]);
    
    //Show Loading HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading Gallery..";
    
    //Member Image
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        
        NSLog(@"%@", profile[@"Images"]);
        
        for (PFFile *file in profile[@"Images"])
        {
            //Image
            NSData *d = [file getData];
            
            if ([UIImage imageWithData:d] != nil)
            {
                [images addObject:[UIImage imageWithData:d]];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [hud hideAnimated:YES];
            [self displayAndHideCollectionImageView];
            [gallareyCollectionView reloadData];
            if (images.count != 0) {
                editButton.hidden = NO;
            }
        });
    });
    
    
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
        if(!noImageView){
            noImageView = [[UIView alloc]initWithFrame:gallareyCollectionView.frame];
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
        }else{
            [noImageView setHidden:NO];
        }
        
    }
    else
    {
        NSLog(@"Remove noImageView");
        [noImageView setHidden:YES];
    }
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
                                     message:@"At this time the manimum number of images is 3. If you wish to add another please delete one from the current collection."
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image Selected");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (images.count == 0)
    {
        editButton.hidden = NO;
    }
    if (images.count == 2)
    {
        //addImageButton.hidden = YES;
        addImageButton.userInteractionEnabled = YES;
    }
    [images addObject:chosenImage];
    [gallareyCollectionView reloadData];
    [self displayAndHideCollectionImageView];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Image Selection Cancelled");
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)editModePressed:(id)sender
{
    if (editMode ==YES)
    {
        editMode = NO;
        infoLabel.text = [NSString stringWithFormat:@"%@\r%@", @"Please Chose 3 Photos to ",@"present on your profile page."];
        //editButton.hidden = YES;
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
    
    int counter = 1;
    NSMutableArray * parseFileArray = [[NSMutableArray alloc]init];
    for (UIImage *img in images)
    {
        NSData *imageData = UIImagePNGRepresentation(img);
        PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"image - %d", counter] data:imageData];
        counter ++;
        [parseFileArray addObject:imageFile];
    }
    profile[@"Images"] = parseFileArray;
    
    //Show Saving HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving Images";
    
    
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Profile Saved Successfully");
            [hud hideAnimated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            // There was a problem, check error.description
            NSLog(@"Error: %ld - Description:%@", (long)error.code, error.description);
            [hud hideAnimated:YES];
        }
    }];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
}

@end

