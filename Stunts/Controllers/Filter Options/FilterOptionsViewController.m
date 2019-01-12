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
    __weak IBOutlet UIButton *intermediateButton;
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
    [intermediateButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [intermediateButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    
    //Full Member Button Setup
    [fullMemberButton setImage:[UIImage imageNamed:@"filter-user-unselected"] forState:UIControlStateNormal];
    [fullMemberButton setImage:[UIImage imageNamed:@"filter-user-selected"] forState:UIControlStateSelected];
    
    probationaryMemberButtton.selected = YES;
    intermediateButton.selected = YES;
    fullMemberButton.selected = YES;
    
    [filterChoices setObject:@"YES" forKey:@"ProbationaryMember"];
    [filterChoices setObject:@"YES" forKey:@"IntermediateMember"];
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

- (IBAction)intermediateClicked:(id)sender
{
    if (intermediateButton.isSelected == YES)
    {
        intermediateButton.selected = NO;
        [filterChoices setObject:@"NO" forKey:@"IntermediateMember"];
    }
    else
    {
        intermediateButton.selected = YES;
        [filterChoices setObject:@"YES" forKey:@"IntermediateMember"];
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
