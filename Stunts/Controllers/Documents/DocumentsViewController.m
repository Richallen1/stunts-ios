//
//  DocumentsViewController.m
//  Stunts
//
//  Created by Richard Allen on 03/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "DocumentsViewController.h"
#import <MessageUI/MessageUI.h>

@interface DocumentsViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation DocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)Contact:(UIButton *)sender
{
    NSString *recepient = @"";
    switch (sender.tag) {
        case 0:
        {
            //Info
            recepient = @"info@thebritishstuntregister.com";
        }
            break;
        case 1:
        {
            //HR
            recepient = @"HR@thebritishstuntregister.com";
        }
            break;
        case 2:
        {
            //APP
            recepient = @"App@thebritishstuntregister.com";
        }
            break;
            
        default:
            break;
    }
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    mail.mailComposeDelegate = self;
    [mail setSubject:@"Email From BSR App"];
    [mail setMessageBody:@"Hi " isHTML:NO];
    [mail setToRecipients:@[recepient]];
    
    [self presentViewController:mail animated:YES completion:NULL];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)TriggerLinkToIncidentReport
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://docs.google.com/forms/d/e/1FAIpQLSfldI7ZTcrNTlkLBWYW1CSimqgj4DHp3xkEigjwKBTqLZgwPg/viewform"]];

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
