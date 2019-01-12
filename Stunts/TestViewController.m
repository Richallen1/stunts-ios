//
//  TestViewController.m
//  Stunts
//
//  Created by Richard Allen on 03/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "TestViewController.h"
#import <Parse/Parse.h>
#import <Crashlytics/Crashlytics.h>
#import "GKImagePicker.h"
#import "macros.h"
#import "AppImports.h"
#import "WeightPopoverController.h"
#import "AddToListViewController.h"

@interface TestViewController ()<GKImagePickerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
{
    UIView *backgroundDarkView;
    UIView *addInfoView;
    UILabel *titleLabel;
    UIButton *saveButton;
    UIView *pickerContainerView;
    UIPickerView *pickerView;
    UILabel *unitofMeasure;
    UILabel *secondUnitOfMeasure;
    
    NSMutableArray *dataForPicker;
    
    UnitsOfMeasure *measureUnits;
    
    
    WeightPopoverController *popoverViewController;
    
}
@property (nonatomic, strong) GKImagePicker *imagePicker;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"LOAD!!!");
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    
//    if(popoverViewController == nil) {
//        popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeightPopover"];
//
//    }
//
////    [popoverViewController.saveButton addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
//    popoverViewController.parent = self;
//    popoverViewController.preferredContentSize = CGSizeMake(330, 330);
//    popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
//    UIPopoverPresentationController *popoverController = popoverViewController.popoverPresentationController;
//    popoverController.permittedArrowDirections = nil;
//    popoverController.delegate = self;
//    popoverController.sourceView = self.view;
//    popoverController.sourceRect = [self.view frame];
//
//    [self presentViewController:popoverViewController animated:YES completion:nil];
    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:[NSNumber numberWithInt:80] forKey:@"kg"];
//    [dict setObject:[NSNumber numberWithInt:8] forKey:@"g"];
//
//    float kg = 80;
//    float g = 8;
//    float kgsInG = 80*1000;
//    float totalG = kgsInG+g;
//    float totalKG = totalG/1000;
//    NSLog(@"%@", [self convertWeightMetricToImperial:totalKG]);
}
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
-(NSMutableDictionary *)convertWeightMetricToImperial:(float)kgs
{
    float stone  = kgs/6.35029318;
    int st = stone;
    float remainder = stone - st;
    int pounds = remainder*14;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSNumber numberWithInt:st] forKey:@"stone"];
    [dict setObject:[NSNumber numberWithInt:pounds] forKey:@"pound"];
    return dict;
}
-(void)updateWeight:(int)unit1 and:(int)unit2 inUnits:(UnitsOfMeasure)units
{
    [popoverViewController dismissViewControllerAnimated:YES completion:nil];
    switch (units) {
        case Imperial:
        {
            NSLog(@"%d st %d lb", unit1, unit2);
        }
        case Metric:
        {
            NSLog(@"%d kg %d g", unit1, unit2);
        }
            break;
            
        default:
            break;
    }
}

@end
