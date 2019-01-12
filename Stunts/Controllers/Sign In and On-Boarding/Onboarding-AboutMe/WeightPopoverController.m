//
//  WeightPopoverController.m
//  Stunts
//
//  Created by Richard Allen on 02/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "WeightPopoverController.h"
#import "AppImports.h"

@interface WeightPopoverController ()
{
    UnitsOfMeasure *measureUnits;
    UILabel *unitofMeasure;
    UILabel *secondUnitOfMeasure;
}
@end

@implementation WeightPopoverController
@synthesize parent;
@synthesize saveButton;
@synthesize unit1;
@synthesize unit2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    measureUnits = Imperial;
    
    /* Add Tittle */
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 330, 50)];
    titleLabel.font = [UIFont fontWithName:@"SFProText-Light" size:24];
    titleLabel.text = @"Please Enter Your Weight";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];

    
    UIButton *switchUnitsOfMeasureBTN = [[UIButton alloc]initWithFrame:CGRectMake(155, 66, 150, 14)];
    [switchUnitsOfMeasureBTN setTitleColor:UIColorFromRGB(0x1E67FF) forState:UIControlStateNormal];
    [switchUnitsOfMeasureBTN setTitle:@"Switch to Metric" forState:UIControlStateNormal];
    [switchUnitsOfMeasureBTN addTarget:self action:@selector(switchUnitsOfMeasure:) forControlEvents:UIControlEventTouchUpInside];
    switchUnitsOfMeasureBTN.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:switchUnitsOfMeasureBTN];
    

    unitofMeasure = [[UILabel  alloc]initWithFrame:CGRectMake(30 , 118, 120, 21)];
    unitofMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
    unitofMeasure.textAlignment = NSTextAlignmentCenter;
    unitofMeasure.text = @"Stone";
    [self.view addSubview:unitofMeasure];

    secondUnitOfMeasure = [[UILabel alloc]initWithFrame:CGRectMake(199, 118, 70, 21)];
    secondUnitOfMeasure.font = [UIFont fontWithName:@"SFProText-Light" size:18];
    secondUnitOfMeasure.textAlignment = NSTextAlignmentCenter;
    secondUnitOfMeasure.text = @"Pounds";
    [self.view addSubview:secondUnitOfMeasure];
    
    unit1 = [[UITextField alloc]initWithFrame:CGRectMake(56, 144, 70, 53)];
    unit1.layer.borderColor = [[UIColor blackColor] CGColor];
    unit1.layer.borderWidth = 1;
    unit1.layer.masksToBounds = YES;
    unit1.layer.cornerRadius = 3;
    unit1.textAlignment = NSTextAlignmentCenter;
    unit1.tag = 0;
    unit1.keyboardType = UIKeyboardTypeNumberPad;
    [unit1 addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:unit1];
    
    unit2 = [[UITextField alloc]initWithFrame:CGRectMake(199, 144, 70, 53)];
    unit2.layer.borderColor = [[UIColor blackColor] CGColor];
    unit2.layer.borderWidth = 1;
    unit2.layer.masksToBounds = YES;
    unit2.layer.cornerRadius = 3;
    unit2.tag = 1;
    unit2.keyboardType = UIKeyboardTypeNumberPad;
    unit2.textAlignment = NSTextAlignmentCenter;
    [unit2 addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:unit2];
    
    /******* Save Button ********/
    saveButton = [[UIButton alloc]initWithFrame:CGRectMake(47, 260, 242, 51)];
    [saveButton setImage:[UIImage imageNamed:@"save-button"] forState:UIControlStateNormal];
    saveButton.userInteractionEnabled = YES;
    [saveButton addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:saveButton];
}
-(void)checkTextField:(UITextField *)sender
{
    int number = [sender.text intValue];
    //NSLog(@"%@ - %d", sender.text, number);
    if (sender.tag == 1)
    {
        if (measureUnits == Imperial)
        {
            if (number > 12) {
                sender.text = @"12";
            }
        }
    }
}
-(void)switchUnitsOfMeasure:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Switch to Metric"])
    {
        [sender setTitle:@"Switch to Imperial" forState:UIControlStateNormal];
        measureUnits = Metric;
        NSLog(@"%d", measureUnits);
        unitofMeasure.text = @"Kilograms";
        secondUnitOfMeasure.text = @"Grams";
        //[self rangeSlider:slider didChangeSelectedMinimumValue:slider.minValue andMaximumValue:slider.maxValue];
    }
    else
    {
        [sender setTitle:@"Switch to Metric" forState:UIControlStateNormal];
        measureUnits = Imperial;
        NSLog(@"%d", measureUnits);
        unitofMeasure.text = @"Stone";
        secondUnitOfMeasure.text = @"Pounds";
        //[self rangeSlider:slider didChangeSelectedMinimumValue:slider.minValue andMaximumValue:slider.maxValue];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Save:(id)sender
{
    int int1 = [unit1.text intValue];
    int int2 = [unit2.text intValue];
    [parent updateWeight:int1 and:int2 inUnits:measureUnits];
    NSLog(@"%d", measureUnits);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
