//
//  ContractViewController.m
//  Stunts
//
//  Created by Richard Allen on 30/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "ContractViewController.h"

@interface ContractViewController ()

@end

@implementation ContractViewController
@synthesize contractImageView;
@synthesize contractImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    contractImageView.image = contractImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
