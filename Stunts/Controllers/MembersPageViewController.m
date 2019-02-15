//
//  MembersPageViewController.m
//  Stunts
//
//  Created by Peter Rocker on 07/02/2019.
//  Copyright © 2019 Richard Allen. All rights reserved.
//

#import "MembersPageViewController.h"
#import "ProfileTableViewController.h"

@interface MembersPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation MembersPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = self;
    self.delegate = self;
    
    [self setViewControllers:@[[self viewControllerForMember:self.selectedMember]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
    
}

- (UIViewController*) viewControllerForMember:(Members*) member{
    ProfileTableViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileTableViewController"];
    vc.selectedMember = member;
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger viewControllerIndex = [self.members indexOfObject:((MembersPageViewController*)viewController).selectedMember];
    NSInteger previousIndex = viewControllerIndex - 1;
    if(previousIndex < 0){
        return nil;
    }
    
    self.selectedMember = self.members[previousIndex];
    
    return [self viewControllerForMember:self.selectedMember];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger viewControllerIndex = [self.members indexOfObject:((MembersPageViewController*)viewController).selectedMember];
    NSInteger previousIndex = viewControllerIndex + 1;
    if(previousIndex >= self.members.count){
        return nil;
    }
    
    self.selectedMember = self.members[previousIndex];
    
    return [self viewControllerForMember:self.selectedMember];
}


@end
