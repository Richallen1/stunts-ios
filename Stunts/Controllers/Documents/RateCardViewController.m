//
//  RateCardViewController.m
//  Stunts
//
//  Created by Richard Allen on 14/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "RateCardViewController.h"

@interface RateCardViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIWebView *webView;
    
    NSMutableArray *data;
    
}
@end

@implementation RateCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rates" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    NSLog(@"Back Button Pressed");
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
