//
//  ProfileTableViewController.m
//  Stunts
//
//  Created by Richard Allen on 07/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//



#import "macros.h"
#import "AppImports.h"
#import "ProfileTableViewController.h"
#import "ProfileHeaderCellTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "GalleryTableViewCell.h"
#import "ImageViewController.h"
#import "AddToListViewController.h"
#import "NewListViewController.h"
#import "Profile.h"
#import "Credits.h"
#import "Members.h"
#import "List.h"

@interface ProfileTableViewController ()<MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate>
{
    BOOL tableLoaded;
    __weak IBOutlet UIView *profileLevelView;
    __weak IBOutlet UIButton *cellphoneButton;
    __weak IBOutlet UIButton *emailButton;
    
    int selectedDataForTableView;
    
    /* Button Control Section */
    NSArray *infoButtons;
    UIButton *aboutMeButton;
    UIButton *galleryButton;
    UIButton *skillsButton;
    UIButton *creditsButton;
    
    NSString *selectedInfoTitle;
    
    __block UIImage *profileImage;
    
    //DATA
    NSMutableArray *aboutMeLabels;
    __block NSMutableArray *aboutMeData;
    __block NSMutableArray *galleryImages;
    __block NSMutableArray *skills;
    __block NSMutableArray *credits;
    
    __block PFObject *profile;
    Profile * realmProfile;
    
    NSMutableArray *skillsLabels;
    NSArray *skillsData;
    NSArray *creditsData;
    
    UIImage *selectedImage;
    
    int selectedButton;
    
    AddToListViewController *popoverViewController;
    NewListViewController *newPopoverController;
    NSArray *lists;
    
    UnitsOfMeasure *measureUnits;
    
    //PDF Vars
    NSMutableArray *members;
    
    //Credit Arrays
    int stuntSectionCount;
    NSMutableArray *cred_coordinatorArray;
    NSMutableArray *cred_asstCoordinatorArray;
    NSMutableArray *cred_selfCoordinated;
    NSMutableArray *cred_performer;
    NSMutableArray *cred_rigger;

    
}
@end

@implementation ProfileTableViewController
//@synthesize selectedProfile;
@synthesize selectedMember;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stuntSectionCount = 0;
    tableLoaded = NO;
    selectedButton = 0;
    measureUnits = Imperial;
    
    [self setupProfileView];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    selectedDataForTableView = 0;
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor whiteColor];
    }
    
    [self GetDataForSelection:0];
    [self GetLists];
    
//    RLMResults<Profile *> * results = [Profile objectsWhere:@"uid = %@",selectedMember];
//    NSLog(@"RESLUT: %@", results);
    
    NSLog(@"Image: %@", profileImage);
    NSLog(@"Member: %@", selectedMember);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    aboutMeButton.selected = UIControlStateSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupProfileView
{
    /* Cellphone number Button */
    
    
    
    /* Cellphone number Button */
    //    [emailButton setTitle:selectedProfile.email forState:UIControlStateNormal];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
        {
            switch (selectedDataForTableView)
            {
                case 0:
                    NSLog(@"%lu", (unsigned long)aboutMeLabels.count);
                    return [aboutMeLabels count];
                    break;
                case 1:
                    return 1;
                    break;
                case 2:
                    return skills.count;
                    break;
                case 3:
                    if (credits)
                        return credits.count;
                    return 1;
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
     return selectedInfoTitle;
    }
//    if (selectedDataForTableView == 3)
//    {
//
//    }
//
        return @"";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    ProfileHeaderCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
                    //                    [cell setUserLevel:[selectedMember[@"MemberType"]intValue]];
                    [cell setUserLevel:[selectedMember.MemberType intValue]];
                    [cell.switchUnitsOfMeasureButton addTarget:self action:@selector(switchUnitsOfMeasure:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    //Member Image
                    if (profileImage == nil)
                    {
                        if(selectedMember.profileImage != nil){
                            cell.userImage.image = [UIImage imageNamed:selectedMember.profileImage];
                        }else{
                            cell.userImage.image = [UIImage imageNamed:@"placeholder"];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                    }
                    else
                    {
                        cell.userImage.image = profileImage;
                    }
                    
                    //Name
                    cell.memberName.text = [NSString stringWithFormat:@"%@ %@", selectedMember.FirstName, selectedMember.LastName];
                    
                    [cell.cellphoneButton setTitle:selectedMember.phoneNumber forState:UIControlStateNormal];
                    [cell.emailButton setTitle:selectedMember.Email forState:UIControlStateNormal];
                    
                    [cell.cellphoneButton addTarget:self action:@selector(CallCellphone:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.emailButton addTarget:self action:@selector(EmailMember:) forControlEvents:UIControlEventTouchUpInside];
                    
                    return cell;
                }
                    break;
                case 1:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
                    
                    aboutMeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/4, cell.frame.size.height)];
                    //aboutMeButton.backgroundColor = [UIColor blueColor];
                    [aboutMeButton setTitle:@"About Me" forState:UIControlStateNormal];
                    aboutMeButton.titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
                    [aboutMeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [aboutMeButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                    [aboutMeButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    aboutMeButton.tag = 0;
                    [cell addSubview:aboutMeButton];
                    
                    if (tableLoaded == NO)
                    {
                        tableLoaded = YES;
                        aboutMeButton.selected = UIControlStateSelected;
                    }
                    
                    galleryButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/4, cell.frame.size.height)];
                    //galleryButton.backgroundColor = [UIColor redColor];
                    [galleryButton setTitle:@"Gallery" forState:UIControlStateNormal];
                    galleryButton.titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
                    [galleryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [galleryButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                    [galleryButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    galleryButton.tag = 1;
                    [cell addSubview:galleryButton];
                    
                    skillsButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/4, cell.frame.size.height)];
                    //skillsButton.backgroundColor = [UIColor greenColor];
                    [skillsButton setTitle:@"Skills" forState:UIControlStateNormal];
                    skillsButton.titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
                    [skillsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [skillsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                    [skillsButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    skillsButton.tag = 2;
                    [cell addSubview:skillsButton];
                    
                    creditsButton = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/4)*3, 0, self.view.frame.size.width/4, cell.frame.size.height)];
                    //creditsButton.backgroundColor = [UIColor purpleColor];
                    [creditsButton setTitle:@"Credits" forState:UIControlStateNormal];
                    creditsButton.titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
                    [creditsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [creditsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                    [creditsButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    creditsButton.tag = 3;
                    [cell addSubview:creditsButton];
                    
                    infoButtons = [[NSArray alloc]initWithObjects:aboutMeButton,galleryButton,skillsButton,creditsButton, nil];
                    
                    switch (selectedButton)
                    {
                        case 0:
                            aboutMeButton.selected = YES;
                            break;
                        case 1:
                            galleryButton.selected = YES;
                            break;
                        case 2:
                            skillsButton.selected = YES;
                            break;
                        case 3:
                            creditsButton.selected = YES;
                            break;
                            
                        default:
                            break;
                    }
                    
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
            //Section 1
        {
            UITableViewCell *cell;
            UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
            
            switch (selectedDataForTableView) {
                case 0:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
                    //ABOUT ME
                    NSLog(@"About ME: %lu", (unsigned long)[aboutMeData count]);
                    
                    cell.textLabel.text = [aboutMeLabels objectAtIndex:indexPath.row];
                    
                    if(!aboutMeData.count){
                        cell.detailTextLabel.text = @"";
                        return cell;
                    }
                    
                    if ([[aboutMeData objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] && [[aboutMeData objectAtIndex:indexPath.row] isEqualToString:@""])
                    {
                        cell.detailTextLabel.text = @"";
                        return cell;
                    }
                    switch (indexPath.row) {
                        case 0:
                        {
                            //Height
                            NSLog(@"%f", [[aboutMeData objectAtIndex:indexPath.row] floatValue]);
                            NSMutableDictionary *dict;
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] floatValue]){
                                
                                if (measureUnits == Imperial)
                                {
                                    dict = [self inchesToFeetAndInches:[[aboutMeData objectAtIndex:indexPath.row] floatValue]];
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ft %@ in", [dict objectForKey:@"Feet"], [dict objectForKey:@"Inches"]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    dict = [self inchesToMetersandCm:[[aboutMeData objectAtIndex:indexPath.row] floatValue]];
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ m %@ cm", [dict objectForKey:@"Metres"], [dict objectForKey:@"Centimeteres"]];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            
                            
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                        }
                            break;
                        case 1:
                        {
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                
                                //Waist
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                        }
                            break;
                        case 2:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                
                                //Chest
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    int i = cm;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            
                        }
                            break;
                      
                        case 3:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Weight
                                if (measureUnits == Imperial)
                                {
                                    //Ints
                                    int totalPounds = [[aboutMeData objectAtIndex:indexPath.row] intValue];
                                    NSLog(@"totalPounds: %d",totalPounds);
                                    int stone = totalPounds / 14;
                                    int pounds = totalPounds % 14;
                                    NSLog(@"STONE: %d", stone);
                                    NSLog(@"POUNDS: %d", pounds);
                                    
                                    
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%dst %dlb", stone, pounds];
                                }
                                else if (measureUnits == Metric)
                                {
                                    NSMutableDictionary *dict = [self poundsToKilgramsAndGrams:[[aboutMeData objectAtIndex:indexPath.row] floatValue]];
                                    
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@Kg %@g", [dict objectForKey:@"Kilograms"], [dict objectForKey:@"Grams"]];
                                    
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                        }
                            break;
                    
                        case 4:
                        {
                            //Eye Color
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            if ([aboutMeData objectAtIndex:indexPath.row] != NULL) {
                                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [aboutMeData objectAtIndex:indexPath.row]];
                            }
                        }
                        case 5:
                        {
                            //Hair Color
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [aboutMeData objectAtIndex:indexPath.row]];
                        }
                            break;
                        case 6:
                        {
                            //Facial Hair
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [aboutMeData objectAtIndex:indexPath.row]];
                        }
                            break;
                        case 7:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Collar
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    int i = cm;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                        }
                            break;
                        case 8:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Inside Leg
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    int i = cm;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            
                            
                        }
                            break;
                        case 9:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Inside Arm
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    int i = cm;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                            
                        }
                            break;
                        case 10:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Hips
                                if (measureUnits == Imperial)
                                {
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [aboutMeData objectAtIndex:indexPath.row]];
                                }
                                else if (measureUnits == Metric)
                                {
                                    double inches = [[aboutMeData objectAtIndex:indexPath.row] doubleValue];
                                    double cm = inches * 2.54;
                                    int i = cm;
                                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fcm", cm];
                                }
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            cell.detailTextLabel.font = labelFont;
                            cell.detailTextLabel.textColor = [UIColor blackColor];
                            cell.detailTextLabel.alpha = 0.8;
                        }
                            break;
                        case 11:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Hat
                                cell.detailTextLabel.font = labelFont;
                                cell.detailTextLabel.textColor = [UIColor blackColor];
                                cell.detailTextLabel.alpha = 0.8;
                                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [aboutMeData objectAtIndex:indexPath.row]];
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                            
                        }
                            break;
                        case 12:
                        {
                            
                            if([[aboutMeData objectAtIndex:indexPath.row] intValue]){
                                //Shoe Size
                                cell.detailTextLabel.font = labelFont;
                                cell.detailTextLabel.textColor = [UIColor blackColor];
                                cell.detailTextLabel.alpha = 0.8;
                                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [aboutMeData objectAtIndex:indexPath.row]];
                            }
                            else{
                                cell.detailTextLabel.text = @"";
                            }
                        }
                            break;
                      
                        default:
                            break;
                            
                    }
                    
                }
                    break;
                case 1:
                {
                    //GALLERY
                    GalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryCell" forIndexPath:indexPath];
                    
                    [cell.img1 addTarget:self action:@selector(imageSelected:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.img2 addTarget:self action:@selector(imageSelected:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.img3 addTarget:self action:@selector(imageSelected:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.img1.tag = 0;
                    cell.img2.tag = 1;
                    cell.img3.tag = 2;
                    
                    NSLog(@"%lu", (unsigned long)galleryImages.count);
                    switch (galleryImages.count) {
                        case 0:
                        {
                            cell.noImageLabel.hidden = NO;
                            UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
                            cell.noImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
                            cell.noImageLabel.text = @"No Images in the Gallery.";
                            cell.noImageLabel.textAlignment = NSTextAlignmentCenter;
                            cell.noImageLabel.font = labelFont;
                            [cell addSubview:cell.noImageLabel];
                            
                            cell.img1.hidden = YES;
                            cell.img2.hidden = YES;
                            cell.img3.hidden = YES;
                        }
                            break;
                        case 1:
                        {
                            cell.noImageLabel.hidden = YES;
                            [cell.img1 setBackgroundImage:[galleryImages objectAtIndex:0] forState:UIControlStateNormal];
                            cell.img2.hidden = YES;
                            cell.img3.hidden = YES;
                        }
                            break;
                        case 2:
                        {
                            cell.noImageLabel.hidden = YES;
                            [cell.img1 setBackgroundImage:[galleryImages objectAtIndex:0] forState:UIControlStateNormal];
                            [cell.img2 setBackgroundImage:[galleryImages objectAtIndex:1] forState:UIControlStateNormal];
                            cell.img2.hidden = NO;
                            cell.img3.hidden = YES;
                        }
                            break;
                        default:
                        {
                            cell.noImageLabel.hidden = YES;
                            [cell.img1 setBackgroundImage:[galleryImages objectAtIndex:0] forState:UIControlStateNormal];
                            [cell.img2 setBackgroundImage:[galleryImages objectAtIndex:1] forState:UIControlStateNormal];
                            [cell.img3 setBackgroundImage:[galleryImages objectAtIndex:2] forState:UIControlStateNormal];
                            cell.img2.hidden = NO;
                            cell.img3.hidden = NO;
                        }
                            break;
                            
                    }
                    
                    NSLog(@"%lu", (unsigned long)galleryImages.count);
                    return cell;
                    
                    
                }
                    break;
                case 2:
                {
                    //SKILLS
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
                    cell.textLabel.text = [skills objectAtIndex:indexPath.row];
                    cell.textLabel.font = labelFont;
                    cell.detailTextLabel.text = @"";
                    NSLog(@"%@", [skills objectAtIndex:indexPath.row]);
                    
                }
                    break;
                case 3:
                {
                    //CREDITS
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
                    if (!credits)
                    {
                        cell.textLabel.text = @"No Confirmed Credits";
                        cell.detailTextLabel.text = @"";
                    }
                    else
                    {
                        Credits *credit = [credits objectAtIndex:indexPath.row];
                        cell.textLabel.text = credit.Production;
                        cell.detailTextLabel.text = @"";
                    }
                    
                    cell.textLabel.font = labelFont;
                    
                    NSLog(@"%@", [credits objectAtIndex:indexPath.row]);
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    
    UITableViewCell *cell;
    
    return cell;
}
-(void)imageSelected:(UIButton *)sender
{
    NSLog(@"Image Selected");
    NSLog(@"%ld", (long)sender.tag);
    selectedImage = [galleryImages objectAtIndex:sender.tag];
    NSLog(@"%@" , sender.imageView.image);
    [self performSegueWithIdentifier:@"show-image-segue" sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            //Section 0
            switch (indexPath.row) {
                case 0:
                    return 555;
                    break;
                case 1:
                    return 51;
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
            switch (selectedDataForTableView) {
                case 0:
                    return 44;
                    break;
                case 1:
                    return 200;
                    break;
                    
                default:
                    return 44;
                    break;
            }
            
            break;
        default:
            break;
    }
    
    return 0;
    
    
}


-(void)CallCellphone:(id)sender
{
    NSString *cellCallString = [NSString stringWithFormat:@"tel://%@", selectedMember.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cellCallString]];
}

-(void)EmailMember:(id)sender
{
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    mail.mailComposeDelegate = self;
    [mail setSubject:@"Email From BSR App"];
    [mail setMessageBody:@"Hi " isHTML:NO];
    [mail setToRecipients:@[selectedMember.Email]];
    
    [self presentViewController:mail animated:YES completion:NULL];
}
-(void)infoButtonPressed:(UIButton *)sender
{
    sender.selected = UIControlStateSelected;
    selectedDataForTableView = sender.tag;
    for (UIButton *btn in infoButtons)
    {
        if (btn != sender) {
            btn.selected = UIControlStateNormal;
        }
    }
    selectedButton = sender.tag;
    
    switch (sender.tag) {
        case 0:
            /* About Me */
            [self GetDataForSelection:0];
            break;
        case 1:
            /* Gallery */
            [self GetDataForSelection:1];
            break;
        case 2:
            /* Skills */
            [self GetDataForSelection:2];
            break;
        case 3:
            /* Credits */
            [self GetDataForSelection:3];
            break;
            
        default:
            break;
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)switchUnitsOfMeasure:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Switch to Metric"])
    {
        [sender setTitle:@"Switch to Imperial" forState:UIControlStateNormal];
        measureUnits = Metric;
        NSLog(@"%d", measureUnits);
        [self.tableView reloadData];
    }
    else
    {
        [sender setTitle:@"Switch to Metric" forState:UIControlStateNormal];
        measureUnits = Imperial;
        NSLog(@"%d", measureUnits);
        [self.tableView reloadData];
    }
}
-(NSArray *)GetDataForSelection:(int)selection
{
    
    NSArray *returnArray;
    switch (selection)
    {
        case 0:
        {
            if (!aboutMeData)
            {
                aboutMeLabels = [[NSMutableArray alloc]initWithObjects:@"Height", @"Waist",@"Chest",@"Weight",@"Eye Colour", @"Hair Colour", @"Facial Hair",@"Collar", @"Inside Leg", @"Inside Arm",@"Hips",@"Hat", @"Shoe Size UK", nil];
                realmProfile = [Profile objectsWhere:@"uid = %@",selectedMember.objectId].firstObject;
                aboutMeData = [[NSMutableArray alloc] init];
                if(realmProfile != NULL){
                    if (realmProfile.Height != NULL && realmProfile.Height > 0)
                    {
                        [aboutMeData addObject: realmProfile.Height];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.Waist != NULL && realmProfile.Waist > 0)
                    {
                        [aboutMeData addObject: realmProfile.Waist];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.Chest != NULL && realmProfile.Chest > 0)
                    {
                        [aboutMeData addObject: realmProfile.Chest];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    
                    if (realmProfile.Weight != NULL && realmProfile.Weight > 0)
                    {
                        [aboutMeData addObject: realmProfile.Weight];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.EyeColour != NULL && realmProfile.EyeColour.length > 0)
                    {
                        [aboutMeData addObject: realmProfile.EyeColour];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.HairColour != NULL && realmProfile.HairColour.length > 0)
                    {
                        [aboutMeData addObject: realmProfile.HairColour];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.FacialHair != NULL && realmProfile.FacialHair.length > 0)
                    {
                        [aboutMeData addObject: realmProfile.FacialHair];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    
               
                    if (realmProfile.Collar != NULL && realmProfile.Collar > 0)
                    {
                        [aboutMeData addObject: realmProfile.Collar];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.InsideLeg != NULL && realmProfile.InsideLeg > 0)
                    {
                        [aboutMeData addObject: realmProfile.InsideLeg];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.InsideArm != NULL && realmProfile.InsideArm > 0)
                    {
                        [aboutMeData addObject: realmProfile.InsideArm];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.Hips != NULL && realmProfile.Hips > 0)
                    {
                        [aboutMeData addObject: realmProfile.Hips];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    if (realmProfile.Hat != NULL && realmProfile.Hat > 0)
                    {
                        [aboutMeData addObject: realmProfile.Hat];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    
                    if (realmProfile.ShoeSizeUK != NULL && realmProfile.ShoeSizeUK > 0)
                    {
                        [aboutMeData addObject: realmProfile.ShoeSizeUK];
                    }
                    else
                    {
                        [aboutMeData addObject:@""];
                    }
                    
                    [self.tableView reloadData];
                }else{
                    NSLog(@"No Realm Profile found");
                    [self.tableView reloadData];
                }
            }
            else
            {
                [self.tableView reloadData];
            }
        }
            break;
        case 1:
        {
            NSLog(@"Loading Gallery");
            galleryImages = [[NSMutableArray alloc]init];
            
            NSLog(@"%@", realmProfile.Images);
            
            //Show Loading HUD
            if(realmProfile.Images != NULL){
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"Loading Gallery..";
                
                for(NSString * imageName in realmProfile.Images){
                    UIImage * tmp = [UIImage imageNamed:imageName];
                    
                    [galleryImages addObject:tmp];
                }
                [self.tableView reloadData];
                [hud hideAnimated:YES];
            }
        }
            break;
        case 2:
        {
            NSLog(@"Loading Skills");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Loading Skills..";
            
            skills = [[NSMutableArray alloc]init];
            [skills removeAllObjects];
     
            NSLog(@"%@", realmProfile);
            NSLog(@"%lu", (unsigned long)realmProfile.skills.count);
            for(NSString * tmp in realmProfile.skills)
            {
                if (!([tmp isKindOfClass:[NSNull class]] || tmp == nil))
                {
                    NSLog(@"%@", tmp);
                    if ([tmp containsString:@".null"])
                    {
                        NSLog(@"CONTAINS");
                        [tmp stringByReplacingOccurrencesOfString:@".null" withString:@""];
                    }
                    [skills addObject:tmp];
                }
            }
            //NSLog(@"SKILL:%@", skills[skills.count-1]);
            [self.tableView reloadData];
            [hud hideAnimated:YES];
            
            
        }
            break;
        case 3:
        {
            NSLog(@"Loading Credit Data");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Loading Credits..";
            
            if(selectedMember != nil){
                RLMResults<Credits * > * results = [Credits objectsWhere:@"MemberId = %@ AND State = 'Approved'",selectedMember.objectId];
                if(results != nil){
                    credits = [[NSMutableArray alloc] init];
                    for(Credits * tmp in results){
                        [credits addObject:tmp];
                        [self addCreditToArray:tmp];
                        NSLog(@"%@", tmp);
                    }
                    
                    [self.tableView reloadData];
                    [hud hideAnimated:YES];
                    if (credits.count == 0)
                    {
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:@"No Credits"
                                                     message:[NSString stringWithFormat:@"%@ doesn't have and verified credits at the moment.", selectedMember.Name]
                                                     preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction * cancel = [UIAlertAction
                                                  actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleCancel
                                                  handler:^(UIAlertAction * action) {
                                         
                                                  }];
                        
                        [alert addAction:cancel];
                        [self presentViewController: alert animated:YES completion:nil];
                    }
                }
                
            }
            [self.tableView reloadData];
            
        }
            break;
            
        default:
            break;
    }
    return returnArray;
}

-(void)addCreditToArray:(Credits *)cred
{
    if (!cred.JobRole)
    {
        return;
    }
    if ([cred.JobRole isEqualToString:@"Stunt Co-ordinator"])
    {
        if (!cred_coordinatorArray)
        {
            stuntSectionCount +=1;
            cred_coordinatorArray = [[NSMutableArray alloc]init];
        }
        [cred_coordinatorArray addObject:cred];
    }
    if ([cred.JobRole isEqualToString:@"Assistant Stunt Co-ordinator"])
    {
        if (!cred_asstCoordinatorArray)
        {
            stuntSectionCount +=1;
            cred_asstCoordinatorArray = [[NSMutableArray alloc]init];
        }
        [cred_asstCoordinatorArray addObject:cred];
    }
    if ([cred.JobRole isEqualToString:@"Self Co-ordinated"])
    {
        if (!cred_selfCoordinated)
        {
            stuntSectionCount +=1;
            cred_selfCoordinated = [[NSMutableArray alloc]init];
        }
        [cred_selfCoordinated addObject:cred];
    }
    if ([cred.JobRole isEqualToString:@"Stunt Performer"])
    {
        if (!cred_performer)
        {
            stuntSectionCount +=1;
            cred_performer = [[NSMutableArray alloc]init];
        }
        [cred_performer addObject:cred];
    }
    if ([cred.JobRole isEqualToString:@"Stunt Rigger"])
    {
        if (!cred_rigger)
        {
            stuntSectionCount +=1;
            cred_rigger = [[NSMutableArray alloc]init];
        }
        [cred_rigger addObject:cred];
    }
}

#pragma mark - Lists

- (IBAction)openPopup:(id)sender {
    
    [self GetLists];
    
    if(popoverViewController == nil) {
        popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"popover"];
        
    }
    popoverViewController.lists = lists;
    popoverViewController.profileParent = self;
    popoverViewController.preferredContentSize = CGSizeMake(300, 350);
    popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popoverController = popoverViewController.popoverPresentationController;
    popoverController.permittedArrowDirections = nil;
    popoverController.delegate = self;
    popoverController.sourceView = self.view;
    popoverController.sourceRect = [self.view frame];
    
    [self presentViewController:popoverViewController animated:YES completion:nil];
}

-(void)AddNewList
{
    if(newPopoverController == nil) {
        newPopoverController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewListPopover"];
        
    }
    newPopoverController.parent = self;
    newPopoverController.preferredContentSize = CGSizeMake(300, 219);
    newPopoverController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popoverController = newPopoverController.popoverPresentationController;
    popoverController.permittedArrowDirections = nil;
    popoverController.delegate = self;
    popoverController.sourceView = self.view;
    popoverController.sourceRect = [self.view frame];
    
    [self presentViewController:newPopoverController animated:YES completion:nil];
    [self dismissModalViewControllerAnimated:YES];
    
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

-(void)GetLists
{
    if([PFUser currentUser] != NULL){
        RLMResults<List *> * results = [List objectsWhere:@"author = %@",[PFUser currentUser].objectId];
        if(results != nil && results.count > 0){
            NSMutableArray * tmpList = [[NSMutableArray alloc] init];
            for(List * tmp in results){
                [tmpList addObject:tmp];
            }
            lists = tmpList;
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show-image-segue"])
    {
        ImageViewController *vc = segue.destinationViewController;
        vc.imageToShow = selectedImage;
    }
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"popover"]) {
        UIViewController *dvc = segue.destinationViewController;
        UIPopoverPresentationController *ppc = dvc.popoverPresentationController;
        if (ppc) {
            if ([sender isKindOfClass:[UIButton class]]) { // Assumes the popover is being triggered by a UIButton
                ppc.sourceView = (UIButton *)sender;
                ppc.sourceRect = [(UIButton *)sender bounds];
                ppc.permittedArrowDirections = nil;
            }
            ppc.delegate = self;
        }
    }
}

//    NSString *emailTitle =  [NSString stringWithFormat:@"Profile for %@ from British Stunt Register", selectedMember[@"Name"]];
//    NSString *messageBody = [NSString stringWithFormat:@"Please find attached the profile of %@ from the British Stunt Register App.", selectedMember[@"Name"]];

-(IBAction)ShareProfile:(id)sender
{
    [self CreatePDF];
}


#pragma mark PDF METHODS
-(void)CreatePDF
{
    members = [[NSMutableArray alloc]initWithObjects:selectedMember, nil];
    NSMutableArray *membersForPDF = [[NSMutableArray alloc] init];
    
    for (PFObject *member in members)
    {
        NSLog(@"%@", member);
        
        NSMutableDictionary *memberDict = [[NSMutableDictionary alloc] init];
        [memberDict setObject:member forKey:@"member"];
        
        Profile *profile = [self GetProfileDataForMember:member];
        
        if (profile != nil)
        {
            [memberDict setObject:profile forKey:@"profile"];
        }
        NSLog(@"%@", member[@"uid"]);
        NSMutableArray *credits = [self GetCreditsForMember:member[@"uid"]];
        if (profile != nil)
        {
            [memberDict setObject:credits forKey:@"credits"];
        }
        
        [membersForPDF addObject:memberDict];
    }
    UIView *pdfView = [self CreatePdfForUsers:membersForPDF];
    //Create PDF
    /* CREATE PDF */
    NSInteger pageHeight = 842; // Standard page height - adjust as needed
    NSInteger pageWidth = 595; // Standard page width - adjust as needed
    
    /* CREATE PDF */
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0,0,pageWidth,pageHeight), nil);
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    for (int page=0; pageHeight * page < pdfView.frame.size.height; page++)
    {
        UIGraphicsBeginPDFPage();
        CGContextTranslateCTM(pdfContext, 0, -pageHeight * page);
        [pdfView.layer renderInContext:pdfContext];
    }
    
    UIGraphicsEndPDFContext();
    
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:@"document"];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    
    NSString *emailTitle =  [NSString stringWithFormat:@"Profile for %@ from British Stunt Register", selectedMember[@"Name"]];
    NSString *messageBody = @"Please find attached my list from the British Stunt Register App.";
    
    
    //    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    //    NSString *filename = [NSString stringWithFormat:@"%@", selectedMember[@"Name"]];
    //
    //    mc.mailComposeDelegate = self;
    //    [mc setSubject:emailTitle];
    //    [mc setMessageBody:messageBody isHTML:NO];
    //    [mc addAttachmentData:pdfData mimeType:@"application/pdf" fileName:filename];
    //
    //
    //[self presentViewController:mc animated:YES completion:NULL];
    
}

-(Profile *)GetProfileDataForMember:(PFObject *)member
{
    
    if (member[@"uid"] != NULL)
    {
        realmProfile = [Profile objectsWhere:@"uid = %@",selectedMember.objectId].firstObject;
        return realmProfile;
        
    }
    return nil;
}


-(NSMutableArray *)GetCreditsForUser:(NSString *)userID
{
    if (userID != NULL)
    {
        RLMResults<Credits *> *results = [Credits objectsWhere:@"User = %@ AND State = 'Approved'", userID];
        NSLog(@"User = '%@' AND State = 'Approved'", userID);
        if(results != nil){
            NSLog(@"%lu", (unsigned long)results.count);
            NSMutableArray *credits = [[NSMutableArray alloc] init];
            for(Credits * credit in results) {
                [credits addObject:credit];
            }
            return credits;
        }
        return nil;
    }
    return nil;

}

//Replaces Function above
-(NSMutableArray *)GetCreditsForMember:(NSString *)MemberID
{
    if (MemberID != NULL)
    {
        RLMResults<Credits *> *results = [Credits objectsWhere:@"Member = %@ AND State = 'Approved'", MemberID];
        NSLog(@"Member = '%@' AND State = 'Approved'", MemberID);
        if(results != nil){
            NSLog(@"%lu", (unsigned long)results.count);
            NSMutableArray *credits = [[NSMutableArray alloc] init];
            for(Credits * credit in results) {
                [credits addObject:credit];
            }
            return credits;
        }
        return nil;
    }
    return nil;
    
}
-(UIView *)CreatePdfForUsers:(NSMutableArray *)pdfMembers
{
    NSLog(@"%@", [pdfMembers[0] class]);
    int pageHeightTotal = 842*pdfMembers.count;
    
    UIView *returnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 595, pageHeightTotal)];
    
    for (int i = 0; i < members.count; i++) {
        
        Members *currentmember = [[pdfMembers objectAtIndex:i] objectForKey:@"member"];
        Profile *profile = [[pdfMembers objectAtIndex:i] objectForKey:@"profile"];
        NSMutableArray *credits = [[pdfMembers objectAtIndex:i] objectForKey:@"credits"];
        //Create PDF BackgroundView
        UIImageView *pdfView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (842*i), 595, 842)];
        pdfView.image = [UIImage imageNamed:@"PDF_Template"];
        
        /* Logo */
        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(259, 9, 50, 50)];
        logo.image = [UIImage imageNamed:@"BSR-Logo50"];
        //[pdfView addSubview:logo];
        
        /* Profile Image */
        UIImageView *profileImage = [[UIImageView alloc]initWithFrame:CGRectMake(21, 85, 220, 220)];
        //Member Image
        
        // Perform long running process
        PFFile *imgFile = currentmember[@"profileImage"];
        
        if (selectedMember.profileImage != NULL)
        {
            profileImage.image = [UIImage imageNamed:selectedMember.profileImage];
        }
        else
        {
            profileImage.image = [UIImage imageNamed:@"placeholder"];
        }
        [pdfView addSubview:profileImage];
        
        
        /* Profile Name */
        UILabel *profileName = [[UILabel alloc]initWithFrame:CGRectMake(283, 108, 290, 30)];
        profileName.text = [NSString stringWithFormat:@"%@ %@", selectedMember.FirstName, selectedMember.LastName];
        profileName.font = [UIFont fontWithName:@"SFProText-Light" size:26];
        profileName.textColor = [UIColor blackColor];
        [pdfView addSubview:profileName];
        
        /* Memeber Status */
        UIView *memberBadgeView = [self GetMemberStatusBadge:[currentmember.MemberType intValue]];
        [pdfView addSubview:memberBadgeView];
        
        /* Phone  */
        UIImageView *phoneIcon = [[UIImageView alloc]initWithFrame:CGRectMake(283, 194, 25, 25)];
        phoneIcon.image = [UIImage imageNamed:@"Phone"];
        [pdfView addSubview:phoneIcon];
        
        UILabel *phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(325, 203, 200, 16)];
        phoneNumber.text = selectedMember.phoneNumber;
        phoneNumber.font = [UIFont fontWithName:@"SFProText-Light" size:14];
        phoneNumber.textColor = UIColorFromRGB(0x005BFF);
        [pdfView addSubview:phoneNumber];
        
        /* Email  */
        UIImageView *emailIcon = [[UIImageView alloc]initWithFrame:CGRectMake(283, 234, 25, 25)];
        emailIcon.image = [UIImage imageNamed:@"Email"];
        [pdfView addSubview:emailIcon];
        
        UILabel *emailAddress = [[UILabel alloc]initWithFrame:CGRectMake(325, 237, 200, 16)];
        emailAddress.text = selectedMember.Email;
        emailAddress.font = [UIFont fontWithName:@"SFProText-Light" size:14];
        emailAddress.textColor = UIColorFromRGB(0x005BFF);
        [pdfView addSubview:emailAddress];
        
        /* Physical Description  */
        //Column 1
        UILabel *eyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 349, 70, 32)];
        eyeLabel.text = profile.EyeColour;
        eyeLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        eyeLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:eyeLabel];
        
        UILabel *hairLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 381, 70, 32)];
        hairLabel.text = profile.HairColour;
        hairLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hairLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hairLabel];
        
        UILabel *facialHairLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 413, 70, 32)];
        facialHairLabel.text = profile.FacialHair;
        facialHairLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        facialHairLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:facialHairLabel];
        
        UILabel *chestLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 445, 70, 32)];
        if (profile[@"Chest"]) {
            chestLabel.text = [NSString stringWithFormat:@"%@in", profile.Chest];
        }
        
        chestLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        chestLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:chestLabel];
        
        //Column 2
        UILabel *collarLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 349, 70, 32)];
        if (profile[@"Collar"]) {
            collarLabel.text = [NSString stringWithFormat:@"%@in", profile.Collar];
        }
        collarLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        collarLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:collarLabel];
        
        UILabel *hatLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 381, 70, 32)];
        if (profile[@"Hat"]) {
            hatLabel.text = [NSString stringWithFormat:@"%@in", profile.Hat];
        }
        hatLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hatLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hatLabel];
        
        UILabel *heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 413, 70, 32)];
        
        if (profile[@"Height"])
        {
            int inches = [profile.Height intValue];
            int feet = inches / 12;
            int leftover = inches % 12;
            heightLabel.text = [NSString stringWithFormat:@"%dft %din", feet, leftover];
        }
        else
        {
            heightLabel.text = @"";
        }
        
        heightLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        heightLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:heightLabel];
        
        UILabel *hipLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 445, 70, 32)];
        if (profile.Hips) {
            hipLabel.text = [NSString stringWithFormat:@"%@in", profile.Hips];
        }
        hipLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hipLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hipLabel];
        
        //Column 3
        UILabel *insideArmLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 349, 70, 32)];
        if (profile.InsideArm) {
            insideArmLabel.text = [NSString stringWithFormat:@"%@in", profile.InsideArm];
        }
        insideArmLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        insideArmLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:insideArmLabel];
        
        UILabel *insideLegLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 381, 70, 32)];
        if (profile.InsideLeg) {
            insideLegLabel.text = [NSString stringWithFormat:@"%@in", profile.InsideLeg];
        }
        insideLegLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        insideLegLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:insideLegLabel];
        
        UILabel *waistLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 413, 70, 32)];
        if (profile.Waist && profile.Waist != nil) {
            waistLabel.text = [NSString stringWithFormat:@"%@in", profile[@"Waist"]];
        }
        waistLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        waistLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:waistLabel];
        
        UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 445, 70, 32)];
        
        if (profile.Weight)
        {
            int pounds = [profile.Weight intValue];
            int stone = pounds / 14;
            int leftover = pounds % 14;
            weightLabel.text = [NSString stringWithFormat:@"%dst %dlb", stone, leftover];
        }
        else
        {
            weightLabel.text = @"";
        }
        
        
        weightLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        weightLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:weightLabel];
        
        /* Skills  */
        
        UITextView  *skillsView = [[UITextView alloc]initWithFrame:CGRectMake(21, 516, 553, 129)];
        NSString *skillsString = @"";
        for (NSString *str in profile.skills)
        {
            skillsString = [NSString stringWithFormat:@"%@, %@", skillsString, str];
        }
        
        skillsView.text = skillsString;
        skillsView.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        skillsView.alpha = 0.6;
        [pdfView addSubview:skillsView];
        
        /* Credits */
        
        for (Credits *credit in credits)
        {
            int index = [credits indexOfObject:credit];
            int y_pos;
            switch (index) {
                case 0:
                    y_pos = 692;
                    break;
                case 1:
                    y_pos = 724;
                    break;
                case 2:
                    y_pos = 756;
                    break;
                    
                default:
                    y_pos = 0;
                    break;
            }
            //Credit 1
            UILabel *credit1ProdLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, y_pos, 165, 32)];
            credit1ProdLabel.text = credit.Production;
            credit1ProdLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
            [pdfView addSubview:credit1ProdLabel];
            
            UILabel *credit1RoleLabel = [[UILabel alloc]initWithFrame:CGRectMake(236, y_pos, 100, 32)];
            if (credit[@"JobRole"]) {
                credit1RoleLabel.text = credit.JobRole;;
            }
            credit1RoleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
            [pdfView addSubview:credit1RoleLabel];
            
            UILabel *credit1StudioLabel = [[UILabel alloc]initWithFrame:CGRectMake(419, y_pos, 115, 32)];
            credit1StudioLabel.text = credit.Producer;
            credit1StudioLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
            [pdfView addSubview:credit1StudioLabel];
            
            UILabel *credit1YearLabel = [[UILabel alloc]initWithFrame:CGRectMake(515, y_pos, 110, 32)];
            //credit1YearLabel.text = credit[@"JobRole"];
            credit1YearLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
            //[pdfView addSubview:credit1YearLabel];
            
        }
        [returnView addSubview:pdfView];
    }
    return returnView;
}


-(UIView *)GetMemberStatusBadge:(int)status
{
    /* Memeber Status */
    UIView *memberBadgeView = [[UIView alloc]initWithFrame:CGRectMake(296, 148, 150, 20)];
    memberBadgeView.layer.cornerRadius = 8;
    memberBadgeView.clipsToBounds = YES;
    
    UILabel *memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 140, 20)];
    memberLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    memberLabel.textColor = [UIColor whiteColor];
    memberLabel.textAlignment = NSTextAlignmentCenter;
    [memberBadgeView addSubview:memberLabel];
    
    
    switch (status) {
        case 0:
            //Full Member
            memberBadgeView.backgroundColor = UIColorFromRGB(0xDD3131);
            memberLabel.text = @"Probationary";
            break;
        case 1:
            //Intermediate
            memberBadgeView.backgroundColor = UIColorFromRGB(0xEF931F);
            memberLabel.text = @"Intermediate";
            break;
        case 2:
            //Probationary
            memberBadgeView.backgroundColor = UIColorFromRGB(0x66CB63);
            memberLabel.text = @"Full Member";
            break;
            
        default:
            break;
    }
    return memberBadgeView;
}

#pragma mark Utilities
-(NSMutableDictionary *)inchesToFeetAndInches:(float)input
{
    float inchesInFeet = input/12;
    int feet = inchesInFeet;
    float inchesRemaining = inchesInFeet - feet;
    float inchesFloat = inchesRemaining*12;
    int inches = inchesFloat;
    
    NSLog(@"%d ft %d in", feet, inches);
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]init];
    [returnDict setObject:[NSNumber numberWithInt:feet] forKey:@"Feet"];
    [returnDict setObject:[NSNumber numberWithInt:inches] forKey:@"Inches"];
    
    return returnDict;
}

-(NSMutableDictionary *)inchesToMetersandCm:(float)input
{
    float inchesInCM = input*2.54;
    int meteres = inchesInCM/100;
    int cm = inchesInCM - meteres*100;
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]init];
    [returnDict setObject:[NSNumber numberWithInt:meteres] forKey:@"Metres"];
    [returnDict setObject:[NSNumber numberWithInt:cm] forKey:@"Centimeteres"];
    
    return returnDict;
}
-(NSMutableDictionary *)poundsToKilgramsAndGrams:(float)input
{
    NSLog(@"%f lbs",input);
    double poundsInGrams = input*453.59237;
    
    int kilograms = poundsInGrams/1000;
    float i = (poundsInGrams/1000);
    int grams = (i - kilograms) *100;
    
    NSLog(@"%d kg %d g", kilograms, grams);
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]init];
    [returnDict setObject:[NSNumber numberWithInt:kilograms] forKey:@"Kilograms"];
    [returnDict setObject:[NSNumber numberWithInt:grams] forKey:@"Grams"];
    
    return returnDict;
}


@end


