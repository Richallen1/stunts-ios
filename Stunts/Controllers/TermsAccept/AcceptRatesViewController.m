//
//  AcceptRatesViewController.m
//  Stunts
//
//  Created by Richard Allen on 30/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "AcceptRatesViewController.h"

@interface AcceptRatesViewController ()
{
    IBOutlet UIWebView *webView;
    IBOutlet UISwitch *acceptSwitch;
    IBOutlet UIButton *nextButton;
}
@end

@implementation AcceptRatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"constitution" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    
}

-(IBAction)acceptSwitchActivated:(UISwitch *)sender
{
    if (sender.on == YES)
    {
        nextButton.alpha = 1;
    }
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
