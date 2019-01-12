//
//  PhysicalDescriptionViewController.m
//  Stunts
//
//  Created by Richard Allen on 21/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//
#import "macros.h"
#import "AppImports.h"
#import "PhysicalDescriptionViewController.h"
#import "PhysicalDescriptionCategoryViewController.h"
#import "TTRangeSlider.h"
#import "SliderTableViewCell.h"


@interface PhysicalDescriptionViewController ()<UITableViewDelegate, UITableViewDataSource, TTRangeSliderDelegate>
{
    IBOutlet UITableView *physicalDescriptionTableView;
    
    UIView *backgroundDarkView;
    UIView *sliderView;
    UILabel *titleLabel;
    UILabel *unitsLabel;
    UILabel *infoLabel;
    UIButton *doneButton;
    TTRangeSlider *slider;
    
    
    NSArray *cellLabels;

    NSString *selectedCategory;
    UnitsOfMeasure *measureUnits;
    UIButton *unitsOfMeasureBTN;
    
    NSString *categoryTitle;
}
@end

@implementation PhysicalDescriptionViewController
@synthesize physicalFilterSelections;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    cellLabels = [[NSArray alloc]initWithObjects:@"Eye Colour",@"Hair Length",  @"Hair Colour", @"Facial Hair", @"Height", @"Collar", @"Hat", @"Chest", @"Hips", @"Inside Arm", @"Inside Leg", @"Shoe Size UK", @"Waist", @"Weight", nil];
    
    physicalFilterSelections = [[NSMutableDictionary alloc]init];
    
    NSLog(@"%@", parent);
    
    measureUnits = Imperial;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellLabels count];
}


#pragma mark TableView Data Source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [cellLabels objectAtIndex:indexPath.row];
    cell.textLabel.font = labelFont;
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedCategory = [cellLabels objectAtIndex:indexPath.row];
    
    if (indexPath.row <= 3)
    {
        [self performSegueWithIdentifier:@"show-filter-category" sender:self];
        return;
    }

        [self ShowPopoverForCategory:indexPath.row];
    
    
}

-(void)ShowPopoverForCategory:(int)category
{
    
    
    if (!backgroundDarkView) {
        backgroundDarkView = [[UIView alloc]initWithFrame:self.view.frame];
        backgroundDarkView.backgroundColor = [UIColor blackColor];
        backgroundDarkView.alpha = 0;
        [self.view addSubview:backgroundDarkView];
    }
    if (!sliderView)
    {
        sliderView = [[UIView alloc]initWithFrame:CGRectMake(25, self.view.bounds.size.height, self.view.bounds.size.width-50, 300)];
        sliderView.backgroundColor = [UIColor whiteColor];
        sliderView.layer.cornerRadius = 25;
        sliderView.clipsToBounds = YES;
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, sliderView.frame.size.width-10, 40)];
        titleLabel.font = [UIFont fontWithName:@"SFProText-Bold" size:35];
        titleLabel.textColor = [UIColor blackColor];
        [sliderView addSubview:titleLabel];
        
        /* Units Of Measure Button*/
        unitsOfMeasureBTN = [[UIButton alloc]initWithFrame:CGRectMake(sliderView.frame.size.width-160, 50, 150, 40)];
        [unitsOfMeasureBTN setTitle:@"Switch to Metric" forState:UIControlStateNormal];
        [unitsOfMeasureBTN setTitleColor:UIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
        [unitsOfMeasureBTN addTarget:self action:@selector(switchUnitsOfMeasure:) forControlEvents:UIControlEventTouchUpInside];
        unitsOfMeasureBTN.font = [UIFont systemFontOfSize:12];
        [sliderView addSubview:unitsOfMeasureBTN];
        
        UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
        infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 75, sliderView.frame.size.width-50, 50)];
        infoLabel.numberOfLines = 0;
        infoLabel.text = @"Choose your minimum and maximum values.";
        infoLabel.font = labelFont;
        infoLabel.alpha = 0.6;
        [sliderView addSubview:infoLabel];
        
        unitsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, sliderView.frame.size.width, 40)];
        unitsLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
        unitsLabel.alpha = 0.4;
        unitsLabel.textAlignment = NSTextAlignmentCenter;
        unitsLabel.textColor = [UIColor blackColor];
        [sliderView addSubview:unitsLabel];
        

        doneButton = [[UIButton alloc]initWithFrame:CGRectMake(sliderView.frame.size.width/2-150, sliderView.frame.size.height-70, 300, 60)];
        [doneButton setImage:[UIImage imageNamed:@"Done-Button"] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneSliderChange:) forControlEvents:UIControlEventTouchUpInside];
        [sliderView addSubview:doneButton];
        
        [self.view addSubview:sliderView];
    }
    
    slider = [[TTRangeSlider alloc]initWithFrame:CGRectMake(30, sliderView.frame.size.height/2-10, sliderView.frame.size.width-60 ,100)];
    slider.tintColor = [UIColor redColor];
    slider.tintColorBetweenHandles = [UIColor redColor];
    slider.handleColor = [UIColor redColor];
    [sliderView addSubview:slider];
    slider.delegate = self;
    unitsOfMeasureBTN.hidden = YES;

    switch (category) {
   
        case 4:
        {
            //Height
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Height";
            unitsLabel.text = @"4ft 0in - 10ft 0in";
            slider.hideLabels = YES;
            slider.minValue = 48;
            slider.selectedMinimum = 48;
            slider.selectedMaximum = 100;
            slider.maxValue = 100;
        }
            break;
        case 5:
        {
            //Collar
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Collar Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 14.0;
            slider.selectedMinimum = 14.0;
            slider.selectedMaximum = 20.5;
            slider.maxValue = 20.5;

        }
            break;
        case 6:
        {
            //Hat
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Hat Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 21;
            slider.selectedMinimum = 21;
            slider.selectedMaximum = 25;
            slider.maxValue = 25;
        }
            break;
        case 7:
        {
            //Chest
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Chest Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 32;
            slider.selectedMinimum = 32;
            slider.selectedMaximum = 46;
            slider.maxValue = 46;

        }
            break;
        case 8:
        {
            //Hips Mesure Picker
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Hips Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 32;
            slider.selectedMinimum = 32;
            slider.selectedMaximum = 57;
            slider.maxValue = 57;

        }
            break;
        case 9:
        {
            //Inside Arm
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Inside Arm Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 21;
            slider.selectedMinimum = 21;
            slider.selectedMaximum = 27;
            slider.maxValue = 27;

        }
            break;
        case 10:
        {
            //Inside Leg Mesure Picker
            unitsOfMeasureBTN.hidden = NO;
            categoryTitle = @"Inside Leg Size";
            unitsLabel.text = @"Inches";
            slider.minValue = 22;
            slider.selectedMinimum = 22;
            slider.selectedMaximum = 39;
            slider.maxValue = 39;

        }
            break;
        case 11:
        {
            //Shoe Size Picker
            categoryTitle = @"Shoe Size UK";
            unitsLabel.text = @"";
            slider.minValue = 2;
            slider.selectedMinimum = 2;
            slider.selectedMaximum = 16;
            slider.maxValue = 16;

        }
            break;
        case 12:
        {
            unitsOfMeasureBTN.hidden = NO;
            //Weight Mesure Picker
            categoryTitle = @"Waist";
            unitsLabel.text = @"Inches";
            slider.minValue = 35;
            slider.selectedMinimum = 35;
            slider.selectedMaximum = 52;
            slider.maxValue = 52;

        }
            break;
        case 13:
        {
            unitsOfMeasureBTN.hidden = NO;
            //Weight
            categoryTitle = @"Weight";
            unitsLabel.text = @"Pounds";
            slider.minValue = 0;
            slider.selectedMinimum = 0;
            slider.selectedMaximum = 100;
            slider.maxValue = 100;
        }
            break;
            
        default:
            break;
    }
    
    titleLabel.text = categoryTitle;
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        sliderView.frame = CGRectMake(25, self.view.bounds.size.height/2-150, self.view.bounds.size.width-50, 300);
        
        
    } completion:^(BOOL finished) {
        NSLog(@"Transition Complete");
        
    }];
}

-(void)doneSliderChange:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        sliderView.frame = CGRectMake(25, self.view.bounds.size.height, self.view.bounds.size.width-50, 300);
        
        
    } completion:^(BOOL finished) {
       
        NSLog(@"Transition Complete");
        NSLog(@"%f - %f", slider.selectedMinimum, slider.selectedMaximum);
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[NSNumber numberWithFloat:round(slider.selectedMinimum * 100) / 100] forKey:@"min"];
        [dict setObject:[NSNumber numberWithFloat:round(slider.selectedMaximum * 100) / 100] forKey:@"max"];
        
        [parent.filterChoices setObject:dict forKey:selectedCategory];

        NSLog(@"FILTER CHOICES: %@", parent.filterChoices);
        [slider removeFromSuperview];
        slider = nil;
    }];
    
}
-(void)switchUnitsOfMeasure:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Switch to Metric"])
    {
        [sender setTitle:@"Switch to Imperial" forState:UIControlStateNormal];
        measureUnits = Metric;
        
        if([categoryTitle isEqualToString:@"Weight"]){
            
            int newMin = slider.minValue * 0.453592;
            int newMax = slider.maxValue * 0.453592;
            int newSelectedMin = slider.selectedMinimum * 0.453592;
            int newSelectedMax = slider.selectedMaximum * 0.453592;
            
            slider.minValue = newMin;
            slider.maxValue = newMax;
            slider.selectedMinimum = newSelectedMin;
            slider.selectedMaximum = newSelectedMax;
            unitsLabel.text = @"Kilograms";
        }
        else if(!([categoryTitle isEqualToString:@"Height"])){

            int newMin = slider.minValue * 2.54;
            int newMax = slider.maxValue * 2.54;
            int newSelectedMin = slider.selectedMinimum * 2.54;
            int newSelectedMax = slider.selectedMaximum * 2.54;
            
            slider.minValue = newMin;
            slider.maxValue = newMax;
            slider.selectedMinimum = newSelectedMin;
            slider.selectedMaximum = newSelectedMax;
            unitsLabel.text = @"Centimetres";
        }
        NSLog(@"%d", measureUnits);
        [self rangeSlider:slider didChangeSelectedMinimumValue:slider.minValue andMaximumValue:slider.maxValue];
    }
    else
    {
        [sender setTitle:@"Switch to Metric" forState:UIControlStateNormal];
        measureUnits = Imperial;
        
        if([categoryTitle isEqualToString:@"Weight"]){
            
            int newMin = slider.minValue / 0.453592;
            int newMax = slider.maxValue / 0.453592;
            int newSelectedMin = slider.selectedMinimum / 0.453592;
            int newSelectedMax = slider.selectedMaximum / 0.453592;
            
            slider.minValue = newMin;
            slider.maxValue = newMax;
            slider.selectedMinimum = newSelectedMin;
            slider.selectedMaximum = newSelectedMax;
            unitsLabel.text = @"Pounds";
        }
        else if(!([categoryTitle isEqualToString:@"Height"])){
            int newMin = slider.minValue / 2.54;
            int newMax = slider.maxValue / 2.54;
            int newSelectedMin = slider.selectedMinimum / 2.54;
            int newSelectedMax = slider.selectedMaximum / 2.54;
            
            slider.minValue = newMin;
            slider.maxValue = newMax;
            slider.selectedMinimum = newSelectedMin;
            slider.selectedMaximum = newSelectedMax;
            unitsLabel.text = @"Inches";
        }
        NSLog(@"%d", measureUnits);
        [self rangeSlider:slider didChangeSelectedMinimumValue:slider.minValue andMaximumValue:slider.maxValue];
    }
}

#pragma mark - Slider Methods

-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum
{
    if ([categoryTitle isEqualToString:@"Height"])
    {
        if (measureUnits == Imperial)
        {
            NSMutableDictionary *minDict = [self inchesToFeetAndInches:selectedMinimum];
            NSMutableDictionary *maxDict = [self inchesToFeetAndInches:selectedMaximum];
            
            int minFT = [[minDict objectForKey:@"Feet"] intValue];
            int minIn = [[minDict objectForKey:@"Inches"] intValue];
            int maxFT = [[maxDict objectForKey:@"Feet"] intValue];
            int maxIn = [[maxDict objectForKey:@"Inches"] intValue];
            
            unitsLabel.text = [NSString stringWithFormat:@"%d ft %d in - %d ft %d in", minFT, minIn, maxFT, maxIn];
        }
        else if (measureUnits == Metric)
        {
            NSMutableDictionary *minDict = [self inchesToMetersandCm:selectedMinimum];
            NSMutableDictionary *maxDict = [self inchesToMetersandCm:selectedMaximum];
            
            int minM = [[minDict objectForKey:@"Metres"] intValue];
            int minCM = [[minDict objectForKey:@"Centimeteres"] intValue];
            int maxM = [[maxDict objectForKey:@"Metres"] intValue];
            int maxCM = [[maxDict objectForKey:@"Centimeteres"] intValue];
            
            unitsLabel.text = [NSString stringWithFormat:@"%d M %d CM - %d M %d CM", minM, minCM, maxM, maxCM];
        }
    }
  
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show-filter-category"])
    {
        PhysicalDescriptionCategoryViewController *vc = segue.destinationViewController;
        vc.descriptionCategory = selectedCategory;
        vc.parent = self;
    }
    
}

-(IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
@end
