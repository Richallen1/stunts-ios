//
//  SCErrorController.h
//  ErrorHandlingTest
//
//  Created by Richard Allen on 12/07/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCErrorController : NSObject
{
   
}

+ (id)sharedManager;
- (void) presentAlertWithLoginErrorCode:(int)code InPresenter:(UIViewController *) presenter;
- (void) presentAlertWithOnboardingErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err;
- (void) presentAlertWithWelcomeErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err;
- (void) presentAlertWithCreditsErrorCode:(int)code InPresenter:(UIViewController *) presenter withError:(NSError *)err;




@end
