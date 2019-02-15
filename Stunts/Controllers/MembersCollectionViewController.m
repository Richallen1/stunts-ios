//
//  MembersCollectionViewController.m
//  Stunts
//
//  Created by Richard Allen on 28/05/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "macros.h"
#import "MembersCollectionViewController.h"
#import "MemberCollectionViewCell.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "ProfileTableViewController.h"
#import "FilterOptionsViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "Members.h"
#import "Profile.h"
#import "List.h"
#import "MembersPageViewController.h"

@interface MembersCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UICollectionView *collectionView;
    NSMutableArray *__block members;
    NSMutableArray *letters;
    NSString * randomLetters;
    NSMutableArray *letterIndexes;
    NSMutableDictionary *indexesOfMembersFirstLetter;
    
    NSMutableArray *selectedMembers;
    BOOL selectModeEnabled;
    Members *selectedMember;
    __weak IBOutlet UILabel *sexLabel;
    __weak IBOutlet UILabel *memberCount;
    BOOL isInListMode;
    NSMutableArray *usersForList;
    NSMutableArray *memberImages;
    
    __weak IBOutlet UIView *lettersContainer;
    
    
    UIView *listNameDialog;
    UIView *backgroundDarkView;
    
    UITextField *listNameTextField;
    
    UISearchBar *searchBar;
    
    //List Varibles
    __block NSArray *lists;
    UIView *popoverView;
    
    //Buttons
    __weak IBOutlet UIButton *selectButton;
    __weak IBOutlet UIButton *filterButton;
    __weak IBOutlet UIButton *addToList;
    __weak IBOutlet UILabel *buttonSeparator;
    
    MBProgressHUD *hud;
}
@end

@implementation MembersCollectionViewController
@synthesize type;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Init
    selectedMembers = [[NSMutableArray alloc]init];
    isInListMode = NO;
    letters = [[NSMutableArray alloc]initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    randomLetters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    [self getMembersForType:type];
    [self GetLists];
    
    //Set Member Count
    if (type == Male)
    {
        memberCount.text = [self getMembersCount:@"Male"];
    }
    if (type == Female)
    {
        memberCount.text = [self getMembersCount:@"Female"];
        
    }
    if (type == All)
    {
        memberCount.text = [self getMembersCount:@"All"];
    }
    // Register cell classes
    [collectionView registerClass:[MemberCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self AddLettersButtons];

    
}

-(NSString *)getMembersCount:(NSString *)type
{
    if ([type isEqualToString:@"Male"])
        return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members objectsWhere:@"Sex = 'Male'"].count];
    
    if ([type isEqualToString:@"Female"])
        return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members objectsWhere:@"Sex = 'Female'"].count];
    
    if ([type isEqualToString:@"All"])
        return [NSString stringWithFormat:@"%lu Members",(unsigned long)[Members allObjects].count];
    
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getMembersForType:(int)type
{
    //Show Saving HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading...";

    NSPredicate * pred = [[NSPredicate alloc] init];
    switch (type) {
        case 0:
            //Male
            pred = [NSPredicate predicateWithFormat:@"Sex = 'Male'"];
            sexLabel.text = @"Males";
            break;
        case 1:
            //Female
            pred = [NSPredicate predicateWithFormat:@"Sex = 'Female'"];
            sexLabel.text = @"Females";
            break;
        case 2:
            //All
            sexLabel.text = @"All Performers";
            pred = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
            break;

        default:
            break;
    }
    
    RLMResults<Members *> * memberResults = [[Members objectsWithPredicate:pred] sortedResultsUsingKeyPath:@"LastName" ascending:YES];
    if(memberResults != nil){
        members = [[NSMutableArray alloc] init];
        for(Members *member in memberResults)
        {
            //Note: This if statement allows the Office staff at the BSR to have a profile that  is not listed in the mmebers table.
            if (![member.admin isEqualToString:@"YES"])
            {
                [members addObject:member];
            }
      }
        [self checkLetterNavigationIndex];
        NSLog(@"%@", members[12]);
        [collectionView reloadData];
        [hud hideAnimated:YES];
    }else{
        [CrashlyticsKit recordError:@"No member results"];
        NSLog(@"Error: No member results");
        [hud hideAnimated:YES];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"We have hit an error getitng member listings. Please check back later."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(IBAction)ToggleSelectMode
{
    if (selectModeEnabled == NO)
    {
        //Enable Select Mode
        selectModeEnabled = YES;
        for (MemberCollectionViewCell *cell in collectionView.visibleCells)
        {
            cell.selectUserButton.hidden = NO;
        }
    }
    else
    {
        //Disable Select Mode
        selectModeEnabled = NO;
        for (MemberCollectionViewCell *cell in collectionView.visibleCells)
        {
            cell.selectUserButton.hidden = YES;
        }
    }
    
}

#pragma mark Letters Navigation
-(void)AddLettersButtons
{
    int origin_y = 8;
    for (NSString *str in letters)
    {
        UIButton *letter = [[UIButton alloc]initWithFrame:CGRectMake(0, origin_y, 20, 20)];
        [letter setTitle:str forState:UIControlStateNormal];
        [letter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [letter.titleLabel setFont: [UIFont fontWithName:@"SFProText" size:12]];
        letter.tag = [letters indexOfObject:str];
        [letter addTarget:self action:@selector(LetterPressed:) forControlEvents:UIControlEventTouchUpInside];
        [lettersContainer addSubview:letter];
        letter.titleLabel.alpha = 0.4;
        origin_y += (lettersContainer.frame.size.height/25);
    }
}

-(void)LetterPressed:(UIButton *)sender
{
//    NSLog(@"%lu", (unsigned long)indexesOfMembersFirstLetter.count);    NSLog(@"%@", indexesOfMembersFirstLetter);
    
    
    NSLog(@"%@ Button Pressed", sender.titleLabel.text);
    
    
    if ([indexesOfMembersFirstLetter objectForKey:sender.titleLabel.text] != nil)
    {
        int indexInt = [[indexesOfMembersFirstLetter objectForKey:sender.titleLabel.text] intValue];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:[[indexesOfMembersFirstLetter objectForKey:sender.titleLabel.text] intValue]+2 inSection:0];
        [collectionView scrollToItemAtIndexPath:index atScrollPosition:nil animated:YES];

    }
    
    
    return;
//    if ([[indexesOfMembersFirstLetter objectAtIndex:sender.tag] isKindOfClass:[NSString class]])
//    {
//        NSLog(@"STRING");
//    }
//    if ([[indexesOfMembersFirstLetter objectAtIndex:sender.tag] isKindOfClass:[NSNumber class]])
//    {
//        NSLog(@"Number");
//        NSIndexPath *index = [NSIndexPath indexPathForRow:[[indexesOfMembersFirstLetter objectAtIndex:sender.tag]intValue]+2 inSection:0];
//        [collectionView scrollToItemAtIndexPath:index atScrollPosition:nil animated:YES];
//    }
////    NSLog(@"%@", [[indexesOfMembersFirstLetter objectAtIndex:sender.tag] class]);
////
////
////
////    if ([[[indexesOfMembersFirstLetter objectAtIndex:sender.tag] class] isKindOfClass:[NSNumber class]])
////    {
////        NSIndexPath *index = [NSIndexPath indexPathForRow:[[indexesOfMembersFirstLetter objectAtIndex:sender.tag]intValue]+3 inSection:0];
////        [collectionView scrollToItemAtIndexPath:index atScrollPosition:nil animated:YES];
////    }
//
}

-(void)checkLetterNavigationIndex
{
    
    indexesOfMembersFirstLetter = [[NSMutableDictionary alloc]init];
    
    for(Members *obj in members){
        NSString *str = obj.LastName;
        if(str.length){
            NSString *letter = [str substringWithRange:NSMakeRange(0, 1)];
            
            NSLog(@"%@", letter);
            
            if (![indexesOfMembersFirstLetter objectForKey:letter])
            {
                [indexesOfMembersFirstLetter setObject:[NSNumber numberWithInt:[members indexOfObject:obj]] forKey:letter];
            }
        }
    }
    NSLog(@"%@", indexesOfMembersFirstLetter);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Members CollectionView Count: %d",members.count);
    
    if(members.count < 1){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No members matching criteria"
                                                                       message:@"Please adjust filter and try again."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    return members.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.memberImage.image = [UIImage imageNamed:@"placeholder"];
    Members * currentMember = [members objectAtIndex:indexPath.row];
    
    NSLog(@"%lu", (unsigned long)members.count);

    if (currentMember.profileImage == nil)
    {
        cell.memberImage.image = [UIImage imageNamed:@"placeholder"];
    }
    else
    {
        cell.memberImage.image = [UIImage imageNamed:currentMember.profileImage];
    }
        //Select User Button
        [cell.selectUserButton addTarget:self action:@selector(AddMemberToList:) forControlEvents:UIControlEventTouchUpInside];
    
//        cell.user = currentmember;
    cell.member = currentMember;
        if (isInListMode == YES)
        {
            cell.selectUserButton.hidden = NO;
            if(![usersForList containsObject:currentMember]){
                [cell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
            }else{
                [cell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Checked-checkbox25"] forState:UIControlStateNormal];
            }
        }
        else
        {
            cell.selectUserButton.hidden = YES;
        }
    
    
        //Member Name
        cell.memberName.text = [NSString stringWithFormat:@"%@ %@", currentMember.FirstName, currentMember.LastName];
    
        //Member Type
        NSString *memberTypeString = currentMember.MemberType;
        cell.memberType = [memberTypeString intValue];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2-50, 224);
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    if (isInListMode == YES)
    {
        if([usersForList containsObject:selectedCell.member]){
            //User Selected
            [selectedCell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
            
            
            [usersForList removeObject:selectedCell.member];
            
        }
        else
        {
            //User not Selected
            [selectedCell.selectUserButton setBackgroundImage:[UIImage imageNamed:@"Checked-checkbox25"] forState:UIControlStateNormal];

            if (!usersForList) {
                usersForList = [[NSMutableArray alloc]init];
            }
            [usersForList addObject:selectedCell.member];
        }
    }
    else
    {
        selectedMember = [members objectAtIndex:indexPath.row];
        NSLog(@"User %ld Selected", (long)indexPath.row);
        [self performSegueWithIdentifier:@"profile-selected-segue" sender:self];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"profile-selected-segue"])
    {
        
        MembersPageViewController* vc = segue.destinationViewController;
        vc.members = members;
        vc.selectedMember = selectedMember;
    }
    if ([segue.identifier isEqualToString:@"show-filter-options"])
    {
        FilterOptionsViewController *vc = segue.destinationViewController;
        vc.parent = self;
    }
}


#pragma Button Functions
- (IBAction)selectPressed:(UIButton *)sender
{
    NSLog(@"Select Pressed");
    if ([sender.titleLabel.text isEqualToString:@"Select"])
    {
        //Activate Select Mode.
        isInListMode = YES;
        [collectionView reloadData];
        
        //Hide Filter Button
        filterButton.hidden = YES;
        
        //Hide Select Button
        [selectButton setTitle:@"Cancel" forState:UIControlStateNormal];

        //Hide Separator
        buttonSeparator.hidden = YES;
        
        //Show Add To List Button
        addToList.hidden = NO;
    }
    if ([sender.titleLabel.text isEqualToString:@"Cancel"]) {
        //Cancel List Mode
        isInListMode = NO;
        [collectionView reloadData];
        
        //Hide Filter Button
        filterButton.hidden = NO;
        
        //Hide Select Button
        [selectButton setTitle:@"Select" forState:UIControlStateNormal];
        
        //Hide Separator
        buttonSeparator.hidden = NO;
        
        //Show Add To List Button
        addToList.hidden = YES;
        
    }
}
- (IBAction)filterPressed:(id)sender
{
    [self performSegueWithIdentifier:@"show-filter-options" sender:self];
}

#pragma mark List Info
-(void)GetLists
{
    if([PFUser currentUser] != NULL){
        RLMResults<List * > *results = [List objectsWhere:@"author = %@",[PFUser currentUser].objectId];
        if(results != NULL){
            NSMutableArray * tmp = [[NSMutableArray alloc] init];
            for(List *list in results){
                [tmp addObject:list];
            }
            lists = tmp;
        }
    }

}
- (IBAction)addToList:(id)sender
{
    if (!usersForList) {
        //No users for list
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No one selected"
                                                                       message:@"You dont seem to have selected any members for your list."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (usersForList.count > 0)
    {
        NSLog(@"Number of Members to add: %lu", (unsigned long)[usersForList count]);
        
        backgroundDarkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0.0;
        [self.view addSubview:backgroundDarkView];
        
        popoverView = [[UIView alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350)];
        popoverView.backgroundColor = [UIColor whiteColor];;
        popoverView.layer.cornerRadius = 15;
        [self.view addSubview:popoverView];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, popoverView.frame.size.width-20, 50)];
        headerLabel.text = @"Please choose a list to add these members to";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:18];
        headerLabel.numberOfLines = 0;
        [popoverView addSubview:headerLabel];
        
        UIButton *newList = [[UIButton alloc]initWithFrame:CGRectMake(10, 70, popoverView.frame.size.width-20, 30)];
        [newList setImage:[UIImage imageNamed:@"create_new_list_btn"] forState:UIControlStateNormal];
        [newList addTarget:self action:@selector(showNewListPopup:) forControlEvents:UIControlEventTouchUpInside];
        newList.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [popoverView addSubview:newList];
        
        UITableView *listTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, popoverView.frame.size.width-20, 170) style:UITableViewStylePlain];
        listTableView.delegate = self;
        listTableView.dataSource = self;
        [popoverView addSubview:listTableView];
        [listTableView reloadData];
        
        UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake((popoverView.frame.size.width-242)/2, 280, 242, 50)];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"Done_List_242"] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(Done:) forControlEvents:UIControlEventTouchUpInside];
        [popoverView addSubview:doneButton];
        
        [UIView animateWithDuration:0.4f animations:^{
            backgroundDarkView.alpha = 0.4;
            popoverView.frame = CGRectMake(50, self.view.frame.size.height/2-180, self.view.frame.size.width-100, 350);
            
        } completion:^(BOOL finished) {
            
            NSLog(@"Transition Complete");
        }];
    }
}

-(void)showNewListPopup:(UIButton *)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        backgroundDarkView.alpha = 0.0;
        popoverView.frame = CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350);
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
        
        [self ShowAddListDialog];
        
    }];
}

-(void)Done:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        backgroundDarkView.alpha = 0;
        popoverView.frame = CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350);
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
        [self selectPressed:selectButton];
    }];
}

-(void)ShowAddListDialog
{
    [UIView animateWithDuration:0.4f animations:^{
        backgroundDarkView.alpha = 0;
        popoverView.frame = CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350);
        
    } completion:^(BOOL finished) {
        
            backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
            backgroundDarkView.backgroundColor = [UIColor blackColor];
            backgroundDarkView.alpha = 0;
        
            //Gesture recogniser to cancel
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAddListPopover:)];
            [backgroundDarkView addGestureRecognizer:tap];
        
        
            [self.view addSubview:backgroundDarkView];
        
            listNameDialog = [[UIView alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width-20, 180)];
            listNameDialog.backgroundColor = [UIColor whiteColor];
            listNameDialog.layer.cornerRadius = 8;
            listNameDialog.clipsToBounds = YES;
        
        
            //Header Label
            UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, listNameDialog.frame.size.width, 30)];
            headerLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:24];
            headerLabel.text = @"Name Your List";
            headerLabel.textAlignment = NSTextAlignmentCenter;
            [listNameDialog addSubview:headerLabel];
        
            //TextField
            listNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(listNameDialog.frame.size.width/2-145, 52, 290, 33)];
            [listNameTextField setBackground:[UIImage imageNamed:@"TextField"]];
            listNameTextField.text = @"";
            listNameTextField.delegate = self;
            [listNameDialog addSubview:listNameTextField];
        
            //Create Button
            UIButton *createListButton = [[UIButton alloc]initWithFrame:CGRectMake(listNameDialog.frame.size.width/2-135, 113, 270, 43)];
            [createListButton setImage:[UIImage imageNamed:@"create-list-button"] forState:UIControlStateNormal];
            [createListButton addTarget:self action:@selector(createList:) forControlEvents:UIControlEventTouchUpInside];
        
            [listNameDialog addSubview:createListButton];
        
            [self.view addSubview:listNameDialog];
       
        
        [UIView animateWithDuration:0.4f animations:^{
            
            backgroundDarkView.alpha = 0.4;
            listNameDialog.frame = CGRectMake(10, self.view.bounds.size.height/2-50, self.view.bounds.size.width-20, 180);
            
            
        } completion:^(BOOL finished) {
            
            NSLog(@"Transition Complete");
        }];
        
        NSLog(@"Transition Complete");
        
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lists.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    List * list = [lists objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = list.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    List * list = [lists objectAtIndex:indexPath.row];
    [self AddUsersToList:list];
}
-(void)AddUsersToList:(List *)list {
    NSLog(@"%@", list);
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving List..";
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for(Members *member in usersForList){
            [list.members addObject:member.objectId];
        }
    }];
    [hud hideAnimated:YES];
    [UIView animateWithDuration:0.4f animations:^{
        backgroundDarkView.alpha = 0;
        popoverView.frame = CGRectMake(50, self.view.frame.size.height, self.view.frame.size.width-100, 350);
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");

        [usersForList removeAllObjects];
        
        [self selectPressed:selectButton];
    }];
}

-(void)cancelAddListPopover:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        backgroundDarkView.alpha = 0;
        listNameDialog.frame = CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width-20, 180);
        
    } completion:^(BOOL finished) {
        backgroundDarkView = nil;
        listNameDialog = nil;
        
        NSLog(@"Transition Complete");
    }];
}

-(void)AddMemberToList:(UIButton *)selectedMemberButton
{
    if ([usersForList containsObject:selectedMemberButton])
    {
        NSLog(@"Member Added To List at index %ld", (long)selectedMemberButton.tag);
        [selectedMemberButton setBackgroundImage:[UIImage imageNamed:@"Unchecked-checkbox25"] forState:UIControlStateNormal];
        
        MemberCollectionViewCell *cell = (MemberCollectionViewCell *)[[selectedMemberButton superview]superview];
        [usersForList addObject:cell.member];
        [usersForList removeObject:cell.member];
        
    }
    else
    {
        NSLog(@"Member Added To List at index %ld", (long)selectedMemberButton.tag);
        [selectedMemberButton setBackgroundImage:[UIImage imageNamed:@"Checked-checkbox25"] forState:UIControlStateNormal];
        
        if (!usersForList) {
            usersForList = [[NSMutableArray alloc]init];
        }
        MemberCollectionViewCell *cell = (MemberCollectionViewCell *)[[selectedMemberButton superview]superview];
        [usersForList addObject:cell.member];
        
     
    }
    
    
    
    
    NSLog(@"Memeber for List: %lu", (unsigned long)usersForList.count);
    
}

-(void)createList:(id)sender
{
    NSLog(@"Create List");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Creating List";
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        List * newList = [[List alloc] init];
        newList.objectId = [self randomString];
        if([PFUser currentUser] != NULL){
            newList.author = [PFUser currentUser].objectId;
        }
        newList.members = ((RLMArray<NSString *><RLMString> *)[[NSArray alloc]init]);
        for(Members * member in usersForList){
            [newList.members addObject:member.objectId];
        }
        newList.name = listNameTextField.text;
        [[RLMRealm defaultRealm] addObject:newList];
    }];
    
    [hud hideAnimated:YES];
    
    listNameTextField.text = @"";
    usersForList = nil;
    
    [self GetLists];
    [self cancelAddListPopover:self];
    [self selectPressed:selectButton];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self showHideSearchBar];
    searchBar.text = nil;
}

#pragma mark Search
-(IBAction)showHideSearchBar
{
    if (!searchBar)
    {
        searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, -56, self.view.frame.size.width, 56)];
        searchBar.delegate = self;
        searchBar.returnKeyType = UIReturnKeySearch;
        searchBar.tintColor = [UIColor redColor];
        [searchBar setShowsCancelButton:YES animated:YES];
        [self.view addSubview:searchBar];
    }
    //20
    
    if (searchBar.frame.origin.y == -56)
    {
        //Search Bar Off Screen
        
        [UIView animateWithDuration:0.4f animations:^{
            
            searchBar.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, 56);
            
        } completion:^(BOOL finished) {
            
            NSLog(@"Transition Complete");
        }];
        
        
    }
    else
    {
        //Search Bar On Screen
        
        [UIView animateWithDuration:0.4f animations:^{
            
            searchBar.frame = CGRectMake(0, -56, self.view.frame.size.width, 56);
            
        } completion:^(BOOL finished) {
            
            NSLog(@"Transition Complete");
        }];
    }
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search for: %@", searchBar.text);
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Searching";
    
    NSString *searchString = [NSString stringWithFormat:@"LastName BEGINSWITH '%@'", searchBar.text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchString];
    
    RLMResults<Members *> * results = [Members objectsWithPredicate:predicate];
    
    if(results != NULL){
        [hud hideAnimated:YES];
        if (results.count == 0)
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Results"
                                                                           message:@"We couldnt find any members matching that last name. Please try again."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            members = [[NSMutableArray alloc] init];
            for(Members * member in results){
                //Note: This if statement allows the Office staff at the BSR to have a profile that  is not listed in the mmebers table.
                if (![member.admin isEqualToString:@"YES"])
                {
                    [members addObject:member];
                }
            }
            [collectionView reloadData];
        }
    }else{
        [CrashlyticsKit recordError:@"No results from the searching"];
    }
}

#pragma MARK Filter and Search Methods
-(void)filterMembersWith:(NSMutableDictionary *)dictionary
{
    [indexesOfMembersFirstLetter removeAllObjects];
    __block NSMutableArray *results;
    NSMutableDictionary *__block blockSafeDict = dictionary;
    
    //Show Saving HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Applying Filters..";
    
    NSString * predString = [NSString stringWithFormat:@""];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Members"];
    
    NSLog(@"%@", dictionary);
    
    if ([[dictionary objectForKey:@"ProbationaryMember"] isEqualToString: @"YES"] && [[dictionary objectForKey:@"IntermediateMember"] isEqualToString: @"YES"] && [[dictionary objectForKey:@"FullMember"] isEqualToString: @"YES"])
    {
        NSLog(@"No Change");
//        [self QueryProfileWith:nil and:dictionary];
    }
    else
    {
        if ([dictionary objectForKey:@"ProbationaryMember"])
        {
            if ([[dictionary objectForKey:@"ProbationaryMember"] isEqualToString: @"YES"]) {
                if(predString.length > 0){
                    predString = [predString stringByAppendingString:@" OR "];
                }
                predString = [predString stringByAppendingString:@"MemberType = '0'"];
            }
        }
        if ([dictionary objectForKey:@"IntermediateMember"])
        {
            if ([[dictionary objectForKey:@"IntermediateMember"] isEqualToString: @"YES"]) {
                if(predString.length > 0){
                    predString = [predString stringByAppendingString:@" OR "];
                }
                predString = [predString stringByAppendingString:@"MemberType = '1'"];
                
            }
        }
        if ([dictionary objectForKey:@"FullMember"])
        {
            if ([[dictionary objectForKey:@"FullMember"] isEqualToString: @"YES"]) {
                if(predString.length > 0){
                    predString = [predString stringByAppendingString:@" OR "];
                }
                predString = [predString stringByAppendingString:@"MemberType = '2'"];
            }
        }
        
    }
        //Choose Sex
        if (type == 0)
        {
            if(![predString isEqualToString:@""]){
                predString = [predString stringByAppendingString:@" AND "];
            }
            predString = [predString stringByAppendingString:@"Sex = 'Male'"];
        }
        if(type == 1)
        {
            if(![predString isEqualToString:@""]){
                predString = [predString stringByAppendingString:@" AND "];
            }
            predString = [predString stringByAppendingString:@"Sex = 'Female'"];
        }
        if (type == 2)
        {
            //All Members (Note: Crash occured when pred string was just "")
            if([predString isEqualToString:@""])
            {
                predString = nil;
            }
            
        }
    RLMResults<Members * > *resultMembers = [[Members objectsWhere:predString] sortedResultsUsingKeyPath:@"LastName" ascending:YES];
    members = [[NSMutableArray alloc] init];
    if(resultMembers != NULL){
        for(Members * member in resultMembers){
            [members addObject:member];
        }
        if(dictionary.count > 3){
            [self QueryProfileWith:members and:dictionary];
        }else{
            [self checkLetterNavigationIndex];
            selectButton.hidden = YES;
            filterButton.hidden = YES;
            buttonSeparator.hidden = YES;
            [addToList setTitle:@"Reset Filters" forState:UIControlStateNormal];
            [addToList removeTarget:nil  action:NULL forControlEvents:UIControlEventAllEvents];
            [addToList addTarget:self action:@selector(resetFilters:) forControlEvents:UIControlEventTouchUpInside];
            addToList.hidden = NO;
            [collectionView reloadData];
            [hud hideAnimated:YES];
        }
    }else{
        [hud hideAnimated:YES];
    }
}
-(void)QueryProfileWith:(NSMutableArray *)array and:(NSMutableDictionary *)dictionary
{
    NSString * predString = [NSString stringWithFormat:@""];
    NSString * profilePredString = [NSString stringWithFormat:@""];
    if (array)
    {
        for(Members * member in array){
            if(predString.length > 0){
                predString = [predString stringByAppendingString:@" OR "];
            }
            predString = [predString stringByAppendingString:[NSString stringWithFormat:@"objectId = '%@'",member.objectId]];
        }
    }
    if ([dictionary objectForKey:@"Eye Colour"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        for(NSString * colour in [dictionary objectForKey:@"Eye Colour"]){
            if(profilePredString.length > 0 && ![[[dictionary objectForKey:@"Eye Colour"] objectAtIndex:0] isEqual:colour]){
                profilePredString = [profilePredString stringByAppendingString:@" OR "];
            }
            profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"EyeColour = '%@'",colour]];
        }
    }
    if ([dictionary objectForKey:@"Hair Colour"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        for(NSString * colour in [dictionary objectForKey:@"Hair Colour"]){
            if(profilePredString.length > 0){
                profilePredString = [profilePredString stringByAppendingString:@" OR "];
            }
            profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"HairColour = '%@'",colour]];
        }
    }
    if ([dictionary objectForKey:@"Facial Hair"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        for(NSString * colour in [dictionary objectForKey:@"Facial Hair"]){
            if(profilePredString.length > 0){
                profilePredString = [profilePredString stringByAppendingString:@" OR "];
            }
            profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"FacialHair = '%@'",colour]];
        }
    }
    if ([dictionary objectForKey:@"Chest"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Chest"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Chest"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Chest >= %@ AND Chest <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Collar"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Collar"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Collar"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Collar >= %@ AND Collar <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Hat"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Hat"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Hat"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Hat >= %@ AND Hat <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Height"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber<RLMDouble> *min = [[dictionary objectForKey:@"Height"] objectForKey:@"min"];
        NSNumber<RLMDouble> *max = [[dictionary objectForKey:@"Height"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Height >= %@ AND Height <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Hips"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Hips"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Hips"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Hips >= %@ AND Hips <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Inside Arm"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Inside Arm"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Inside Arm"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"InsideArm >= %@ AND InsideArm <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Inside Leg"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Inside Leg"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Inside Leg"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"InsideLeg >= %@ AND InsideLeg <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Shoe Size UK"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Shoe Size UK"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Shoe Size UK"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"ShoeSizeUK >= %@ AND ShoeSizeUK <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"Waist"])
    {
        if(profilePredString.length > 0){
            profilePredString = [profilePredString stringByAppendingString:@" AND "];
        }
        NSNumber *min = [[dictionary objectForKey:@"Waist"] objectForKey:@"min"];
        NSNumber *max = [[dictionary objectForKey:@"Waist"] objectForKey:@"max"];
        
        profilePredString = [profilePredString stringByAppendingString:[NSString stringWithFormat:@"Waist >= %@ AND Waist <= %@",min,max]];
    }
    if ([dictionary objectForKey:@"skills"])
    {
        //realm doesn't currently support predicates on array values :(
    }
    NSLog(@"pred:%@",predString);
    NSLog(@"profilePredString: %@",profilePredString);
    if(![profilePredString isEqualToString:@""] || [dictionary objectForKey:@"skills"]){
        RLMResults<Profile *> * profileResults;
        
        if(![profilePredString isEqualToString:@""]){
           profileResults = [Profile objectsWhere:profilePredString];
        }
        else{
            profileResults = [Profile objectsWhere:nil];
        }
        
        predString = @"";
        if(profileResults != nil){
            if(profileResults.count == 0){
                [members removeAllObjects];
            }

            for (Profile * profile in profileResults){
                
                bool containsSkill = NO;
                
                if(![dictionary objectForKey:@"skills"] || ![[dictionary objectForKey:@"skills"] count]){
                    containsSkill = YES;
                }
                else{
                    
                    for(NSString* desiredSkill in [dictionary objectForKey:@"skills"]){
                        for(NSString* profileSkill in profile.skills){
                            if([[profileSkill lowercaseString]isEqualToString:[desiredSkill lowercaseString]]){
                                containsSkill = YES;
                                break;
                            }
                        }
                    }
                }
                
                if(containsSkill){
                    if(predString.length > 0){
                        predString = [predString stringByAppendingString:@" OR "];
                    }
                    predString = [predString stringByAppendingString:[NSString stringWithFormat:@"objectId = '%@'",profile.uid]];
                }
            }
        }
    }
    if(![predString isEqualToString:@""]){
        RLMResults<Members * > * filterResults = [[Members objectsWhere:predString] sortedResultsUsingKeyPath:@"LastName" ascending:YES];
        if(filterResults != nil){
            members = [[NSMutableArray alloc] init];
            for(Members * member in filterResults){
                //Note: This if statement allows the Office staff at the BSR to have a profile that  is not listed in the mmebers table.
                if (![member.admin isEqualToString:@"YES"])
                {
                    [members addObject:member];
                }
            }
        }
    }
    
    [self checkLetterNavigationIndex];
    selectButton.hidden = YES;
    filterButton.hidden = YES;
    buttonSeparator.hidden = YES;
    [addToList setTitle:@"Reset Filters" forState:UIControlStateNormal];
    [addToList removeTarget:nil  action:NULL forControlEvents:UIControlEventAllEvents];
    [addToList addTarget:self action:@selector(resetFilters:) forControlEvents:UIControlEventTouchUpInside];
    addToList.hidden = NO;
    [collectionView reloadData];
    [hud hideAnimated:YES];
}


-(void)resetFilters:(id)sender
{

    [self getMembersForType:type];
    selectButton.hidden = NO;
    filterButton.hidden = NO;
    buttonSeparator.hidden = NO;
    addToList.hidden = YES;

    [addToList setTitle:@"Add to List" forState:UIControlStateNormal];
    [addToList addTarget:self action:@selector(addToList:) forControlEvents:UIControlEventTouchUpInside];

}

-(NSString *) randomString {
    NSMutableString * rand = [NSMutableString stringWithCapacity:10];
    for(int i = 0; i < 10; i++){
        [rand appendFormat: @"%C", [randomLetters characterAtIndex: arc4random_uniform([randomLetters length])]];
    }
    return rand;
}

@end

//switch (sender.tag)
//{
//    case 0:
//        NSLog(@"A Pressed");
//
//        break;
//    case 1:
//        NSLog(@"B Pressed");
//        break;
//    case 2:
//        NSLog(@"C Pressed");
//        break;
//    case 3:
//        NSLog(@"D Pressed");
//        break;
//    case 4:
//        NSLog(@"E Pressed");
//        break;
//    case 5:
//        NSLog(@"F Pressed");
//        break;
//    case 6:
//        NSLog(@"G Pressed");
//        break;
//    case 7:
//        NSLog(@"H Pressed");
//        break;
//    case 8:
//        NSLog(@"I Pressed");
//        break;
//    case 9:
//        NSLog(@"J Pressed");
//        break;
//    case 10:
//        NSLog(@"K Pressed");
//        break;
//    case 11:
//        NSLog(@"L Pressed");
//        break;
//    case 12:
//        NSLog(@"M Pressed");
//        break;
//    case 13:
//        NSLog(@"N Pressed");
//        break;
//    case 14:
//        NSLog(@"O Pressed");
//        break;
//    case 15:
//        NSLog(@"P Pressed");
//        break;
//    case 16:
//        NSLog(@"Q Pressed");
//        break;
//    case 17:
//        NSLog(@"R Pressed");
//        break;
//    case 18:
//        NSLog(@"S Pressed");
//        break;
//    case 19:
//        NSLog(@"T Pressed");
//        break;
//    case 20:
//        NSLog(@"U Pressed");
//        break;
//    case 21:
//        NSLog(@"V Pressed");
//        break;
//    case 22:
//        NSLog(@"W Pressed");
//        break;
//    case 23:
//        NSLog(@"X Pressed");
//        break;
//    case 24:
//        NSLog(@"Y Pressed");
//        break;
//    case 25:
//        NSLog(@"Z Pressed");
//        break;
//
//    default:
//        break;
//}
