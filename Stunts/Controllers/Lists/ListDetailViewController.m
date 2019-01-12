//
//  ListDetailViewController.m
//  Stunts
//
//  Created by Richard Allen on 19/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "ListDetailViewController.h"
#import "MemberCollectionViewCell.h"
#import "ProfileTableViewController.h"
#import "AppImports.h"
#import <MessageUI/MessageUI.h>
#import "Members.h"
#import "Profile.h"
#import "Credits.h"

@interface ListDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UICollectionView *memberCollectionView;
    NSMutableArray *members;
    __weak IBOutlet UILabel *listLabel;
    Members *selectedMember;
    BOOL selectionMode;
    __weak IBOutlet UIButton *deleteButton;
    __weak IBOutlet UIButton *moveButton;
    __weak IBOutlet UIButton *cancelButton;
    __weak IBOutlet UILabel *ListinfoLabel;
    __weak IBOutlet UIButton *selectButton;
    
    UIView *backgroundDarkView;
    UIView *popoverView;
    NSIndexPath *selectedListIndex;
    Profile * realmProfile;
    NSMutableArray *selectedMembers;
}
@end

@implementation ListDetailViewController
@synthesize list;
@synthesize lists;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectionMode = NO;
    selectedMembers = [[NSMutableArray alloc]init];
    
    NSLog(@"%@", list);
    NSLog(@"%@", members[0]);
    
    ListinfoLabel.text = @"";
    ListinfoLabel.numberOfLines = 0;
    ListinfoLabel.font = [UIFont fontWithName:@"SFProText-Light" size:14];
    
    NSString * memberList = @"";
    for(NSString * memberId in list.members){
        if(memberList.length > 0){
            memberList = [memberList stringByAppendingString:@" OR "];
        }
        memberList = [memberList stringByAppendingString:[NSString stringWithFormat:@"objectId == '%@'",memberId]];
    }
    NSLog(@"Query:%@",memberList);
    RLMResults<Members * > * results = [Members objectsWhere:memberList];
    NSLog(@"After:%lu",results.count);
    members = [[NSMutableArray alloc] init];
    if(results != NULL){
        for(Members * member in results){
            [members addObject:member];
        }
    }
    [memberCollectionView reloadData];
    
    [memberCollectionView registerClass:[MemberCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    listLabel.text = list[@"name"];
    
    self.tabBarController.tabBar.hidden = NO;
    
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
    return members.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.selectUserButton.tag = indexPath.row;
    [cell.selectUserButton addTarget:self action:@selector(addRemoveMemberToSelectedMembersGroup:) forControlEvents:UIControlEventTouchUpInside];
    
    if (selectionMode == YES)
    {
        cell.selectUserButton.hidden = NO;
    }
    else
    {
        cell.selectUserButton.hidden = YES;
    }
    
    
    Members *currentMember = [members objectAtIndex:indexPath.row];
    
    if(currentMember.profileImage != nil){
        cell.memberImage.image = [UIImage imageNamed:currentMember.profileImage];
    }else{
        cell.memberImage.image = [UIImage imageNamed:@"placeholder"];
    }
    
    //Member Name
    cell.memberName.text = currentMember.Name;
    //Member Type
    //    cell.memberType = [currentmember[@"MemberType"]intValue];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedMember = [members objectAtIndex:indexPath.row];
    MemberCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (selectionMode == YES)
    {
        if ([selectedMembers containsObject:[members objectAtIndex:indexPath.row]])
        {
            [cell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
            [selectedMembers removeObject:[members objectAtIndex:indexPath.row]];
            return;
            
        }
        [selectedMembers addObject:selectedMember];
        [cell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Checked-checkbox25"] forState:UIControlStateNormal];
        return;
    }
    
    [self performSegueWithIdentifier:@"show-user-profile" sender:self];
}

-(void)addRemoveMemberToSelectedMembersGroup:(UIButton *)sender
{
    if ([selectedMembers containsObject:[members objectAtIndex:sender.tag]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
        [selectedMembers removeObject:[members objectAtIndex:sender.tag]];
        return;
        
    }
    [selectedMembers addObject:selectedMember];
    NSLog(@"%@", selectedMember);
    [sender setBackgroundImage:[UIImage imageNamed:@"Checked-checkbox25"] forState:UIControlStateNormal];
    return;
}


- (IBAction)selectButtonPressed:(id)sender
{
    deleteButton.hidden = NO;
    moveButton.hidden = NO;
    selectButton.hidden = NO;
    cancelButton.hidden = NO;
    selectButton.hidden = YES;
    selectionMode = YES;
    [memberCollectionView reloadData];
}
- (IBAction)deleteButtonPressed:(id)sender
{
    deleteButton.hidden = YES;
    moveButton.hidden = YES;
    selectButton.hidden = YES;
    selectButton.hidden = NO;
    cancelButton.hidden = YES;
    selectionMode = NO;
    [memberCollectionView reloadData];
    if (selectedMembers.count > 0)
    {
        //Remove members from colleciton view
        [members removeObjectsInArray:selectedMembers];
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [list.members removeAllObjects];
            for(Members * tmp in members){
                [list.members addObject:tmp.objectId];
            }
        }];
        
        
        [memberCollectionView reloadData];
        
    }
}
- (IBAction)moveButtonPressed:(id)sender
{
    deleteButton.hidden = YES;
    moveButton.hidden = YES;
    selectButton.hidden = YES;
    selectButton.hidden = NO;
    cancelButton.hidden = YES;
    selectionMode = NO;
    [memberCollectionView reloadData];
    if (selectedMembers.count > 0)
    {
        NSLog(@"Number of Members to move: %lu", (unsigned long)[selectedMembers count]);
        
        backgroundDarkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0.0;
        [self.view addSubview:backgroundDarkView];
        
        popoverView = [[UIView alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350)];
        popoverView.backgroundColor = [UIColor whiteColor];;
        popoverView.layer.cornerRadius = 15;
        [self.view addSubview:popoverView];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, popoverView.frame.size.width-20, 50)];
        headerLabel.text = @"Please choose a list to move these members to";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:18];
        headerLabel.numberOfLines = 0;
        [popoverView addSubview:headerLabel];
        
        UITableView *listTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 70, popoverView.frame.size.width-20, 170) style:UITableViewStylePlain];
        listTableView.delegate = self;
        listTableView.dataSource = self;
        [popoverView addSubview:listTableView];
        
        UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake((popoverView.frame.size.width-242)/2, 260, 242, 50)];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"Done_List_242"] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(moveMembersToList:) forControlEvents:UIControlEventTouchUpInside];
        [popoverView addSubview:doneButton];
        
        [UIView animateWithDuration:0.4f animations:^{
            backgroundDarkView.alpha = 0.4;
            popoverView.frame = CGRectMake(50, self.view.frame.size.height/2-180, self.view.frame.size.width-100, 350);
            
        } completion:^(BOOL finished) {
            
            NSLog(@"Transition Complete");
        }];
    }
    
}
- (IBAction)cancelButtonPressed:(id)sender
{
    deleteButton.hidden = YES;
    moveButton.hidden = YES;
    selectButton.hidden = YES;
    selectButton.hidden = NO;
    cancelButton.hidden = YES;
    selectionMode = NO;
    [memberCollectionView reloadData];
    [selectedMembers removeAllObjects];
}


-(void)moveMembersToList:(id)sender
{
    //Add Members to new list
    List * tmp = [lists objectAtIndex:selectedListIndex.row];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    for (Members *member in selectedMembers)
    {
        [data addObject:member.objectId];
        [members removeObject:data];
    }
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [tmp.members removeAllObjects];
        [tmp.members addObjects:data];
        
        [UIView animateWithDuration:0.4f animations:^{
            backgroundDarkView.alpha = 0.0;
            popoverView.frame = CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350);
            
        } completion:^(BOOL finished) {
            backgroundDarkView = nil;
            popoverView = nil;
            NSLog(@"Transition Complete");
        }];
        [memberCollectionView reloadData];
    }];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show-user-profile"])
    {
        ProfileTableViewController *vc = segue.destinationViewController;
        vc.selectedMember = selectedMember;
        
    }
}
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shareButtonPressed:(id)sender
{
    NSLog(@"Sharing List");
    //Create List
    [self CreatePDF];
    
    //Share List
}

#pragma mark TableView METHODS
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lists.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    List * currentList = [lists objectAtIndex:indexPath.row];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    if (selectedListIndex == indexPath)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = currentList.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedListIndex = indexPath;
    [tableView reloadData];
}

#pragma mark PDF METHODS

-(void)CreatePDF
{
    NSMutableArray *membersForPDF = [[NSMutableArray alloc] init];
    
    for (Members *member in members)
    {
        NSMutableDictionary *memberDict = [[NSMutableDictionary alloc] init];
        [memberDict setObject:member forKey:@"member"];
        [self GetProfileDataForMember:member];
        
        Profile *profile = [self GetProfileDataForMember:member];
        if (profile != nil)
        {
            [memberDict setObject:profile forKey:@"profile"];
        }
        
        NSMutableArray *credits = [self GetCreditsForUser:member.uid];
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
    NSString* documentDirectoryFilename = [[documentDirectory stringByAppendingPathComponent:@"document"] stringByAppendingPathExtension:@"pdf"];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);

    
    //Mail Share Sheet
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",documentDirectoryFilename]];
    
        NSString *emailTitle =  listLabel.text;
        NSString *messageBody = @"Please find attached my list from the British Stunt Register App.";
    
    
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        NSString *filename = [NSString stringWithFormat:@"%@.pdf", listLabel.text];
    
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc addAttachmentData:pdfData mimeType:@"application/pdf" fileName:filename];
    
    
        [self presentViewController:mc animated:YES completion:NULL];
    
}

-(Profile *)GetProfileDataForMember:(Members *)member
{
    
    if (member.uid != NULL)
    {
        realmProfile = [Profile objectsWhere:@"uid = %@",selectedMember.objectId].firstObject;
        return realmProfile;
        
    }
    return nil;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertController * alert;
    
    if(result == MFMailComposeResultSent){
           alert = [UIAlertController
                                 alertControllerWithTitle:@"Sent"
                                 message:@"Your list has been sent."
                                 preferredStyle:UIAlertControllerStyleAlert];
    }
    else{
        alert = [UIAlertController
                 alertControllerWithTitle:@"Not sent"
                 message:@"Your list was not sent."
                 preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * cancel = [UIAlertAction
                              actionWithTitle:@"Ok"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
                                  
                              }];
    
    [alert addAction:cancel];
    [self presentViewController: alert animated:YES completion:nil];
    
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
-(UIView *)CreatePdfForUsers:(NSMutableArray *)pdfMembers
{
    
    int pageHeightTotal = 421*pdfMembers.count;
    UIView *returnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 595, pageHeightTotal)];
    
    for (int i = 0; i < members.count; i++) {

        Members *selectedMember = [[pdfMembers objectAtIndex:i] objectForKey:@"member"];
        Profile *profile = [Profile objectsWhere:@"uid = %@",selectedMember.objectId].firstObject;
        
        //Create PDF BackgroundView
        UIView *pdfView = [[UIView alloc]initWithFrame:CGRectMake(0, i * 421, 595, 421)];
        //pdfView.image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"PDF_Template_3.png"], 0.5)];

        /* Logo */
        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(259,9, 50, 50)];
        logo.image = [UIImage imageNamed:@"BSR-Logo50"];
        //[pdfView addSubview:logo];
        
        /* Profile Image */
        UIImageView *profileImage = [[UIImageView alloc]initWithFrame:CGRectMake(21, 55, 200, 200)];
        
        //Member Image
        if (selectedMember.profileImage != NULL)
        {
            //profileImage.image = [UIImage imageNamed:selectedMember.profileImage];
            profileImage.image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage imageNamed:selectedMember.profileImage], 0.5)];
        }
        else
        {
            profileImage.image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"placeholder"], 0.5)];
        }
        [pdfView addSubview:profileImage];
        
        [self createLabelsFor:pdfView];
        
        /* Profile Name */
        UILabel *profileName = [[UILabel alloc]initWithFrame:CGRectMake(283, 78, 290, 30)];
        profileName.text = [NSString stringWithFormat:@"%@ %@", selectedMember.FirstName, selectedMember.LastName];
        profileName.font = [UIFont fontWithName:@"SFProText-Light" size:26];
        profileName.textColor = [UIColor blackColor];
        [pdfView addSubview:profileName];
        
        /* Memeber Status */
        UIView *memberBadgeView = [self GetMemberStatusBadge:[selectedMember.MemberType intValue]];
        memberBadgeView.frame = CGRectMake(296, 118, memberBadgeView.frame.size.width, memberBadgeView.frame.size.height);
        [pdfView addSubview:memberBadgeView];
        
        /* Phone  */
        UIImageView *phoneIcon = [[UIImageView alloc]initWithFrame:CGRectMake(283, 164, 25, 25)];
        phoneIcon.image = [UIImage imageNamed:@"Phone"];
        [pdfView addSubview:phoneIcon];
        
        UILabel *phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(325, 173, 200, 16)];
        phoneNumber.text = selectedMember.phoneNumber;
        phoneNumber.font = [UIFont fontWithName:@"SFProText-Light" size:14];
        phoneNumber.textColor = UIColorFromRGB(0x005BFF);
        [pdfView addSubview:phoneNumber];
        
        /* Email  */
        UIImageView *emailIcon = [[UIImageView alloc]initWithFrame:CGRectMake(283, 204, 25, 25)];
        emailIcon.image = [UIImage imageNamed:@"Email"];
        [pdfView addSubview:emailIcon];
        
        UILabel *emailAddress = [[UILabel alloc]initWithFrame:CGRectMake(325, 207, 200, 16)];
        emailAddress.text = selectedMember.Email;
        emailAddress.font = [UIFont fontWithName:@"SFProText-Light" size:14];
        emailAddress.textColor = UIColorFromRGB(0x005BFF);
        [pdfView addSubview:emailAddress];
        
        /* Physical Description  */
        //Column 1
        UILabel *eyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 300, 70, 32)];
        eyeLabel.text = profile.EyeColour;
        eyeLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        eyeLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:eyeLabel];
        
        UILabel *hairLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 332, 70, 32)];
        hairLabel.text = profile.HairColour;
        hairLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hairLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hairLabel];
        
        UILabel *facialHairLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 364, 70, 32)];
        facialHairLabel.text = profile.FacialHair;
        facialHairLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        facialHairLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:facialHairLabel];
        
        UILabel *chestLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 396, 70, 32)];
        if (profile[@"Chest"]) {
            chestLabel.text = [NSString stringWithFormat:@"%@in", profile.Chest];
        }
        
        chestLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        chestLabel.textColor = [UIColor blackColor];
        
        NSLog(@"%@",profile.Chest);
        [pdfView addSubview:chestLabel];
        
        //Column 2
        UILabel *collarLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 300, 70, 32)];
        if (profile[@"Collar"]) {
            collarLabel.text = [NSString stringWithFormat:@"%@in", profile.Collar];
        }
        collarLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        collarLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:collarLabel];
        
        UILabel *hatLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 332, 70, 32)];
        if (profile[@"Hat"]) {
            hatLabel.text = [NSString stringWithFormat:@"%@in", profile.Hat];
        }
        hatLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hatLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hatLabel];
        
        UILabel *heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 364, 70, 32)];
        
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
        
        UILabel *hipLabel = [[UILabel alloc]initWithFrame:CGRectMake(303, 396, 70, 32)];
        if (profile.Hips) {
            hipLabel.text = [NSString stringWithFormat:@"%@in", profile.Hips];
        }
        hipLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        hipLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:hipLabel];
        
        //Column 3
        UILabel *insideArmLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 300, 70, 32)];
        if (profile.InsideArm) {
            insideArmLabel.text = [NSString stringWithFormat:@"%@in", profile.InsideArm];
        }
        insideArmLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        insideArmLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:insideArmLabel];
        
        UILabel *insideLegLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 332, 70, 32)];
        if (profile.InsideLeg) {
            insideLegLabel.text = [NSString stringWithFormat:@"%@in", profile.InsideLeg];
        }
        insideLegLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        insideLegLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:insideLegLabel];
        
        UILabel *waistLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 364, 70, 32)];
        if (profile.Waist && profile.Waist != nil) {
            waistLabel.text = [NSString stringWithFormat:@"%@in", profile[@"Waist"]];
        }
        waistLabel.font = [UIFont fontWithName:@"SFProText-Light" size:12];
        waistLabel.textColor = [UIColor blackColor];
        [pdfView addSubview:waistLabel];
        
        UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 396, 70, 32)];
        
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

-(void)createLabelsFor:(UIView *)sender
{
    
    UILabel *headerLbl = [[UILabel alloc]initWithFrame:CGRectMake(21, 275, 168, 32)];
    headerLbl.text = @"Physical Description";
    headerLbl.font = [UIFont fontWithName:@"SFProText-Medium" size:17];
    headerLbl.textColor = [UIColor blackColor];
    [sender addSubview:headerLbl];
    
    //Column 1
    UILabel *eyeLbl = [[UILabel alloc]initWithFrame:CGRectMake(21, 300, 80, 32)];
    eyeLbl.text = @"Eye Colour:";
    eyeLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    eyeLbl.textColor = [UIColor blackColor];
    [sender addSubview:eyeLbl];
    
    UILabel *hairLbl = [[UILabel alloc]initWithFrame:CGRectMake(21, 332, 80, 32)];
    hairLbl.text = @"Hair Colour:";
    hairLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    hairLbl.textColor = [UIColor blackColor];
    [sender addSubview:hairLbl];
    
    UILabel *facialLbl = [[UILabel alloc]initWithFrame:CGRectMake(21, 364, 80, 32)];
    facialLbl.text = @"Facial Hair:";
    facialLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    facialLbl.textColor = [UIColor blackColor];
    [sender addSubview:facialLbl];
    
    UILabel *chestLbl = [[UILabel alloc]initWithFrame:CGRectMake(21, 396, 80, 32)];
    chestLbl.text = @"Chest:";
    chestLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    chestLbl.textColor = [UIColor blackColor];
    [sender addSubview:chestLbl];
    
    //Column 2
    UILabel *collarLbl = [[UILabel alloc]initWithFrame:CGRectMake(233, 300, 80, 32)];
    collarLbl.text = @"Collar:";
    collarLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    collarLbl.textColor = [UIColor blackColor];
    [sender addSubview:collarLbl];
    
    UILabel *hatLbl = [[UILabel alloc]initWithFrame:CGRectMake(233, 332, 80, 32)];
    hatLbl.text = @"Hat Size:";
    hatLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    hatLbl.textColor = [UIColor blackColor];
    [sender addSubview:hatLbl];
    
    UILabel *heightLbl = [[UILabel alloc]initWithFrame:CGRectMake(233, 364, 80, 32)];
    heightLbl.text = @"Height:";
    heightLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    heightLbl.textColor = [UIColor blackColor];
    [sender addSubview:heightLbl];
    
    UILabel *hipsLbl = [[UILabel alloc]initWithFrame:CGRectMake(233, 396, 80, 32)];
    hipsLbl.text = @"Hips:";
    hipsLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    hipsLbl.textColor = [UIColor blackColor];
    [sender addSubview:hipsLbl];
    
    //Column 3
    UILabel *indisdeArmLbl = [[UILabel alloc]initWithFrame:CGRectMake(416, 300, 80, 32)];
    indisdeArmLbl.text = @"Inside Arm:";
    indisdeArmLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    indisdeArmLbl.textColor = [UIColor blackColor];
    [sender addSubview:indisdeArmLbl];
    
    UILabel *insideLeg = [[UILabel alloc]initWithFrame:CGRectMake(416, 332, 80, 32)];
    insideLeg.text = @"Inside Leg:";
    insideLeg.font = [UIFont fontWithName:@"SFProText-light" size:12];
    insideLeg.textColor = [UIColor blackColor];
    [sender addSubview:insideLeg];
    
    UILabel *waistLbl = [[UILabel alloc]initWithFrame:CGRectMake(416, 364, 80, 32)];
    waistLbl.text = @"Waist:";
    waistLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    waistLbl.textColor = [UIColor blackColor];
    [sender addSubview:waistLbl];
    
    UILabel *weightLbl = [[UILabel alloc]initWithFrame:CGRectMake(416, 396, 80, 32)];
    weightLbl.text = @"Weight:";
    weightLbl.font = [UIFont fontWithName:@"SFProText-light" size:12];
    weightLbl.textColor = [UIColor blackColor];
    [sender addSubview:weightLbl];

}

@end

