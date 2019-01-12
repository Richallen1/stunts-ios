//
//  AcceptRulesViewController.m
//  Stunts
//
//  Created by Richard Allen on 30/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "AcceptRulesViewController.h"

@interface AcceptRulesViewController ()
{
    IBOutlet UIWebView *webView;
    IBOutlet UISwitch *acceptSwitch;
    IBOutlet UIButton *nextButton;
}
@end

@implementation AcceptRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"constitution" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    
    [acceptSwitch addTarget:self action:@selector(acceptSwitchActivated:) forControlEvents:UIControlEventValueChanged];
    [nextButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)acceptSwitchActivated:(UISwitch *)sender
{
    if (sender.on == YES)
    {
        nextButton.alpha = 1;
    }
    else
    {
        nextButton.alpha = 0.4;
    }
}

-(void)nextPressed:(UIButton *)sender
{
    if (acceptSwitch.on == YES)
    {
        //Proceed
        [self performSegueWithIdentifier:@"rules_accept_segue" sender:self];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Accept" message:@"Please read and accept the current rules and constitution of the British Stunt Register. You will need to accept these before proceding" preferredStyle:UIAlertControllerStyleAlert];
                                    
        UIAlertAction * cancel = [UIAlertAction
                                  actionWithTitle:@"Ok"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action) {
                                      //                                  [presenter cancelPressed];//Here's the key
                                  }];
        
        [alert addAction:cancel];
        [self presentViewController: alert animated:YES completion:nil];
    }
}

@end
