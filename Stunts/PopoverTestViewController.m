//
//  PopoverTestViewController.m
//  Stunts
//
//  Created by Richard Allen on 17/12/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "PopoverTestViewController.h"
#import "macros.h"


@interface PopoverTestViewController ()
{
    UIView *backgroundDarkView;
    UIView *popoverView;
}

@end

@implementation PopoverTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProdPopover];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self AnimatePopoverOnScreen];
}

-(void)initProdPopover
{
    backgroundDarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundDarkView.backgroundColor = [UIColor blackColor];
    backgroundDarkView.alpha = 0;
    
    [self.view addSubview:backgroundDarkView];
    

    popoverView = [[UIView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height, 327, 486)];
    popoverView.backgroundColor = [UIColor whiteColor];
    popoverView.layer.cornerRadius = 25;
    popoverView.clipsToBounds = YES;
    
    [self.view addSubview:popoverView];
    
    
    UILabel *headerLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(26, 50, 263, 32)];
    headerLabel1.text = @"Welcome";
    headerLabel1.font = [UIFont fontWithName:@"SFProText-Light" size:26];
    [popoverView addSubview:headerLabel1];
    
    UILabel *headerLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(26, 78, 263, 64)];
    headerLabel2.text = @"to the British Stunt Register App.";
    headerLabel2.numberOfLines = 0;
    headerLabel2.font = [UIFont fontWithName:@"SFProText-Light" size:26];
    [popoverView addSubview:headerLabel2];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 146, 263, 180)];
    infoLabel.text = @"You can view profiles from all members of the register as  well as search and filter based on physical desciption, sklills and more. Within the app you can create lists of performers to share with collegues as well as contact members directly.";
    infoLabel.numberOfLines = 0;
    [infoLabel setTextColor:UIColorFromRGB(0X8C8C8C)];
    infoLabel.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    [popoverView addSubview:infoLabel];
    
    UILabel *infoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(23, 334, 263, 70)];
    
    infoLabel2.text = @"If you need any assistance please email: app@thebritishstuntregister.com";
    infoLabel2.numberOfLines = 0;
    [infoLabel2 setTextColor:UIColorFromRGB(0X8C8C8C)];
    infoLabel2.font = [UIFont fontWithName:@"SFProText-Light" size:17];
    [popoverView addSubview:infoLabel2];
    
    
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(59, 430, 210, 41)];
    [doneButton setImage:[UIImage imageNamed:@"Done_List_242"] forState:UIControlStateNormal];
    // [doneButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    [popoverView addSubview:doneButton];
    
}

-(void)AnimatePopoverOnScreen
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.4f];
        popoverView.frame = CGRectMake(20, 100, 327, 486);
        
    } completion:^(BOOL finished) {
       
        NSLog(@"Transition Complete");
        
    }];
}

-(void)AnimatePopoverOffScreen
{
    [UIView animateWithDuration:0.4f animations:^{
        
        [backgroundDarkView setAlpha:0.0f];
        popoverView.frame = CGRectMake(20, self.view.frame.size.height, 327, 486);
        
    } completion:^(BOOL finished) {
        
        NSLog(@"Transition Complete");
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//
//  TestViewController.m
//  Stunts
//
//  Created by Richard Allen on 03/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//


@end
