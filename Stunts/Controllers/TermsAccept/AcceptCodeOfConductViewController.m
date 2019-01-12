//
//  AcceptCodeOfConductViewController.m
//  Stunts
//
//  Created by Richard Allen on 30/09/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "AcceptCodeOfConductViewController.h"
#import <Parse/Parse.h>

@interface AcceptCodeOfConductViewController ()
{
    IBOutlet UIWebView *webView;
    IBOutlet UISwitch *acceptSwitch;
    IBOutlet UIButton *nextButton;
}
@end

@implementation AcceptCodeOfConductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BSR-Code-of-Conduct" ofType:@"pdf"];
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
        [self performSegueWithIdentifier:@"codeOfConduct_accept_segue" sender:self];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Accept" message:@"Please read and accept the current Code of Conduct of the British Stunt Register. You will need to accept these before proceding" preferredStyle:UIAlertControllerStyleAlert];
        
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"codeOfConduct_accept_segue"])
    {
        [PFUser currentUser][@"termsAccepted"] = [NSNumber numberWithBool:YES];
        [[PFUser currentUser] save];
    }
}

@end
