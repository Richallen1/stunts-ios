//
//  ImageViewController.m
//  Stunts
//
//  Created by Richard Allen on 27/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    __weak IBOutlet UIImageView *imageView;
}
@end

@implementation ImageViewController
@synthesize imageToShow;


- (void)viewDidLoad {
    [super viewDidLoad];
    imageView.image = imageToShow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
