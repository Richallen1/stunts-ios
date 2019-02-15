//
//  AboutMeViewController.m
//  Stunts
//
//  Created by Richard Allen on 09/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "AppImports.h"
#import "AboutMeViewController.h"
#import <Parse/Parse.h>
#import "OnboardingSkillsViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "WeightPopoverController.h"
#import "MBProgressHUD.h"

@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
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
    
    WeightPopoverController *popoverViewController;
}
@end

@implementation AboutMeViewController
@synthesize profile;


- (void)viewDidLoad {
    [super viewDidLoad];
    cellLabels = [[NSArray alloc]initWithObjects:@"Eye Colour", @"Hair Length", @"Hair Colour", @"Facial Hair", @"Chest", @"Collar", @"Hat", @"Height", @"Hips", @"Inside Arm", @"Inside Leg", @"Shoe Size UK", @"Waist", @"Weight", nil];
    
    memberInfo = [[NSMutableArray alloc]initWithObjects:@"Select", @"Select",@"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", @"Select", nil];
    
    
    //Setup Popup
    backgroundDarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0.0;
    [self.view addSubview:backgroundDarkView];
    
    addInfoView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height, 330, 330)];
    addInfoView.backgroundColor = [UIColor whiteColor];
    addInfoView.layer.cornerRadius = 10;
    addInfoView.clipsToBounds = YES;
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 12, 40, 40)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(CloseCreditView:) forControlEvents:UIControlEventTouchUpInside];
    [addInfoView addSubview:closeButton];
    
    /* Add Tittle */
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, addInfoView.frame.size.width-50, 50)];
    titleLabel.numberOfLines = 1;
    titleLabel.minimumFontSize = 8;
    titleLabel.adjustsFontSizeToFitWidth = YES;
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
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 1:
            {
                //Hair Length
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 2:
            {
                //Hair Color
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 3:
            {
                //Facial Hair
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 4:
            {
                //Chest
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 5:
            {
                //Collar
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 6:
            {
                //Hat
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 7:
            {
                //Height
                NSMutableDictionary *heightDict = [memberInfo objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ft %@in", [heightDict objectForKey:@"feet"], [heightDict objectForKey:@"inches"]];
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
            }
                break;
            case 8:
            {
                //Hips
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 9:
            {
                //Inside Arm
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 10:
            {
                //Inside Leg
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@in", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 11:
            {
                //Shoe Size
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 12:
            {
                //Waist
                cell.detailTextLabel.font = labelFont;
                cell.detailTextLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.alpha = 0.8;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [memberInfo objectAtIndex:indexPath.row]];
            }
                break;
            case 13:
            {
                //Weight
                NSMutableDictionary *weightDict = [memberInfo objectAtIndex:indexPath.row];
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
-(void)CloseCreditView:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        backgroundDarkView.alpha = 0.0;
        addInfoView.frame = CGRectMake(20, self.view.frame.size.height, 330, 330);
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
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
            [addInfoView addSubview:pickerView];

        }
            break;
        case 1:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hair Length Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
            [dataForPicker addObject:@"Bald"];
            [dataForPicker addObject:@"Balding"];
            [dataForPicker addObject:@"Shaved"];
            [dataForPicker addObject:@"Short"];
            [dataForPicker addObject:@"Mid Length"];
            [dataForPicker addObject:@"Long"];
            
            titleLabel.text = @"Select Your Hair Length";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [pickerView reloadAllComponents];
            [addInfoView addSubview:pickerView];
        }
            break;
        case 2:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hair Color Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
            [addInfoView addSubview:pickerView];
        }
            break;
        case 3:
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
            [addInfoView addSubview:pickerView];
        }
            break;
        case 4:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Chest Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
            [addInfoView addSubview:pickerView];
            
            if (!unitofMeasure) {
                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
                unitofMeasure.backgroundColor = [UIColor whiteColor];
                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:25];
                unitofMeasure.textAlignment = NSTextAlignmentCenter;
            }
        
            unitofMeasure.text = @"Inches";
            
            [addInfoView addSubview:unitofMeasure];
  
            titleLabel.text = @"Select Your Chest Size";
            titleLabel.textAlignment = NSTextAlignmentCenter;

        }
            break;
        case 5:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Collar Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
        case 6:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hat Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
            [dataForPicker addObject:@"21"];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            
            
            
            [pickerView reloadAllComponents];
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
        case 7:
        {
            //Height Mesure Picker
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
            [secondDataForPicker addObject:@""];
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
            
            titleLabel.text = @"Enter Your Height";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 8:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Hips
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
        case 9:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            
            //Inside Arm
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
            [dataForPicker addObject:@"21"];
            [dataForPicker addObject:@"22"];
            [dataForPicker addObject:@"23"];
            [dataForPicker addObject:@"24"];
            [dataForPicker addObject:@"25"];
            [dataForPicker addObject:@"26"];
            [dataForPicker addObject:@"27"];
            
            [pickerView reloadAllComponents];
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
        case 10:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            //Inside Leg
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
        case 11:
        {
            [secondUnitOfMeasure removeFromSuperview];
            
            
            //Shoe Size
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
        case 12:
        {
            
            [secondUnitOfMeasure removeFromSuperview];
            
            //Waist 
            [dataForPicker removeAllObjects];
            [dataForPicker addObject:@""];
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
        case 13:
        {
            [self ShowWeightPopover];
            return;
//            //Weight Mesure Picker
//            [dataForPicker removeAllObjects];
//            [dataForPicker addObject:@"4"];
//            [dataForPicker addObject:@"5"];
//            [dataForPicker addObject:@"6"];
//            [dataForPicker addObject:@"7"];
//            [dataForPicker addObject:@"8"];
//            [dataForPicker addObject:@"9"];
//            [dataForPicker addObject:@"10"];
//            [dataForPicker addObject:@"11"];
//            [dataForPicker addObject:@"12"];
//            [dataForPicker addObject:@"13"];
//            [dataForPicker addObject:@"14"];
//            [dataForPicker addObject:@"15"];
//            [dataForPicker addObject:@"16"];
//            [dataForPicker addObject:@"17"];
//            [dataForPicker addObject:@"18"];
//            [dataForPicker addObject:@"19"];
//            [dataForPicker addObject:@"20"];
//
//
//
//
//            if (!secondDataForPicker) {
//                secondDataForPicker = [[NSMutableArray alloc]init];
//            }
//            [secondDataForPicker removeAllObjects];
//            [secondDataForPicker addObject:@"0"];
//            [secondDataForPicker addObject:@"1"];
//            [secondDataForPicker addObject:@"2"];
//            [secondDataForPicker addObject:@"3"];
//            [secondDataForPicker addObject:@"4"];
//            [secondDataForPicker addObject:@"5"];
//            [secondDataForPicker addObject:@"6"];
//            [secondDataForPicker addObject:@"7"];
//            [secondDataForPicker addObject:@"8"];
//            [secondDataForPicker addObject:@"9"];
//            [secondDataForPicker addObject:@"10"];
//            [secondDataForPicker addObject:@"11"];
//            [secondDataForPicker addObject:@"12"];
//            [secondDataForPicker addObject:@"13"];
//
//            [pickerView reloadAllComponents];
//            [addInfoView addSubview:pickerView];
//
//            if (!unitofMeasure) {
//                unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(0 , 60, addInfoView.frame.size.width, 50)];
//                unitofMeasure.backgroundColor = [UIColor whiteColor];
//                unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
//                unitofMeasure.textAlignment = NSTextAlignmentCenter;
//            }
//            unitofMeasure.frame = CGRectMake(0, 60, addInfoView.frame.size.width/3, 50);
//            unitofMeasure.text = @"Stone";
//
//            if (!secondUnitOfMeasure) {
//                secondUnitOfMeasure = [[UILabel alloc]initWithFrame:CGRectMake(addInfoView.frame.size.width - (addInfoView.frame.size.width/3), 60, addInfoView.frame.size.width/3, 50)];
//                secondUnitOfMeasure.backgroundColor = [UIColor whiteColor];
//                secondUnitOfMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
//                secondUnitOfMeasure.textAlignment = NSTextAlignmentCenter;
//            }
//            secondUnitOfMeasure.text = @"Pounds";
//
//
//            [addInfoView addSubview:unitofMeasure];
//            [addInfoView addSubview:secondUnitOfMeasure];
//
//            titleLabel.text = @"Select Your Weight";
//            titleLabel.textAlignment = NSTextAlignmentCenter;
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
        }
            break;
        case 6:
        {
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
            break;
        }
        case 7:
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
            [memberInfo replaceObjectAtIndex:sender.tag withObject:[dataForPicker objectAtIndex:[pickerView selectedRowInComponent:0]]];
            [aboutMeTableview reloadData];
        }
            break;
        case 13:
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
    [UIView animateWithDuration:0.4f animations:^
    {
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
-(void)ShowWeightPopover
{
    if(popoverViewController == nil) {
        popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeightPopover"];
        
    }
    popoverViewController.parent = self;
    popoverViewController.preferredContentSize = CGSizeMake(330, 330);
    popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popoverController = popoverViewController.popoverPresentationController;
    popoverController.permittedArrowDirections = nil;
    popoverController.delegate = self;
    popoverController.sourceView = self.view;
    popoverController.sourceRect = [self.view frame];
    
    [self presentViewController:popoverViewController animated:YES completion:nil];
}
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

-(void)updateWeight:(int)unit1 and:(int)unit2 inUnits:(UnitsOfMeasure)units
{
    [popoverViewController dismissViewControllerAnimated:YES completion:nil];
    switch (units) {
        case Imperial:
        {
            NSLog(@"%d st %d lb", unit1, unit2);
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:[NSNumber numberWithInt:unit1] forKey:@"stone"];
            [dict setObject:[NSNumber numberWithInt:unit2] forKey:@"pounds"];
            [memberInfo replaceObjectAtIndex:13 withObject:dict];
            [aboutMeTableview reloadData];
        }
            break;
        case Metric:
        {
            NSLog(@"%d kg %d g", unit1, unit2);
            float kg = unit1;
            float g = unit2;
            float kgsInG = kg*1000;
            float totalG = kgsInG+g;
            float totalKG = totalG/1000;
            NSMutableDictionary *weightDict = [self convertWeightMetricToImperial:totalKG];
            [memberInfo replaceObjectAtIndex:13 withObject:weightDict];
            [aboutMeTableview reloadData];
        }
            break;
            
        default:
            break;
    }
}
-(NSMutableDictionary *)convertWeightMetricToImperial:(float)kgs
{
    float stone  = kgs/6.35029318;
    int st = stone;
    float remainder = stone - st;
    int pounds = remainder*14;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSNumber numberWithInt:st] forKey:@"stone"];
    [dict setObject:[NSNumber numberWithInt:pounds] forKey:@"pounds"];
    return dict;
}
-(IBAction)Next:(UIButton *)sender
{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"Saving Details";
    
            sender.userInteractionEnabled = NO;
    
            for (int i = 0; i < memberInfo.count; i++)
            {
                NSString *columnName = [[cellLabels objectAtIndex:i] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                //Height
                if ([[memberInfo objectAtIndex:i] isKindOfClass:[NSString class]])
                {
                    if ([[memberInfo objectAtIndex:i] isEqualToString:@"Select"])
                    {
                        if (i == 7)
                        {
                            
                        }
                        else if (i == 13)
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
                    if (i == 7)
                    {
                        //Height
                        NSMutableDictionary *heightDict = [memberInfo objectAtIndex:7];
                        
                        float feetInInches = [[heightDict objectForKey:@"feet"] intValue]*12;
                        float totalInches = [[heightDict objectForKey:@"inches"] intValue]+feetInInches;
                        
                        [memberInfo replaceObjectAtIndex:6 withObject:[NSNumber numberWithFloat:totalInches]];
                        profile[columnName] = [NSNumber numberWithFloat:totalInches];
                        
                    }
                    else if (i == 13)
                    {
                        //Weight
                        NSMutableDictionary *weightDict = [memberInfo objectAtIndex:13];
                        
                        
                        float stonesInPounds = [[weightDict objectForKey:@"stone"] intValue]*14;
                        float totalPounds = [[weightDict objectForKey:@"pounds"] intValue]+stonesInPounds;
                        
                        [memberInfo replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat:totalPounds]];
                        
                        profile[columnName] = [NSNumber numberWithFloat:totalPounds];
                    }
                }
            }
            
            [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Profile Saved Successfully");
                    [hud hideAnimated:YES];
                     sender.userInteractionEnabled = NO;
                    [PFUser currentUser][@"Onboarding_About"] = [NSNumber numberWithBool:YES];
                    [[PFUser currentUser] saveInBackground];
                    [self performSegueWithIdentifier:@"skills_segue" sender:self];
                } else {
                    // There was a problem, check error.description
                    [CrashlyticsKit recordError:error];
                    [hud hideAnimated:YES];
                     sender.userInteractionEnabled = NO;
                    NSLog(@"Error: %ld - Description:%@", (long)error.code, error.description);
                }
            }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"skills_segue"])
    {
        OnboardingSkillsViewController *vc = segue.destinationViewController;
        vc.profile = profile;
    }
}



@end
