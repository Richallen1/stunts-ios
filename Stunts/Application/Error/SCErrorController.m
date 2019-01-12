//
//  SCErrorController.m
//  ErrorHandlingTest
//
//  Created by Richard Allen on 12/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "SCErrorController.h"
#import <Crashlytics/Crashlytics.h>


@implementation SCErrorController

#pragma mark Singleton Methods

+ (id)sharedManager {
    static SCErrorController *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
- (void) presentAlertWithLoginErrorCode:(int)code InPresenter:(UIViewController *) presenter{
    NSString *message;
    switch (code)
    {
        case 101:
            message = @"You're email and password dont match what we have. Please check and try again or click signup to register.";
            break;
        case 200:
            message = @"You must supply a vaild email to login";
            break;
        case 201:
            message = @"Please enter your password";
            break;
            
        default:
        {
            message = @"We have encountered an unexpected eror in Logging in. Please try again later.";
        }
            break;
    }
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Logging In"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
//                                  [presenter cancelPressed];//Here's the key
                              }];
    
    [alert addAction:cancel];
    [presenter presentViewController: alert animated:YES completion:nil];
}
- (void) presentAlertWithOnboardingErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err
{
    if (err) {
        [CrashlyticsKit recordError:err];
        NSLog(@"Error Getting Profile: %@ %@", err, [err userInfo]);
    }
    
    NSString *message;
    switch (code)
    {
        case 101:
            message = @"(Error 101) We have encountered an error in setting up your profile. Please try again later or if the problem persists contact app@thebristishstuntregister.com";
            break;
          
        case 102:
            message = @"(Error 102) We have encountered an error in saving your gallery images. Please try again later or if the problem persists contact app@thebristishstuntregister.com";
            break;
        default:
        {
            message = @"We have encountered an unexpected eror in setting up your profile. Please try again later or if the problem persists contact app@thebristishstuntregister.com";
        }
            break;
    }
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Logging In"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
                        
                              }];
    
    [alert addAction:cancel];
    [presenter presentViewController: alert animated:YES completion:nil];
}
- (void) presentAlertWithWelcomeErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err
{
    //Errors
    //125 Invalid Email
    if (err) {
        [CrashlyticsKit recordError:err];
        NSLog(@"Error Getting Profile: %@ %@", err, [err userInfo]);
    }
    
    NSString *message = @"We seem to have hit an issue in setting up your account. Please try again. If the problem persists please contact app@thebritishstuntregister.com";

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Logging In"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
                                  
                              }];
    
    [alert addAction:cancel];
    [presenter presentViewController: alert animated:YES completion:nil];
}
- (void) presentAlertWithCreditsErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err
{
    if (err) {
        [CrashlyticsKit recordError:err];
        NSLog(@"Error Getting Profile: %@ %@", err, [err userInfo]);
    }
    
    NSString *message;
    switch (code)
    {
        case 101:
            message = @"Please enter a production name.";
            break;
            
        case 102:
            message = @"Please enter the Producer or Studio that emaployed you.";
            break;
            
        case 103:
            message = @"Please enter your job title on this project.";
            break;
            
        case 104:
            message = @"Please enter the name of the director on the project.";
            break;
        case 105:
            message = @"Please choose an image of your contract from your photos.";
            break;
        case 201:
            message = @"We seem to have hit an error please try again. If the problem persist please contact app@thebritishstuntregister.com (code:201)";
            break;
            //
            
        default:
        {
            message = @"We have encountered an unexpected eror in setting up your credit. Please try again later or if the problem persists contact app@thebristishstuntregister.com";
        }
            break;
    }
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Logging In"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
                                  
                              }];
    
    [alert addAction:cancel];
    [presenter presentViewController: alert animated:YES completion:nil];
}

@end
