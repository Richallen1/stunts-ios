//
//  AboutMeViewController.m
//  Stunts
//
//  Created by Richard Allen on 03/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "macros.h"
#import "EditAboutMeViewController.h"
#import "MBProgressHUD.h"

@interface EditAboutMeViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView *backgroundDarkView;
    UIView *addInfoView;
    UILabel *titleLabel;
    UIButton *saveButton;
    
    NSArray *cellLabels;
    NSMutableArray *memberInfo;
    __weak IBOutlet UITableView *aboutMeTableview;
    UIPickerView *pickerView;
    UIView *pickerContainerView;
    NSString *componentTitle;
    
    //Picker Data
    NSMutableArray *dataForPicker;
    NSMutableArray *secondDataForPicker;
    
    UILabel *unitofMeasure;
    UILabel *secondUnitOfMeasure;
    
    BOOL PickerOnScreen;
    
    PFObject *profile;
}

@end

@implementation EditAboutMeViewController
@synthesize Profile;
@synthesize member;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellLabels = [[NSArray alloc]initWithObjects:@"Eye Colour", @"Hair Colour", @"Facial Hair", @"Chest / Bust", @"Collar", @"Hat", @"Height", @"Hips", @"Inside Arm", @"Inside Leg", @"Shoe Size UK", @"Waist", @"Weight", nil];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading Profile..";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"uid" equalTo:member];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu Profiles.", (unsigned long)objects.count);
            // Do something with the found objects
            Profile = objects[0];
            [hud hideAnimated:YES];
            
            NSLog(@"%@", Profile);
            [self GetMemberInfo];
            
            NSLog(@"%lu : %lu", (unsigned long)cellLabels.count, (unsigned long)memberInfo.count);
            
            [aboutMeTableview reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];


    //Setup Popup
    backgroundDarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0.0;
    [self.view addSubview:backgroundDarkView];
    
    addInfoView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 330, 330)];
    addInfoView.backgroundColor = [UIColor whiteColor];
    addInfoView.layer.cornerRadius = 10;
    addInfoView.clipsToBounds = YES;
    
    /* Add Tittle */
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, addInfoView.frame.size.width, 50)];
    titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:24];
    titleLabel.numberOfLines = 0;
    [addInfoView addSubview:titleLabel];
    
    /******* Save Button ********/
    saveButton = [[UIButton alloc]initWithFrame:CGRectMake(47, addInfoView.frame.size.height-60, 242, 51)];
    [saveButton setImage:[UIImage imageNamed:@"save-button"] forState:UIControlStateNormal];
    saveButton.userInteractionEnabled = YES;
    [saveButton addTarget:self action:@selector(dismissInfoPopover:) forControlEvents:UIControlEventTouchUpInside];
    [addInfoView addSubview:saveButton];
    
    [self.view addSubview:addInfoView];
    
    /* Set UP Picker View */
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, addInfoView.frame.size.width, addInfoView.frame.size.height-115)];
    [pickerContainerView addSubview:pickerView];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerContainerView];
    
    dataForPicker = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetMemberInfo
{
    NSLog(@"%@", profile);
    memberInfo = [[NSMutableArray alloc]init];

    NSLog(@"%@", memberInfo);
    
    if ([Profile[@"EyeColour"] isEqualToString:@""] || (Profile[@"EyeColour"] == nil))
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"EyeColour"]];
    }
    if ([Profile[@"HairColour"] isEqualToString:@""] || Profile[@"HairColour"] == nil )
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"HairColour"]];
    }
    
    if ([Profile[@"FacialHair"] isEqualToString:@""] || Profile[@"FacialHair"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"FacialHair"]];
    }
    if ([Profile[@"Chest"] isEqualToString:@""] || Profile[@"Chest"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Chest"]];
    }
    if ([Profile[@"Collar"] isEqualToString:@""] || Profile[@"Collar"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Collar"]];
    }
    if ([Profile[@"Hat"] isEqualToString:@""] || Profile[@"Hat"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Hat"]];
    }

    
    if ([Profile[@"Height"] isKindOfClass:[NSString class]] || Profile[@"Height"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Height"]];
    }
    
    if ([Profile[@"Hips"] isEqualToString:@""] || Profile[@"Hips"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Hips"]];
    }
    
    if ([Profile[@"InsideArm"] isEqualToString:@""] || Profile[@"InsideArm"] == nil)
    {
        [memberInfo addObject:@"Select"];
        
    }
    else
    {
        [memberInfo addObject:Profile[@"InsideArm"]];
    }
    
    if ([Profile[@"InsideLeg"] isEqualToString:@""] || Profile[@"InsideLeg"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"InsideLeg"]];
    }
    
    if ([Profile[@"ShoeSizeUK"] isEqualToString:@""] || Profile[@"ShoeSizeUK"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"ShoeSizeUK"]];
    }
    
    if ([Profile[@"Waist"] isEqualToString:@""] || Profile[@"Waist"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Waist"]];
    }
    
    if ([Profile[@"Weight"] isKindOfClass:[NSString class]] || Profile[@"Weight"] == nil)
    {
        [memberInfo addObject:@"Select"];
    }
    else
    {
        [memberInfo addObject:Profile[@"Weight"]];
    }
    
    
    
}

#pragma TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellLabels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [cellLabels objectAtIndex:indexPath.row];
    cell.textLabel.font = labelFont;
    
    if ([[memberInfo objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
    {
        if ([[memberInfo objectAtIndex:indexPath.row] isEqualToString:@""])
        {
            cell.detailTextLabel.textColor = UIColorFromRGB(0x007AFF);
            cell.detailTextLabel.text = @"Select";
            return cell;
        }
        
        if ([[memberInfo objectAtIndex:indexPath.row] isEqualToString:@"Select"])
        {
            cell.detailTextLabel.textColor = UIColorFromRGB(0x007AFF);
            cell.detailTextLabel.text = @"Select";
            return cell;
        }
    }
    
    switch (indexPath.row) {
        case 0:
        {
            //Eye Color
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
        case 1:
        {
            //Hair Color
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 2:
        {
            //Facial Hair
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 3:
        {
            //Chest
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 4:
        {
            //Collar
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 5:
        {
            //Hat
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 6:
        {
            //Height
            NSMutableDictionary *heightDict;
            if ([[memberInfo objectAtIndex:indexPath.row] isKindOfClass:[NSMutableDictionary class]])
            {
                heightDict = [memberInfo objectAtIndex:indexPath.row];
            }
            else
            {
                int inches = [[memberInfo objectAtIndex:indexPath.row] intValue];
                int feet = inches / 12;
                int leftover = inches % 12;
                
                
                heightDict = [[NSMutableDictionary alloc]init];
                [heightDict setObject:[NSNumber numberWithInt:feet] forKey:@"feet"];
                [heightDict setObject:[NSNumber numberWithInt:leftover] forKey:@"inches"];
                
            }

            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ft %@in", [heightDict objectForKey:@"feet"], [heightDict objectForKey:@"inches"]];
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
        }
            break;
        case 7:
        {
            //Hips
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 8:
        {
            //Inside Arm
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 9:
        {
            //Inside Leg
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 10:
        {
            //Shoe Size
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 11:
        {
            //Waist
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
        }
            break;
        case 12:
        {
            //Weight
            NSMutableDictionary *weightDict;
            if ([[memberInfo objectAtIndex:indexPath.row] isKindOfClass:[NSMutableDictionary class]])
            {
                weightDict = [memberInfo objectAtIndex:indexPath.row];
            }
            else
            {
                int pounds = [[memberInfo objectAtIndex:indexPath.row] intValue];
                int stone = pounds / 14;
                int leftover = pounds % 14;
                
                
                weightDict = [[NSMutableDictionary alloc]init];
                [weightDict setObject:[NSNumber numberWithInt:stone] forKey:@"stone"];
                [weightDict setObject:[NSNumber numberWithInt:leftover] forKey:@"pounds"];
                
            }
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@st %@lb", [weightDict objectForKey:@"stone"], [weightDict objectForKey:@"pounds"]];
            cell.detailTextLabel.font = labelFont;
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.alpha = 0.8;
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self ShowPopoverForSelection:indexPath.row];
    
    //    [self getPickerData:indexPath.row];
    //    [self ShowAndHidePicker];
    
}

#pragma mark Popover
-(void)ShowPopoverForSelection:(int)selection
{
    if (unitofMeasure)
    {
        unitofMeasure.text = @"";
    }
    saveButton.tag = selection;
    switch (selection) {
        case 0:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Eye Color Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"Black"];
            [dataForPicker addObject:@"Blue"];
            [dataForPicker addObject:@"Blue-Green"];
            [dataForPicker addObject:@"Blue-Grey"];
            [dataForPicker addObject:@"Brown"];
            [dataForPicker addObject:@"Green"];
            [dataForPicker addObject:@"Grey"];
            [dataForPicker addObject:@"Grey-Green"];
            [dataForPicker addObject:@"Hazel"];
            [dataForPicker addObject:@"Light Blue"];
            
            titleLabel.text = @"Select Your Eye Color";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [pickerView reloadAllComponents];
            
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            
            [addInfoView addSubview:pickerView];
            
        }
            break;
        case 1:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hair Color Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"Auburn"];
            [dataForPicker addObject:@"Black"];
            [dataForPicker addObject:@"Blond"];
            [dataForPicker addObject:@"Brown"];
            [dataForPicker addObject:@"Dark Blond"];
            [dataForPicker addObject:@"Dark Brown"];
            [dataForPicker addObject:@"Fair"];
            [dataForPicker addObject:@"Grey"];
            [dataForPicker addObject:@"Greying"];
            [dataForPicker addObject:@"Medium Blond"];
            [dataForPicker addObject:@"Sandy"];
            [dataForPicker addObject:@"Titain"];
            [dataForPicker addObject:@"White"];
            
            titleLabel.text = @"Select Your Hair Color";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [pickerView reloadAllComponents];
            NSLog(@"%@ - %@", [memberInfo objectAtIndex:selection], [[memberInfo objectAtIndex:selection] class]);
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
        }
            break;
        case 2:
        {
            [secondDataForPicker removeAllObjects];
            [secondUnitOfMeasure removeFromSuperview];
            
            //Facial Hair Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"None"];
            [dataForPicker addObject:@"Beard"];
            [dataForPicker addObject:@"Clean Shaven"];
            [dataForPicker addObject:@"Full Set"];
            [dataForPicker addObject:@"Goatee"];
            [dataForPicker addObject:@"Moustache"];
            [dataForPicker addObject:@"Side Burns"];
            
            
            titleLabel.text = @"Select Your Facial Hair";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
        }
            break;
        case 3:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Chest Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"30"];
            [dataForPicker addObject:@"31"];
            [dataForPicker addObject:@"32"];
            [dataForPicker addObject:@"33"];
            [dataForPicker addObject:@"34"];
            [dataForPicker addObject:@"35"];
            [dataForPicker addObject:@"36"];
            [dataForPicker addObject:@"37"];
            [dataForPicker addObject:@"38"];
            [dataForPicker addObject:@"39"];
            [dataForPicker addObject:@"40"];
            [dataForPicker addObject:@"41"];
            [dataForPicker addObject:@"42"];
            [dataForPicker addObject:@"43"];
            [dataForPicker addObject:@"44"];
            [dataForPicker addObject:@"45"];
            [dataForPicker addObject:@"46"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            titleLabel.text = @"Select Your Chest / Bust Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }
            break;
        case 4:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Collar Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"14"];
            [dataForPicker addObject:@"14.5"];
            [dataForPicker addObject:@"15"];
            [dataForPicker addObject:@"15.5"];
            [dataForPicker addObject:@"16"];
            [dataForPicker addObject:@"16.5"];
            [dataForPicker addObject:@"17"];
            [dataForPicker addObject:@"17.5"];
            [dataForPicker addObject:@"18"];
            [dataForPicker addObject:@"18.5"];
            [dataForPicker addObject:@"19"];
            [dataForPicker addObject:@"19.5"];
            [dataForPicker addObject:@"20"];
            [dataForPicker addObject:@"20.5"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Colar Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 5:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hat Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"12"];
            [dataForPicker addObject:@"13"];
            [dataForPicker addObject:@"14"];
            [dataForPicker addObject:@"15"];
            [dataForPicker addObject:@"16"];
            [dataForPicker addObject:@"17"];
            [dataForPicker addObject:@"18"];
            [dataForPicker addObject:@"19"];
            [dataForPicker addObject:@"20"];
            [dataForPicker addObject:@"21"];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            [dataForPicker addObject:@"28"];
            [dataForPicker addObject:@"29"];
            [dataForPicker addObject:@"30"];
            [dataForPicker addObject:@"31"];
            [dataForPicker addObject:@"32"];
            [dataForPicker addObject:@"33"];
            [dataForPicker addObject:@"34"];
            
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Hat Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 6:
        {
            //Height Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"2"];
            [dataForPicker addObject:@"3"];
            [dataForPicker addObject:@"4"];
            [dataForPicker addObject:@"5"];
            [dataForPicker addObject:@"6"];
            [dataForPicker addObject:@"7"];
            [dataForPicker addObject:@"8"];
            [dataForPicker addObject:@"9"];
            
            if (!secondDataForPicker) {
                secondDataForPicker = [[NSMutableArray alloc]init];
            }
            [secondDataForPicker removeAllObjects];
            [secondDataForPicker addObject:@"1"];
            [secondDataForPicker addObject:@"2"];
            [secondDataForPicker addObject:@"3"];
            [secondDataForPicker addObject:@"4"];
            [secondDataForPicker addObject:@"5"];
            [secondDataForPicker addObject:@"6"];
            [secondDataForPicker addObject:@"7"];
            [secondDataForPicker addObject:@"8"];
            [secondDataForPicker addObject:@"9"];
            [secondDataForPicker addObject:@"10"];
            [secondDataForPicker addObject:@"11"];
            [secondDataForPicker addObject:@"12"];
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isKindOfClass:[NSString class]])
            {
                int inches = [[memberInfo objectAtIndex:selection] intValue];
                int feet = inches / 12;
                int leftover = inches % 12;
                [pickerView selectRow:[dataForPicker indexOfObject:[NSString stringWithFormat:@"%d", feet]] inComponent:0 animated:YES];
                [pickerView selectRow:[secondDataForPicker indexOfObject:[NSString stringWithFormat:@"%d",leftover]] inComponent:1 animated:YES];
            }
            
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            unitofMeasure.frame = CGRectMake(0, 60, addInfoView.frame.size.width/3, 50);
            unitofMeasure.text = @"Feet";
            
            if (!secondUnitOfMeasure) {
                secondUnitOfMeasure = [[UILabel alloc]initWithFrame:CGRectMake(addInfoView.frame.size.width - (addInfoView.frame.size.width/3), 60, addInfoView.frame.size.width/3, 50)];
                secondUnitOfMeasure.backgroundColor = [UIColor whiteColor];
                secondUnitOfMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
                secondUnitOfMeasure.textAlignment = NSTextAlignmentCenter;
            }
            secondUnitOfMeasure.text = @"Inches";
            
            
            [addInfoView addSubview:unitofMeasure];
            [addInfoView addSubview:secondUnitOfMeasure];
            
            titleLabel.text = @"Select Your Height";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 7:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hips
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"18"];
            [dataForPicker addObject:@"19"];
            [dataForPicker addObject:@"20"];
            [dataForPicker addObject:@"21"];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            [dataForPicker addObject:@"28"];
            [dataForPicker addObject:@"29"];
            [dataForPicker addObject:@"30"];
            [dataForPicker addObject:@"31"];
            [dataForPicker addObject:@"32"];
            [dataForPicker addObject:@"33"];
            [dataForPicker addObject:@"34"];
            [dataForPicker addObject:@"35"];
            [dataForPicker addObject:@"36"];
            [dataForPicker addObject:@"37"];
            [dataForPicker addObject:@"38"];
            [dataForPicker addObject:@"39"];
            [dataForPicker addObject:@"40"];
            [dataForPicker addObject:@"41"];
            [dataForPicker addObject:@"42"];
            [dataForPicker addObject:@"43"];
            [dataForPicker addObject:@"44"];
            [dataForPicker addObject:@"45"];
            [dataForPicker addObject:@"46"];
            [dataForPicker addObject:@"47"];
            [dataForPicker addObject:@"48"];
            [dataForPicker addObject:@"49"];
            [dataForPicker addObject:@"50"];
            [dataForPicker addObject:@"51"];
            [dataForPicker addObject:@"52"];
            [dataForPicker addObject:@"53"];
            [dataForPicker addObject:@"54"];
            [dataForPicker addObject:@"55"];
            [dataForPicker addObject:@"56"];
            [dataForPicker addObject:@"57"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Hip Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }
            break;
        case 8:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            
            //Inside Arm
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"18"];
            [dataForPicker addObject:@"19"];
            [dataForPicker addObject:@"21"];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Inside Arm Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 9:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Inside Leg
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            [dataForPicker addObject:@"28"];
            [dataForPicker addObject:@"29"];
            [dataForPicker addObject:@"30"];
            [dataForPicker addObject:@"31"];
            [dataForPicker addObject:@"32"];
            [dataForPicker addObject:@"33"];
            [dataForPicker addObject:@"34"];
            [dataForPicker addObject:@"35"];
            [dataForPicker addObject:@"36"];
            [dataForPicker addObject:@"37"];
            [dataForPicker addObject:@"38"];
            [dataForPicker addObject:@"39"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Inside Leg Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 10:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Shoe Size
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"2"];
            [dataForPicker addObject:@"3"];
            [dataForPicker addObject:@"4"];
            [dataForPicker addObject:@"5"];
            [dataForPicker addObject:@"6"];
            [dataForPicker addObject:@"7"];
            [dataForPicker addObject:@"8"];
            [dataForPicker addObject:@"9"];
            [dataForPicker addObject:@"10"];
            [dataForPicker addObject:@"11"];
            [dataForPicker addObject:@"12"];
            [dataForPicker addObject:@"13"];
            [dataForPicker addObject:@"14"];
            [dataForPicker addObject:@"15"];
            [dataForPicker addObject:@"16"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Shoe Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 11:
        {
            
            [secondUnitOfMeasure removeFromSuperview];
            
            //Waist
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            [dataForPicker addObject:@"28"];
            [dataForPicker addObject:@"29"];
            [dataForPicker addObject:@"30"];
            [dataForPicker addObject:@"31"];
            [dataForPicker addObject:@"32"];
            [dataForPicker addObject:@"33"];
            [dataForPicker addObject:@"34"];
            [dataForPicker addObject:@"35"];
            [dataForPicker addObject:@"36"];
            [dataForPicker addObject:@"37"];
            [dataForPicker addObject:@"38"];
            [dataForPicker addObject:@"39"];
            [dataForPicker addObject:@"40"];
            [dataForPicker addObject:@"41"];
            [dataForPicker addObject:@"42"];
            [dataForPicker addObject:@"43"];
            [dataForPicker addObject:@"44"];
            [dataForPicker addObject:@"45"];
            [dataForPicker addObject:@"46"];
            [dataForPicker addObject:@"47"];
            [dataForPicker addObject:@"48"];
            [dataForPicker addObject:@"49"];
            [dataForPicker addObject:@"50"];
            [dataForPicker addObject:@"51"];
            [dataForPicker addObject:@"52"];
            
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isEqualToString:@"Select"]) {
                [pickerView selectRow:[dataForPicker indexOfObject:[memberInfo objectAtIndex:selection]] inComponent:0 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
            
            
            titleLabel.text = @"Select Your Waist Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 12:
        {
            //Weight Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@"4"];
            [dataForPicker addObject:@"5"];
            [dataForPicker addObject:@"6"];
            [dataForPicker addObject:@"7"];
            [dataForPicker addObject:@"8"];
            [dataForPicker addObject:@"9"];
            [dataForPicker addObject:@"10"];
            [dataForPicker addObject:@"11"];
            [dataForPicker addObject:@"12"];
            [dataForPicker addObject:@"13"];
            [dataForPicker addObject:@"14"];
            [dataForPicker addObject:@"15"];
            [dataForPicker addObject:@"16"];
            [dataForPicker addObject:@"17"];
            [dataForPicker addObject:@"18"];
            [dataForPicker addObject:@"19"];
            [dataForPicker addObject:@"20"];
            
            if (!secondDataForPicker) {
                secondDataForPicker = [[NSMutableArray alloc]init];
            }
            [secondDataForPicker removeAllObjects];
            [secondDataForPicker addObject:@"0"];
            [secondDataForPicker addObject:@"1"];
            [secondDataForPicker addObject:@"2"];
            [secondDataForPicker addObject:@"3"];
            [secondDataForPicker addObject:@"4"];
            [secondDataForPicker addObject:@"5"];
            [secondDataForPicker addObject:@"6"];
            [secondDataForPicker addObject:@"7"];
            [secondDataForPicker addObject:@"8"];
            [secondDataForPicker addObject:@"9"];
            [secondDataForPicker addObject:@"10"];
            [secondDataForPicker addObject:@"11"];
            [secondDataForPicker addObject:@"12"];
            [secondDataForPicker addObject:@"13"];
            
            [pickerView reloadAllComponents];
            if (![[memberInfo objectAtIndex:selection] isKindOfClass:[NSString class]])
            {
                int pounds = [[memberInfo objectAtIndex:selection] intValue];
                int stone = pounds / 14;
                int leftover = pounds % 14;
                [pickerView selectRow:[dataForPicker indexOfObject:[NSString stringWithFormat:@"%d", stone]] inComponent:0 animated:YES];
                [pickerView selectRow:[secondDataForPicker indexOfObject:[NSString stringWithFormat:@"%d",leftover]] inComponent:1 animated:YES];
            }
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
            unitofMeasure.frame = CGRectMake(0, 60, addInfoView.frame.size.width/3, 50);
            unitofMeasure.text = @"Stone";
            
            if (!secondUnitOfMeasure) {
                secondUnitOfMeasure = [[UILabel alloc]initWithFrame:CGRectMake(addInfoView.frame.size.width - (addInfoView.frame.size.width/3), 60, addInfoView.frame.size.width/3, 50)];
                secondUnitOfMeasure.backgroundColor = [UIColor whiteColor];
                secondUnitOfMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
                secondUnitOfMeasure.textAlignment = NSTextAlignmentCenter;
            }
            secondUnitOfMeasure.text = @"Pounds";
            
            
            [addInfoView addSubview:unitofMeasure];
            [addInfoView addSubview:secondUnitOfMeasure];
            
            titleLabel.text = @"Select Your Weight";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        backgroundDarkView.alpha = 0.4;
        addInfoView.frame = CGRectMake(20, self.view.frame.size.height/2-165, 330, 330);
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
    
    
}

-(void)dismissInfoPopover:(UIButton *)sender
{
    unitofMeasure.frame = CGRectMake(0 , 60, addInfoView.frame.size.width, 50);
    
    
    switch (sender.tag) {
        case 0:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 1:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 2:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 3:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 4:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 5:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
            break;
        }
        case 6:
        {
            NSMutableDictionary *heightDict = [[NSMutableDictionary alloc]init];
            [heightDict setObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]] forKey:@"feet"];
            [heightDict setObject:[secondDataForPicker objectAtIndex:[pickerView selectedRowInComponent:1]] forKey:@"inches"];
            [memberInfo replaceObjectAtIndex:sender.tag withObject:heightDict];
            [aboutMeTableview reloadData];
            [secondDataForPicker removeAllObjects];
            secondDataForPicker = nil;
        }
            break;
        case 7:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 8:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 9:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 10:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 11:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 12:
        {
            NSMutableDictionary *weightDict = [[NSMutableDictionary alloc]init];
            [weightDict setObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]] forKey:@"stone"];
            [weightDict setObject:[secondDataForPicker objectAtIndex:[pickerView selectedRowInComponent:1]] forKey:@"pounds"];
            [memberInfo replaceObjectAtIndex:sender.tag withObject:weightDict];
            [aboutMeTableview reloadData];
            [secondDataForPicker removeAllObjects];
            secondDataForPicker = nil;
        }
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.4f animations:^{
        
        backgroundDarkView.alpha = 0.0;
        addInfoView.frame = CGRectMake(20, self.view.frame.size.height, 330, 330);
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
    
}

#pragma PICKER DELEGATE
// The number of columns of data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (secondDataForPicker)
        return 2;
    return 1;
}

// The number of rows of data
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return dataForPicker.count;
    
    return secondDataForPicker.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        return [dataForPicker objectAtIndex:row];
    return [secondDataForPicker objectAtIndex:row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        NSLog(@"Wheel 1: %@", [dataForPicker objectAtIndex:row]);
    }
    else
    {
        NSLog(@"Wheel 2: %@", [secondDataForPicker objectAtIndex:row]);
    }
    
}

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
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:@"We have hit an error. Please try again later or contact info@thebritishstuntregister.com"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                          
                                                                          
                                                                      }];
                
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return ;
            }
            profile = objects[0];
            
            profile[@"uid"] = member;
            
            for (int i = 0; i < memberInfo.count; i++)
            {
                NSString *columnName = [[cellLabels objectAtIndex:i] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                //Height
                if ([[memberInfo objectAtIndex:i] isKindOfClass:[NSString class]])
                {
                    if ([[memberInfo objectAtIndex:i] isEqualToString:@"Select"])
                    {
                        if (i == 6)
                        {
                            
                        }
                        else if (i == 12)
                        {
                            
                        }
                        else
                        {
                            profile[columnName] = @"";
                        }
                    }
                    else
                    {
                        profile[columnName] = [memberInfo objectAtIndex:i];
                    }
                }
                else
                {
                    
                    //Not NSString
                    if (i == 6)
                    {
                        if ([[memberInfo objectAtIndex:6] isKindOfClass:[NSMutableDictionary class]])
                        {
                            //Height
                            NSMutableDictionary *heightDict = [memberInfo objectAtIndex:6];
                            
                            NSLog(@"%@", [memberInfo objectAtIndex:6]);
                            
//                            float feetInInches = [[heightDict objectForKey:@"feet"] intValue]*12;
//                            float totalInches = [[heightDict objectForKey:@"inches"] intValue]+feetInInches;
//
//                            [memberInfo replaceObjectAtIndex:6 withObject:[NSNumber numberWithFloat:totalInches]];
//                            profile[columnName] = [NSNumber numberWithFloat:totalInches];
                            
                            
                            //Centemeters
                            
                            double feet = [[heightDict objectForKey:@"feet"] doubleValue];
                            double inches = [[heightDict objectForKey:@"inches"] doubleValue];
                          
                            
                            if (inches > 9)
                            {
                                inches = inches / 100;
                            }
                            else
                            {
                                inches = inches / 10;
                            }
                            
                            double totalInches = (feet+inches)*12;
                            
                            profile[@"Height"] = [NSNumber numberWithDouble:totalInches];
                            
                            double CM = totalInches*2.54;
                            
                            NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
                            [fmt setPositiveFormat:@"0.##"];
                            NSLog(@"%@", [fmt stringFromNumber:[NSNumber numberWithDouble:CM]]);
                            
                            
                            profile[@"heightCM"] = [NSNumber numberWithDouble:CM];
                            
                            
                        }
                        else
                        {
                            profile[columnName] = [memberInfo objectAtIndex:6];
                        }
                        
                    }
                    else if (i == 12)
                    {
                        if ([[memberInfo objectAtIndex:12] isKindOfClass:[NSMutableDictionary class]])
                        {
                            //Weight
                            NSMutableDictionary *weightDict = [memberInfo objectAtIndex:12];
                            
                            
                            float stonesInPounds = [[weightDict objectForKey:@"stone"] intValue]*14;
                            float totalPounds = [[weightDict objectForKey:@"pounds"] intValue]+stonesInPounds;
                            
                            [memberInfo replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat:totalPounds]];
                            
                            profile[columnName] = [NSNumber numberWithFloat:totalPounds];
                        }
                        else
                        {
                            profile[columnName] = [memberInfo objectAtIndex:12];
                        }
                        }
                        
                }
            }
            
            [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Profile Saved Successfully");
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Updated"
                                                                                   message:@"We have updated your information. This will show after the next app update."
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {
                                                                              
                                                                              [self.navigationController popViewControllerAnimated:YES];
                                                                          }];
                    
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                } else {
                    // There was a problem, check error.description
                    NSLog(@"Error: %ld - Description:%@", (long)error.code, error.description);
                }
            }];
            
        } else {
            // Log details of the failure
            NSLog(@"Error Getting Profile: %@ %@", error, [error userInfo]);
            
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"skills_segue"])
    {
        
//        OnboardingSkillsViewController *vc = segue.destinationViewController;
//        vc.profile = profile;
    }
}

-(void)performSaveOperation
{
    
    
}

@end
