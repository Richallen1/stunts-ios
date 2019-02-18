//
//  FilterOptionsViewController.m
//  Stunts
//
//  Created by Richard Allen on 21/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "FilterOptionsViewController.h"
#import "PhysicalDescriptionViewController.h"
#import "FilterSkillsViewController.h"


@interface FilterOptionsViewController ()
{
    __weak IBOutlet UIButton *probationaryMemberButtton;
    __weak IBOutlet UIButton *stuntPerformerButton;
    __weak IBOutlet UIButton *seniorStuntPerformerButton;
    __weak IBOutlet UIButton *keyStuntPerformerButton;
    __weak IBOutlet UIButton *fullMemberButton;
}

@end

@implementation FilterOptionsViewController
@synthesize filterChoices;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    filterChoices = [[NSMutableDictionary alloc]init];
    
    //Probationary Buttton Setup
    [probationaryMemberButtton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [probationaryMemberButtton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    //Intermediate Button Setup
    [stuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [stuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    //Intermediate Button Setup
    [seniorStuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [seniorStuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    //Intermediate Button Setup
    [keyStuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [keyStuntPerformerButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    
    //Full Member Button Setup
    [fullMemberButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [fullMemberButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    probationaryMemberButtton.selected = YES;
    stuntPerformerButton.selected = YES;
    seniorStuntPerformerButton.selected = YES;
    keyStuntPerformerButton.selected = YES;
    fullMemberButton.selected = YES;
    
    [filterChoices setObject:@"YES" forKey:@"ProbationaryMember"];
    [filterChoices setObject:@"YES" forKey:@"StuntPerformer"];
    [filterChoices setObject:@"YES" forKey:@"SeniorStuntPerformer"];
    [filterChoices setObject:@"YES" forKey:@"KeyStuntPerformer"];
    [filterChoices setObject:@"YES" forKey:@"FullMember"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)probationaryClicked:(id)sender
{
    if (probationaryMemberButtton.isSelected == YES)
    {
        probationaryMemberButtton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"ProbationaryMember"];
    }
    else
    {
        probationaryMemberButtton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"ProbationaryMember"];
    }
}

- (IBAction)stuntPerformerClicked:(id)sender
{
    if (stuntPerformerButton.isSelected == YES)
    {
        stuntPerformerButton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"StuntPerformer"];
    }
    else
    {
        stuntPerformerButton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"StuntPerformer"];
    }
}

- (IBAction)seniorStuntPerformerClicked:(id)sender
{
    if (seniorStuntPerformerButton.isSelected == YES)
    {
        seniorStuntPerformerButton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"SeniorStuntPerformer"];
    }
    else
    {
        seniorStuntPerformerButton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"SeniorStuntPerformer"];
    }
}

- (IBAction)keyStuntPerformerClicked:(id)sender
{
    if (keyStuntPerformerButton.isSelected == YES)
    {
        keyStuntPerformerButton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"KeyStuntPerformer"];
    }
    else
    {
        keyStuntPerformerButton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"KeyStuntPerformer"];
    }
}
- (IBAction)fullMemberClicked:(id)sender
{
    if (fullMemberButton.isSelected == YES)
    {
        fullMemberButton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"FullMember"];
    }
    else
    {
        fullMemberButton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"FullMember"];
    }
}
- (IBAction)physicalDescriptionPressed:(id)sender
{
    [self performSegueWithIdentifier:@"physical-description-segue" sender:self];
}

- (IBAction)skillsButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"show-skills-segue" sender:self];
}

-(IBAction)resetButton:(id)sender
{
    [filterChoices removeAllObjects];
    [self DonePressed:self];
}

-(IBAction)DonePressed:(id)sender
{
   //Perform search on parent
    
    NSLog(@"%@", filterChoices);
    [parent filterMembersWith:filterChoices];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"physical-description-segue"])
    {
        PhysicalDescriptionViewController *vc = segue.destinationViewController;
        vc.parent = self;
    }
    
    if ([segue.identifier isEqualToString:@"show-skills-segue"])
    {
        FilterSkillsViewController *vc = segue.destinationViewController;
        vc.parent = self;
    }
    
}


@end
