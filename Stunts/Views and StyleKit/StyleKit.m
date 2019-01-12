//
//  StyleKit.m
//  Stunts App
//
//  Created by Rich Allen on May 15, 2018.
//  Copyright © 2018 12 South Creative. All rights reserved.
//

@import UIKit;
#import "StyleKit.h"



@implementation StyleKit


#pragma mark - Canvas Drawings

//! All Views

+ (void)drawSignUp {
    [StyleKit drawSignUpWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawSignUpWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! Terms of Service
    NSMutableAttributedString *termsOfService = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service"];
    [termsOfService addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:12] range:NSMakeRange(0, termsOfService.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [termsOfService addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, termsOfService.length)];
    }
    [termsOfService addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, termsOfService.length)];
    CGContextSaveGState(context);
    [termsOfService drawInRect:CGRectMake(142, 617, 91, 20)];
    CGContextRestoreGState(context);
    //! By clicking Sign Up
    NSMutableAttributedString *byClickingSignUp = [[NSMutableAttributedString alloc] initWithString:@"By clicking Sign Up you agree to our"];
    [byClickingSignUp addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:12] range:NSMakeRange(0, byClickingSignUp.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [byClickingSignUp addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, byClickingSignUp.length)];
    }
    [byClickingSignUp addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, byClickingSignUp.length)];
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.6);
    CGContextBeginTransparencyLayer(context, nil);
    {
        [byClickingSignUp drawInRect:CGRectMake(48, 585, 280, 20)];
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    //! Button
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 501);
        
        //! Background
        UIBezierPath *background = [UIBezierPath bezierPath];
        [background moveToPoint:CGPointMake(0, 8.01)];
        [background addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [background addLineToPoint:CGPointMake(335.01, 0)];
        [background addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [background addLineToPoint:CGPointMake(343, 41.99)];
        [background addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [background addLineToPoint:CGPointMake(7.99, 50)];
        [background addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [background addLineToPoint:CGPointMake(0, 8.01)];
        [background closePath];
        CGContextSaveGState(context);
        background.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.009 saturation:0.761 brightness:1 alpha:1] setFill];
        [background fill];
        CGContextRestoreGState(context);
        
        //! Sign Up
        NSMutableAttributedString *signUp2 = [[NSMutableAttributedString alloc] initWithString:@"Sign Up"];
        [signUp2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:16] range:NSMakeRange(0, signUp2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [signUp2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, signUp2.length)];
        }
        [signUp2 addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, signUp2.length)];
        CGContextSaveGState(context);
        [signUp2 drawAtPoint:CGPointMake(140.5, 14)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Input
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 341);
        
        //! Stroke
        UIBezierPath *stroke = [UIBezierPath bezierPath];
        [stroke moveToPoint:CGPointMake(0, 8.01)];
        [stroke addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [stroke addLineToPoint:CGPointMake(335.01, 0)];
        [stroke addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [stroke addLineToPoint:CGPointMake(343, 41.99)];
        [stroke addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [stroke addLineToPoint:CGPointMake(7.99, 50)];
        [stroke addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [stroke addLineToPoint:CGPointMake(0, 8.01)];
        [stroke closePath];
        CGContextSaveGState(context);
        stroke.usesEvenOddFillRule = YES;
        [UIColor.whiteColor setFill];
        [stroke fill];
        CGContextSaveGState(context);
        stroke.lineWidth = 2;
        CGContextBeginPath(context);
        CGContextAddPath(context, stroke.CGPath);
        CGContextAddRect(context, CGRectInset(stroke.bounds, -20, -20));
        CGContextEOClip(context);
        [[UIColor colorWithWhite:0.067 alpha:0.1] setStroke];
        [stroke stroke];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        //! Password
        NSMutableAttributedString *password = [[NSMutableAttributedString alloc] initWithString:@"Password"];
        [password addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:14] range:NSMakeRange(0, password.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [password addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, password.length)];
        }
        [password addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, password.length)];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.6);
        CGContextBeginTransparencyLayer(context, nil);
        {
            [password drawAtPoint:CGPointMake(16, 15)];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Input
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 405);
        
        //! Stroke
        UIBezierPath *stroke2 = [UIBezierPath bezierPath];
        [stroke2 moveToPoint:CGPointMake(0, 8.01)];
        [stroke2 addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [stroke2 addLineToPoint:CGPointMake(335.01, 0)];
        [stroke2 addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [stroke2 addLineToPoint:CGPointMake(343, 41.99)];
        [stroke2 addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [stroke2 addLineToPoint:CGPointMake(7.99, 50)];
        [stroke2 addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [stroke2 addLineToPoint:CGPointMake(0, 8.01)];
        [stroke2 closePath];
        CGContextSaveGState(context);
        stroke2.usesEvenOddFillRule = YES;
        [UIColor.whiteColor setFill];
        [stroke2 fill];
        CGContextSaveGState(context);
        stroke2.lineWidth = 2;
        CGContextBeginPath(context);
        CGContextAddPath(context, stroke2.CGPath);
        CGContextAddRect(context, CGRectInset(stroke2.bounds, -20, -20));
        CGContextEOClip(context);
        [[UIColor colorWithWhite:0.067 alpha:0.1] setStroke];
        [stroke2 stroke];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        //! Re Enter Password
        NSMutableAttributedString *reEnterPassword = [[NSMutableAttributedString alloc] initWithString:@"Re Enter Password"];
        [reEnterPassword addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:14] range:NSMakeRange(0, reEnterPassword.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [reEnterPassword addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, reEnterPassword.length)];
        }
        [reEnterPassword addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, reEnterPassword.length)];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.6);
        CGContextBeginTransparencyLayer(context, nil);
        {
            [reEnterPassword drawAtPoint:CGPointMake(16, 15)];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Input
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 275);
        
        //! Stroke
        UIBezierPath *stroke3 = [UIBezierPath bezierPath];
        [stroke3 moveToPoint:CGPointMake(0, 8.01)];
        [stroke3 addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [stroke3 addLineToPoint:CGPointMake(335.01, 0)];
        [stroke3 addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [stroke3 addLineToPoint:CGPointMake(343, 41.99)];
        [stroke3 addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [stroke3 addLineToPoint:CGPointMake(7.99, 50)];
        [stroke3 addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [stroke3 addLineToPoint:CGPointMake(0, 8.01)];
        [stroke3 closePath];
        CGContextSaveGState(context);
        stroke3.usesEvenOddFillRule = YES;
        [UIColor.whiteColor setFill];
        [stroke3 fill];
        CGContextSaveGState(context);
        stroke3.lineWidth = 2;
        CGContextBeginPath(context);
        CGContextAddPath(context, stroke3.CGPath);
        CGContextAddRect(context, CGRectInset(stroke3.bounds, -20, -20));
        CGContextEOClip(context);
        [[UIColor colorWithWhite:0.067 alpha:0.1] setStroke];
        [stroke3 stroke];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        //! Mr.Beans
        NSMutableAttributedString *mrBeans = [[NSMutableAttributedString alloc] initWithString:@"Mr.Beans"];
        [mrBeans addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:14] range:NSMakeRange(0, mrBeans.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [mrBeans addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mrBeans.length)];
        }
        [mrBeans addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, mrBeans.length)];
        CGContextSaveGState(context);
        [mrBeans drawAtPoint:CGPointMake(16, 15)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Status bar
    // Warning: New symbols are not supported.
    //! bsr
    // Warning: Image layers are not supported.
    
    CGContextRestoreGState(context);
}

+ (void)drawSignIn {
    [StyleKit drawSignInWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawSignInWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! Terms of Service
    NSMutableAttributedString *termsOfService = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service"];
    [termsOfService addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:12] range:NSMakeRange(0, termsOfService.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [termsOfService addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, termsOfService.length)];
    }
    [termsOfService addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, termsOfService.length)];
    CGContextSaveGState(context);
    [termsOfService drawInRect:CGRectMake(142, 617, 91, 20)];
    CGContextRestoreGState(context);
    //! By clicking «registr
    NSMutableAttributedString *byClickingRegistr = [[NSMutableAttributedString alloc] initWithString:@"By clicking «registration» you agree to our"];
    [byClickingRegistr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:12] range:NSMakeRange(0, byClickingRegistr.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [byClickingRegistr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, byClickingRegistr.length)];
    }
    [byClickingRegistr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, byClickingRegistr.length)];
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.6);
    CGContextBeginTransparencyLayer(context, nil);
    {
        [byClickingRegistr drawInRect:CGRectMake(48, 597, 280, 20)];
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    //! Button
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 501);
        
        //! Background
        UIBezierPath *background = [UIBezierPath bezierPath];
        [background moveToPoint:CGPointMake(0, 8.01)];
        [background addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [background addLineToPoint:CGPointMake(335.01, 0)];
        [background addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [background addLineToPoint:CGPointMake(343, 41.99)];
        [background addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [background addLineToPoint:CGPointMake(7.99, 50)];
        [background addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [background addLineToPoint:CGPointMake(0, 8.01)];
        [background closePath];
        CGContextSaveGState(context);
        background.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.009 saturation:0.761 brightness:1 alpha:1] setFill];
        [background fill];
        CGContextRestoreGState(context);
        
        //! Sign In
        NSMutableAttributedString *signIn2 = [[NSMutableAttributedString alloc] initWithString:@"Sign In"];
        [signIn2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:16] range:NSMakeRange(0, signIn2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [signIn2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, signIn2.length)];
        }
        [signIn2 addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, signIn2.length)];
        CGContextSaveGState(context);
        [signIn2 drawAtPoint:CGPointMake(144.5, 14)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Forget password ?
    NSMutableAttributedString *forgetPassword = [[NSMutableAttributedString alloc] initWithString:@"Forget password ?"];
    [forgetPassword addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:12] range:NSMakeRange(0, forgetPassword.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [forgetPassword addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, forgetPassword.length)];
    }
    [forgetPassword addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, forgetPassword.length)];
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.6);
    CGContextBeginTransparencyLayer(context, nil);
    {
        [forgetPassword drawAtPoint:CGPointMake(260, 412)];
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    //! Remember me
    NSMutableAttributedString *rememberMe = [[NSMutableAttributedString alloc] initWithString:@"Remember me"];
    [rememberMe addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:12] range:NSMakeRange(0, rememberMe.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 18;
        paragraphStyle.minimumLineHeight = 18;
        [rememberMe addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, rememberMe.length)];
    }
    [rememberMe addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, rememberMe.length)];
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.6);
    CGContextBeginTransparencyLayer(context, nil);
    {
        [rememberMe drawAtPoint:CGPointMake(52, 412)];
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    //! Icon
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 407);
        
        //! Stroke
        UIBezierPath *stroke = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 28, 28)];
        CGContextSaveGState(context);
        [[UIColor colorWithHue:0.009 saturation:0.761 brightness:1 alpha:1] setFill];
        [stroke fill];
        CGContextRestoreGState(context);
        
        //! Icon
        UIBezierPath *icon = [UIBezierPath bezierPath];
        [icon moveToPoint:CGPointMake(4.08, 9)];
        [icon addLineToPoint:CGPointMake(4.07, 9)];
        [icon addCurveToPoint:CGPointMake(3.4, 8.7) controlPoint1:CGPointMake(3.81, 9) controlPoint2:CGPointMake(3.57, 8.89)];
        [icon addLineToPoint:CGPointMake(0.24, 5.32)];
        [icon addCurveToPoint:CGPointMake(0.3, 4.05) controlPoint1:CGPointMake(-0.1, 4.95) controlPoint2:CGPointMake(-0.07, 4.38)];
        [icon addCurveToPoint:CGPointMake(1.61, 4.11) controlPoint1:CGPointMake(0.68, 3.71) controlPoint2:CGPointMake(1.26, 3.74)];
        [icon addLineToPoint:CGPointMake(4.09, 6.78)];
        [icon addLineToPoint:CGPointMake(10.41, 0.28)];
        [icon addCurveToPoint:CGPointMake(11.71, 0.25) controlPoint1:CGPointMake(10.76, -0.08) controlPoint2:CGPointMake(11.34, -0.09)];
        [icon addCurveToPoint:CGPointMake(11.75, 1.52) controlPoint1:CGPointMake(12.08, 0.59) controlPoint2:CGPointMake(12.1, 1.16)];
        [icon addLineToPoint:CGPointMake(4.75, 8.72)];
        [icon addCurveToPoint:CGPointMake(4.08, 9) controlPoint1:CGPointMake(4.57, 8.9) controlPoint2:CGPointMake(4.33, 9)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 8, 10);
        icon.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.274 saturation:0 brightness:0.996 alpha:1] setFill];
        [icon fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Input
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 335);
        
        //! Stroke
        UIBezierPath *stroke2 = [UIBezierPath bezierPath];
        [stroke2 moveToPoint:CGPointMake(0, 8.01)];
        [stroke2 addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [stroke2 addLineToPoint:CGPointMake(335.01, 0)];
        [stroke2 addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [stroke2 addLineToPoint:CGPointMake(343, 41.99)];
        [stroke2 addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [stroke2 addLineToPoint:CGPointMake(7.99, 50)];
        [stroke2 addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [stroke2 addLineToPoint:CGPointMake(0, 8.01)];
        [stroke2 closePath];
        CGContextSaveGState(context);
        stroke2.usesEvenOddFillRule = YES;
        [UIColor.whiteColor setFill];
        [stroke2 fill];
        CGContextSaveGState(context);
        stroke2.lineWidth = 2;
        CGContextBeginPath(context);
        CGContextAddPath(context, stroke2.CGPath);
        CGContextAddRect(context, CGRectInset(stroke2.bounds, -20, -20));
        CGContextEOClip(context);
        [[UIColor colorWithWhite:0.067 alpha:0.1] setStroke];
        [stroke2 stroke];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        //! Password
        NSMutableAttributedString *password = [[NSMutableAttributedString alloc] initWithString:@"Password"];
        [password addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:14] range:NSMakeRange(0, password.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [password addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, password.length)];
        }
        [password addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, password.length)];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.6);
        CGContextBeginTransparencyLayer(context, nil);
        {
            [password drawAtPoint:CGPointMake(16, 15)];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Input
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 16, 275);
        
        //! Stroke
        UIBezierPath *stroke3 = [UIBezierPath bezierPath];
        [stroke3 moveToPoint:CGPointMake(0, 8.01)];
        [stroke3 addCurveToPoint:CGPointMake(7.99, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.59, 0)];
        [stroke3 addLineToPoint:CGPointMake(335.01, 0)];
        [stroke3 addCurveToPoint:CGPointMake(343, 8.01) controlPoint1:CGPointMake(339.42, 0) controlPoint2:CGPointMake(343, 3.58)];
        [stroke3 addLineToPoint:CGPointMake(343, 41.99)];
        [stroke3 addCurveToPoint:CGPointMake(335.01, 50) controlPoint1:CGPointMake(343, 46.42) controlPoint2:CGPointMake(339.41, 50)];
        [stroke3 addLineToPoint:CGPointMake(7.99, 50)];
        [stroke3 addCurveToPoint:CGPointMake(0, 41.99) controlPoint1:CGPointMake(3.58, 50) controlPoint2:CGPointMake(0, 46.42)];
        [stroke3 addLineToPoint:CGPointMake(0, 8.01)];
        [stroke3 closePath];
        CGContextSaveGState(context);
        stroke3.usesEvenOddFillRule = YES;
        [UIColor.whiteColor setFill];
        [stroke3 fill];
        CGContextSaveGState(context);
        stroke3.lineWidth = 2;
        CGContextBeginPath(context);
        CGContextAddPath(context, stroke3.CGPath);
        CGContextAddRect(context, CGRectInset(stroke3.bounds, -20, -20));
        CGContextEOClip(context);
        [[UIColor colorWithWhite:0.067 alpha:0.1] setStroke];
        [stroke3 stroke];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        //! Mr.Beans
        NSMutableAttributedString *mrBeans = [[NSMutableAttributedString alloc] initWithString:@"Mr.Beans"];
        [mrBeans addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:14] range:NSMakeRange(0, mrBeans.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [mrBeans addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mrBeans.length)];
        }
        [mrBeans addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.067 alpha:1] range:NSMakeRange(0, mrBeans.length)];
        CGContextSaveGState(context);
        [mrBeans drawAtPoint:CGPointMake(16, 15)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Status bar
    // Warning: New symbols are not supported.
    //! bsr
    // Warning: Image layers are not supported.
    
    CGContextRestoreGState(context);
}

+ (void)drawHome {
    [StyleKit drawHomeWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawHomeWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! Top Bar
    {
        CGContextSaveGState(context);
        
        //! Status Bar/Black/Base
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    //! #3
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 9, 496);
        
        //! Bitmap
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask = [UIBezierPath bezierPath];
            [mask moveToPoint:CGPointMake(0, 7.99)];
            [mask addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
            [mask addLineToPoint:CGPointMake(351, 0)];
            [mask addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
            [mask addLineToPoint:CGPointMake(359, 192.01)];
            [mask addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
            [mask addLineToPoint:CGPointMake(8, 200)];
            [mask addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
            [mask addLineToPoint:CGPointMake(0, 7.99)];
            [mask closePath];
            CGContextSaveGState(context);
            mask.usesEvenOddFillRule = YES;
            [[UIColor colorWithHue:0.134 saturation:0.757 brightness:1 alpha:1] setFill];
            [mask fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Mask
        UIBezierPath *mask2 = [UIBezierPath bezierPath];
        [mask2 moveToPoint:CGPointMake(0, 7.99)];
        [mask2 addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
        [mask2 addLineToPoint:CGPointMake(351, 0)];
        [mask2 addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
        [mask2 addLineToPoint:CGPointMake(359, 192.01)];
        [mask2 addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
        [mask2 addLineToPoint:CGPointMake(8, 200)];
        [mask2 addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
        [mask2 addLineToPoint:CGPointMake(0, 7.99)];
        [mask2 closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.5);
        CGContextBeginTransparencyLayer(context, nil);
        {
            mask2.usesEvenOddFillRule = YES;
            [[UIColor colorWithWhite:0.067 alpha:1] setFill];
            [mask2 fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! 866 Members
        NSMutableAttributedString *_866Members = [[NSMutableAttributedString alloc] initWithString:@"866 Members"];
        [_866Members addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:18] range:NSMakeRange(0, _866Members.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 26;
            paragraphStyle.minimumLineHeight = 26;
            [_866Members addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _866Members.length)];
        }
        [_866Members addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, _866Members.length)];
        CGContextSaveGState(context);
        [_866Members drawAtPoint:CGPointMake(119.5, 115)];
        CGContextRestoreGState(context);
        
        //! All Performers
        NSMutableAttributedString *allPerformers = [[NSMutableAttributedString alloc] initWithString:@"All Performers"];
        [allPerformers addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:36] range:NSMakeRange(0, allPerformers.length)];
        [allPerformers addAttribute:NSKernAttributeName value:@(-0.3) range:NSMakeRange(0, allPerformers.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 43;
            paragraphStyle.minimumLineHeight = 43;
            [allPerformers addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, allPerformers.length)];
        }
        [allPerformers addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, allPerformers.length)];
        CGContextSaveGState(context);
        [allPerformers drawAtPoint:CGPointMake(54, 68)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! #2
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 9, 288);
        
        //! Bitmap
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask3 = [UIBezierPath bezierPath];
            [mask3 moveToPoint:CGPointMake(0, 7.99)];
            [mask3 addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
            [mask3 addLineToPoint:CGPointMake(351, 0)];
            [mask3 addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
            [mask3 addLineToPoint:CGPointMake(359, 192.01)];
            [mask3 addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
            [mask3 addLineToPoint:CGPointMake(8, 200)];
            [mask3 addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
            [mask3 addLineToPoint:CGPointMake(0, 7.99)];
            [mask3 closePath];
            CGContextSaveGState(context);
            mask3.usesEvenOddFillRule = YES;
            [[UIColor colorWithHue:0.572 saturation:1 brightness:0.804 alpha:1] setFill];
            [mask3 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask3 addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Mask
        UIBezierPath *mask4 = [UIBezierPath bezierPath];
        [mask4 moveToPoint:CGPointMake(0, 7.99)];
        [mask4 addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
        [mask4 addLineToPoint:CGPointMake(351, 0)];
        [mask4 addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
        [mask4 addLineToPoint:CGPointMake(359, 192.01)];
        [mask4 addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
        [mask4 addLineToPoint:CGPointMake(8, 200)];
        [mask4 addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
        [mask4 addLineToPoint:CGPointMake(0, 7.99)];
        [mask4 closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.5);
        CGContextBeginTransparencyLayer(context, nil);
        {
            mask4.usesEvenOddFillRule = YES;
            [[UIColor colorWithWhite:0.067 alpha:1] setFill];
            [mask4 fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! 542 Members
        NSMutableAttributedString *_542Members = [[NSMutableAttributedString alloc] initWithString:@"542 Members"];
        [_542Members addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:18] range:NSMakeRange(0, _542Members.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 26;
            paragraphStyle.minimumLineHeight = 26;
            [_542Members addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _542Members.length)];
        }
        [_542Members addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, _542Members.length)];
        CGContextSaveGState(context);
        [_542Members drawAtPoint:CGPointMake(118, 129)];
        CGContextRestoreGState(context);
        
        //! Female
        NSMutableAttributedString *female = [[NSMutableAttributedString alloc] initWithString:@"Female"];
        [female addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:36] range:NSMakeRange(0, female.length)];
        [female addAttribute:NSKernAttributeName value:@(-0.3) range:NSMakeRange(0, female.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 43;
            paragraphStyle.minimumLineHeight = 43;
            [female addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, female.length)];
        }
        [female addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, female.length)];
        CGContextSaveGState(context);
        [female drawAtPoint:CGPointMake(117, 82)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! #1
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 9, 80);
        
        //! Bitmap
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask5 = [UIBezierPath bezierPath];
            [mask5 moveToPoint:CGPointMake(0, 7.99)];
            [mask5 addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
            [mask5 addLineToPoint:CGPointMake(351, 0)];
            [mask5 addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
            [mask5 addLineToPoint:CGPointMake(359, 192.01)];
            [mask5 addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
            [mask5 addLineToPoint:CGPointMake(8, 200)];
            [mask5 addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
            [mask5 addLineToPoint:CGPointMake(0, 7.99)];
            [mask5 closePath];
            CGContextSaveGState(context);
            mask5.usesEvenOddFillRule = YES;
            [[UIColor colorWithHue:0.417 saturation:0.988 brightness:0.678 alpha:1] setFill];
            [mask5 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask5 addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Mask
        UIBezierPath *mask6 = [UIBezierPath bezierPath];
        [mask6 moveToPoint:CGPointMake(0, 7.99)];
        [mask6 addCurveToPoint:CGPointMake(8, 0) controlPoint1:CGPointMake(0, 3.58) controlPoint2:CGPointMake(3.58, 0)];
        [mask6 addLineToPoint:CGPointMake(351, 0)];
        [mask6 addCurveToPoint:CGPointMake(359, 7.99) controlPoint1:CGPointMake(355.42, 0) controlPoint2:CGPointMake(359, 3.58)];
        [mask6 addLineToPoint:CGPointMake(359, 192.01)];
        [mask6 addCurveToPoint:CGPointMake(351, 200) controlPoint1:CGPointMake(359, 196.42) controlPoint2:CGPointMake(355.42, 200)];
        [mask6 addLineToPoint:CGPointMake(8, 200)];
        [mask6 addCurveToPoint:CGPointMake(0, 192.01) controlPoint1:CGPointMake(3.58, 200) controlPoint2:CGPointMake(0, 196.42)];
        [mask6 addLineToPoint:CGPointMake(0, 7.99)];
        [mask6 closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.5);
        CGContextBeginTransparencyLayer(context, nil);
        {
            mask6.usesEvenOddFillRule = YES;
            [[UIColor colorWithWhite:0.067 alpha:1] setFill];
            [mask6 fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! 324 Members
        NSMutableAttributedString *_324Members = [[NSMutableAttributedString alloc] initWithString:@"324 Members"];
        [_324Members addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:18] range:NSMakeRange(0, _324Members.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 26;
            paragraphStyle.minimumLineHeight = 26;
            [_324Members addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _324Members.length)];
        }
        [_324Members addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, _324Members.length)];
        CGContextSaveGState(context);
        [_324Members drawAtPoint:CGPointMake(118.5, 130)];
        CGContextRestoreGState(context);
        
        //! Male
        NSMutableAttributedString *male = [[NSMutableAttributedString alloc] initWithString:@"Male"];
        [male addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:36] range:NSMakeRange(0, male.length)];
        [male addAttribute:NSKernAttributeName value:@(-0.3) range:NSMakeRange(0, male.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 43;
            paragraphStyle.minimumLineHeight = 43;
            [male addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, male.length)];
        }
        [male addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, male.length)];
        CGContextSaveGState(context);
        [male drawAtPoint:CGPointMake(138, 83)];
        CGContextRestoreGState(context);
        
        //! Line
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(-0.5, -0.5)];
        [line addLineToPoint:CGPointMake(1, 1)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 180, 112);
        line.lineCapStyle = kCGLineCapSquare;
        line.lineWidth = 1;
        [[UIColor colorWithWhite:0.592 alpha:1] setStroke];
        [line stroke];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! icons8-user
    // Warning: Image layers are not supported.
    
    CGContextRestoreGState(context);
}

+ (void)drawWelcome {
    [StyleKit drawWelcomeWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawWelcomeWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! broadcast-broadcasting-camcorder-66134
    // Warning: Image layers are not supported.
    //! Sign up
    NSMutableAttributedString *signUp = [[NSMutableAttributedString alloc] initWithString:@"Sign up"];
    [signUp addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, signUp.length)];
    [signUp addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, signUp.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 22;
        paragraphStyle.minimumLineHeight = 22;
        [signUp addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, signUp.length)];
    }
    [signUp addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.587 saturation:1 brightness:1 alpha:1] range:NSMakeRange(0, signUp.length)];
    CGContextSaveGState(context);
    [signUp drawAtPoint:CGPointMake(172, 611)];
    CGContextRestoreGState(context);
    //! Button / big
    // Warning: New symbols are not supported.
    //! Rectangle
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 375, 234)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, 186);
    [UIColor.whiteColor setFill];
    [rectangle fill];
    CGContextRestoreGState(context);
    //! Discover stunt profe
    NSMutableAttributedString *discoverStuntProfe = [[NSMutableAttributedString alloc] initWithString:@"Discover stunt professionals from around the world"];
    [discoverStuntProfe addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:26] range:NSMakeRange(0, discoverStuntProfe.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 32;
        paragraphStyle.minimumLineHeight = 32;
        [discoverStuntProfe addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, discoverStuntProfe.length)];
    }
    CGContextSaveGState(context);
    [discoverStuntProfe drawInRect:CGRectMake(24, 469, 302, 106)];
    CGContextRestoreGState(context);
    //! bike-biker-extreme-19101
    // Warning: Image layers are not supported.
    //! Top Bar
    {
        CGContextSaveGState(context);
        
        //! Status Bar/Black/Base
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! artist-fakir-fire-34095
    // Warning: Image layers are not supported.
    //! crew-field-filming-275977
    // Warning: Image layers are not supported.
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    
    CGContextRestoreGState(context);
}

+ (void)drawMembers {
    [StyleKit drawMembersWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawMembersWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! Rectangle 2
    UIBezierPath *rectangle2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 82, 20) cornerRadius:8];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 9, 333);
    [[UIColor colorWithHue:0.329 saturation:0.51 brightness:0.795 alpha:1] setFill];
    [rectangle2 fill];
    CGContextRestoreGState(context);
    //! #4
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 193, 375);
        
        //! Rectangle 2
        UIBezierPath *rectangle4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 82, 20) cornerRadius:8];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 204);
        [[UIColor colorWithHue:1 saturation:0.871 brightness:0.939 alpha:1] setFill];
        [rectangle4 fill];
        CGContextRestoreGState(context);
        
        //! Probationary
        NSMutableAttributedString *probationary = [[NSMutableAttributedString alloc] initWithString:@"Probationary"];
        [probationary addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:12] range:NSMakeRange(0, probationary.length)];
        [probationary addAttribute:NSKernAttributeName value:@(-0.29) range:NSMakeRange(0, probationary.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [probationary addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, probationary.length)];
        }
        [probationary addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, probationary.length)];
        CGContextSaveGState(context);
        [probationary drawInRect:CGRectMake(5, 202, 70, 25)];
        CGContextRestoreGState(context);
        
        //! Guiomar Alonso
        NSMutableAttributedString *guiomarAlonso = [[NSMutableAttributedString alloc] initWithString:@"Rachelle Beinart"];
        [guiomarAlonso addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:15] range:NSMakeRange(0, guiomarAlonso.length)];
        [guiomarAlonso addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, guiomarAlonso.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [guiomarAlonso addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, guiomarAlonso.length)];
        }
        [guiomarAlonso addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.765 saturation:0.751 brightness:0.976 alpha:1] range:NSMakeRange(0, guiomarAlonso.length)];
        CGContextSaveGState(context);
        [guiomarAlonso drawAtPoint:CGPointMake(0, 178)];
        CGContextRestoreGState(context);
        
        //! Image
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 170, 170) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! icons8-circle
        // Warning: Image layers are not supported.
        
        CGContextRestoreGState(context);
    }
    //! #3
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 12, 375);
        
        //! Rectangle 2
        UIBezierPath *rectangle5 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 82, 20) cornerRadius:8];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 204);
        [[UIColor colorWithHue:0.092 saturation:0.871 brightness:0.939 alpha:1] setFill];
        [rectangle5 fill];
        CGContextRestoreGState(context);
        
        //! Intermediate
        NSMutableAttributedString *intermediate = [[NSMutableAttributedString alloc] initWithString:@"Intermediate"];
        [intermediate addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:12] range:NSMakeRange(0, intermediate.length)];
        [intermediate addAttribute:NSKernAttributeName value:@(-0.29) range:NSMakeRange(0, intermediate.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [intermediate addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, intermediate.length)];
        }
        [intermediate addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, intermediate.length)];
        CGContextSaveGState(context);
        [intermediate drawInRect:CGRectMake(5, 202, 70, 25)];
        CGContextRestoreGState(context);
        
        //! Guiomar Alonso
        NSMutableAttributedString *guiomarAlonso2 = [[NSMutableAttributedString alloc] initWithString:@"Guiomar Alonso"];
        [guiomarAlonso2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:15] range:NSMakeRange(0, guiomarAlonso2.length)];
        [guiomarAlonso2 addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, guiomarAlonso2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [guiomarAlonso2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, guiomarAlonso2.length)];
        }
        [guiomarAlonso2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.765 saturation:0.751 brightness:0.976 alpha:1] range:NSMakeRange(0, guiomarAlonso2.length)];
        CGContextSaveGState(context);
        [guiomarAlonso2 drawAtPoint:CGPointMake(0, 178)];
        CGContextRestoreGState(context);
        
        //! Image
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 170, 170) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask2 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask2 addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! icons8-circle
        // Warning: Image layers are not supported.
        
        CGContextRestoreGState(context);
    }
    //! #2
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 192, 130);
        
        //! icons8-circle
        // Warning: Image layers are not supported.
        
        //! Rectangle 2
        UIBezierPath *rectangle6 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 82, 20) cornerRadius:8];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 203);
        [[UIColor colorWithHue:1 saturation:0.777 brightness:0.865 alpha:1] setFill];
        [rectangle6 fill];
        CGContextRestoreGState(context);
        
        //! Probationary
        NSMutableAttributedString *probationary2 = [[NSMutableAttributedString alloc] initWithString:@"Probationary"];
        [probationary2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:12] range:NSMakeRange(0, probationary2.length)];
        [probationary2 addAttribute:NSKernAttributeName value:@(-0.29) range:NSMakeRange(0, probationary2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [probationary2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, probationary2.length)];
        }
        [probationary2 addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, probationary2.length)];
        CGContextSaveGState(context);
        [probationary2 drawInRect:CGRectMake(7, 202, 70, 25)];
        CGContextRestoreGState(context);
        
        //! Helen Bailey
        NSMutableAttributedString *helenBailey = [[NSMutableAttributedString alloc] initWithString:@"Helen Bailey"];
        [helenBailey addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:15] range:NSMakeRange(0, helenBailey.length)];
        [helenBailey addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, helenBailey.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [helenBailey addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, helenBailey.length)];
        }
        [helenBailey addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.765 saturation:0.751 brightness:0.976 alpha:1] range:NSMakeRange(0, helenBailey.length)];
        CGContextSaveGState(context);
        [helenBailey drawAtPoint:CGPointMake(1, 178)];
        CGContextRestoreGState(context);
        
        //! Image
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 1, 0);
            
            //! Mask
            UIBezierPath *mask3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 170, 170) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask3 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask3 addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        CGContextRestoreGState(context);
    }
    //! icons8-circle
    // Warning: Image layers are not supported.
    //! Line #1
    // Warning: New symbols are not supported.
    //! Top Bars / #2
    // Warning: New symbols are not supported.
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    //! Select | Filter
    NSMutableAttributedString *selectFilter = [[NSMutableAttributedString alloc] initWithString:@"Select | Filter"];
    [selectFilter addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:17] range:NSMakeRange(0, selectFilter.length)];
    [selectFilter addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, selectFilter.length)];
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 22;
        paragraphStyle.minimumLineHeight = 22;
        [selectFilter addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, selectFilter.length)];
    }
    [selectFilter addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.587 saturation:1 brightness:1 alpha:1] range:NSMakeRange(0, selectFilter.length)];
    CGContextSaveGState(context);
    [selectFilter drawAtPoint:CGPointMake(256, 46)];
    CGContextRestoreGState(context);
    //! #1
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 12, 130);
        
        //! Full Member
        NSMutableAttributedString *fullMember = [[NSMutableAttributedString alloc] initWithString:@"Full Member"];
        [fullMember addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:12] range:NSMakeRange(0, fullMember.length)];
        [fullMember addAttribute:NSKernAttributeName value:@(-0.29) range:NSMakeRange(0, fullMember.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [fullMember addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, fullMember.length)];
        }
        [fullMember addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, fullMember.length)];
        CGContextSaveGState(context);
        [fullMember drawInRect:CGRectMake(5, 202, 70, 25)];
        CGContextRestoreGState(context);
        
        //! Lucy Allen
        NSMutableAttributedString *lucyAllen = [[NSMutableAttributedString alloc] initWithString:@"Lucy Allen"];
        [lucyAllen addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Light" size:15] range:NSMakeRange(0, lucyAllen.length)];
        [lucyAllen addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, lucyAllen.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [lucyAllen addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lucyAllen.length)];
        }
        [lucyAllen addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:0.765 saturation:0.751 brightness:0.976 alpha:1] range:NSMakeRange(0, lucyAllen.length)];
        CGContextSaveGState(context);
        [lucyAllen drawAtPoint:CGPointMake(0, 178)];
        CGContextRestoreGState(context);
        
        //! Image
        {
            CGContextSaveGState(context);
            
            //! Mask
            UIBezierPath *mask4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 170, 170) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask4 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask4 addClip];
            
            //! Image
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! icons8-ok
        // Warning: Image layers are not supported.
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}

+ (void)drawProfileAbout {
    [StyleKit drawProfileAboutWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawProfileAboutWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! #3
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 672);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! Line dark
    // Warning: New symbols are not supported.
    //! User
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 70);
        
        //! Top Bar / Switcher
        // Warning: New symbols are not supported.
        
        //! Line dark
        // Warning: New symbols are not supported.
        
        //! Buttons / Rounded / 30px Stroked Blue
        // Warning: New symbols are not supported.
        
        //! Buttons / Rounded / 30px Stroked Blue
        // Warning: New symbols are not supported.
        
        //! Stunt Co-Ordinator,
        NSMutableAttributedString *stuntCoOrdinator = [[NSMutableAttributedString alloc] initWithString:@"Stunt Co-Ordinator, Driver"];
        [stuntCoOrdinator addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, stuntCoOrdinator.length)];
        [stuntCoOrdinator addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, stuntCoOrdinator.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [stuntCoOrdinator addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, stuntCoOrdinator.length)];
        }
        [stuntCoOrdinator addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, stuntCoOrdinator.length)];
        CGContextSaveGState(context);
        [stuntCoOrdinator drawInRect:CGRectMake(61, 142, 254, 25)];
        CGContextRestoreGState(context);
        
        //! John Hopkins
        NSMutableAttributedString *johnHopkins = [[NSMutableAttributedString alloc] initWithString:@"John Hopkins"];
        [johnHopkins addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".SFNSDisplay" size:26] range:NSMakeRange(0, johnHopkins.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 32;
            paragraphStyle.minimumLineHeight = 32;
            [johnHopkins addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, johnHopkins.length)];
        }
        CGContextSaveGState(context);
        [johnHopkins drawAtPoint:CGPointMake(105, 102)];
        CGContextRestoreGState(context);
        
        //! Userpic
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 143, 0);
            
            //! Mask
            UIBezierPath *mask = [UIBezierPath bezierPath];
            [mask moveToPoint:CGPointMake(45, 90)];
            [mask addCurveToPoint:CGPointMake(90, 45) controlPoint1:CGPointMake(69.85, 90) controlPoint2:CGPointMake(90, 69.85)];
            [mask addCurveToPoint:CGPointMake(45, 0) controlPoint1:CGPointMake(90, 20.15) controlPoint2:CGPointMake(69.85, 0)];
            [mask addCurveToPoint:CGPointMake(0, 45) controlPoint1:CGPointMake(20.15, 0) controlPoint2:CGPointMake(0, 20.15)];
            [mask addCurveToPoint:CGPointMake(45, 90) controlPoint1:CGPointMake(0, 69.85) controlPoint2:CGPointMake(20.15, 90)];
            [mask closePath];
            CGContextSaveGState(context);
            mask.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [mask fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Icons / Social Round / Accept
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! Top bar
    {
        CGContextSaveGState(context);
        
        //! Background
        UIBezierPath *background = [UIBezierPath bezierPath];
        [background moveToPoint:CGPointZero];
        [background addLineToPoint:CGPointMake(375, 0)];
        [background addLineToPoint:CGPointMake(375, 75)];
        [background addLineToPoint:CGPointMake(0, 75)];
        [background addLineToPoint:CGPointZero];
        [background closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0);
        CGContextBeginTransparencyLayer(context, nil);
        {
            background.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [background fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! Back
        NSMutableAttributedString *back = [[NSMutableAttributedString alloc] initWithString:@"Back"];
        [back addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:17] range:NSMakeRange(0, back.length)];
        [back addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, back.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [back addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, back.length)];
        }
        CGContextSaveGState(context);
        [back drawAtPoint:CGPointMake(31, 37)];
        CGContextRestoreGState(context);
        
        //! Back icon
        UIBezierPath *backIcon = [UIBezierPath bezierPath];
        [backIcon moveToPoint:CGPointMake(9.22, 0)];
        [backIcon addLineToPoint:CGPointMake(0, 9)];
        [backIcon addLineToPoint:CGPointMake(9.22, 18)];
        [backIcon addLineToPoint:CGPointMake(11, 16.23)];
        [backIcon addLineToPoint:CGPointMake(3.6, 9)];
        [backIcon addLineToPoint:CGPointMake(11, 1.78)];
        [backIcon addLineToPoint:CGPointMake(9.22, 0)];
        [backIcon closePath];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 12, 39);
        backIcon.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.963 saturation:0.107 brightness:0.137 alpha:1] setFill];
        [backIcon fill];
        CGContextRestoreGState(context);
        
        //! Status Bar/Black/Base
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    //! Sort by
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 381);
        
        //! Background
        UIBezierPath *background2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 375, 166)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 31);
        [UIColor.whiteColor setFill];
        [background2 fill];
        CGContextRestoreGState(context);
        
        //! 6ft 1in
        NSMutableAttributedString *_6ft1in = [[NSMutableAttributedString alloc] initWithString:@"6ft 1in"];
        [_6ft1in addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, _6ft1in.length)];
        [_6ft1in addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, _6ft1in.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [_6ft1in addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _6ft1in.length)];
        }
        CGContextSaveGState(context);
        [_6ft1in drawAtPoint:CGPointMake(313, 45)];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Hair Colour
        NSMutableAttributedString *hairColour = [[NSMutableAttributedString alloc] initWithString:@"Hair Colour"];
        [hairColour addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, hairColour.length)];
        [hairColour addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, hairColour.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [hairColour addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, hairColour.length)];
        }
        CGContextSaveGState(context);
        [hairColour drawAtPoint:CGPointMake(12, 104)];
        CGContextRestoreGState(context);
        
        //! Hair Length
        NSMutableAttributedString *hairLength = [[NSMutableAttributedString alloc] initWithString:@"Hair Length"];
        [hairLength addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, hairLength.length)];
        [hairLength addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, hairLength.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [hairLength addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, hairLength.length)];
        }
        CGContextSaveGState(context);
        [hairLength drawAtPoint:CGPointMake(9, 159)];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Height
        NSMutableAttributedString *height = [[NSMutableAttributedString alloc] initWithString:@"Height"];
        [height addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, height.length)];
        [height addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, height.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [height addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, height.length)];
        }
        CGContextSaveGState(context);
        [height drawAtPoint:CGPointMake(12, 49)];
        CGContextRestoreGState(context);
        
        //! Brown
        NSMutableAttributedString *brown = [[NSMutableAttributedString alloc] initWithString:@"Brown"];
        [brown addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, brown.length)];
        [brown addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, brown.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [brown addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, brown.length)];
        }
        CGContextSaveGState(context);
        [brown drawAtPoint:CGPointMake(313, 104)];
        CGContextRestoreGState(context);
        
        //! Short
        NSMutableAttributedString *short2 = [[NSMutableAttributedString alloc] initWithString:@"Short"];
        [short2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, short2.length)];
        [short2 addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, short2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [short2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, short2.length)];
        }
        CGContextSaveGState(context);
        [short2 drawAtPoint:CGPointMake(312, 159)];
        CGContextRestoreGState(context);
        
        //! Line
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(-0.5, -0.5)];
        [line addLineToPoint:CGPointMake(1, 1)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 47, 66);
        line.lineCapStyle = kCGLineCapSquare;
        line.lineWidth = 1;
        [[UIColor colorWithWhite:0.592 alpha:1] setStroke];
        [line stroke];
        CGContextRestoreGState(context);
        
        //! Line / Type #1
        // Warning: New symbols are not supported.
        
        //! About Me
        NSMutableAttributedString *aboutMe = [[NSMutableAttributedString alloc] initWithString:@"About Me"];
        [aboutMe addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, aboutMe.length)];
        [aboutMe addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, aboutMe.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [aboutMe addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, aboutMe.length)];
        }
        [aboutMe addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.025 brightness:0.459 alpha:1] range:NSMakeRange(0, aboutMe.length)];
        CGContextSaveGState(context);
        [aboutMe drawAtPoint:CGPointMake(11, 0)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! icons8-download
    // Warning: Image layers are not supported.
    //! Rectangle 3
    UIBezierPath *rectangle3 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 99, 24)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 132, 334);
    CGContextRestoreGState(context);
    //! Rectangle
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 112, 22)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 235, 334);
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
}

+ (void)drawProfile1Credits {
    [StyleKit drawProfile1CreditsWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawProfile1CreditsWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! #3
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 597);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Image
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 278, 0);
            
            //! Mask
            UIBezierPath *mask = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 85, 85) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! 2016
        NSMutableAttributedString *_2016 = [[NSMutableAttributedString alloc] initWithString:@"2016"];
        [_2016 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, _2016.length)];
        [_2016 addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, _2016.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [_2016 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _2016.length)];
        }
        [_2016 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, _2016.length)];
        CGContextSaveGState(context);
        [_2016 drawAtPoint:CGPointMake(12, 56)];
        CGContextRestoreGState(context);
        
        //! Casino Royale Stunt
        NSMutableAttributedString *casinoRoyaleStunt = [[NSMutableAttributedString alloc] initWithString:@"Casino Royale\nStunt Driver\n"];
        [casinoRoyaleStunt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, 14)];
        [casinoRoyaleStunt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(14, 12)];
        [casinoRoyaleStunt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(26, 1)];
        [casinoRoyaleStunt addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, casinoRoyaleStunt.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [casinoRoyaleStunt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, casinoRoyaleStunt.length)];
        }
        [casinoRoyaleStunt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.013 brightness:0.425 alpha:1] range:NSMakeRange(14, 12)];
        CGContextSaveGState(context);
        [casinoRoyaleStunt drawInRect:CGRectMake(12, 10, 253, 49)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! #2
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 493);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Image
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 278, 0);
            
            //! Mask
            UIBezierPath *mask2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 85, 85) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask2 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask2 addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! 2016
        NSMutableAttributedString *_5 = [[NSMutableAttributedString alloc] initWithString:@"2016"];
        [_5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, _5.length)];
        [_5 addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, _5.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [_5 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _5.length)];
        }
        [_5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, _5.length)];
        CGContextSaveGState(context);
        [_5 drawAtPoint:CGPointMake(12, 56)];
        CGContextRestoreGState(context);
        
        //! Avengers: Infinity W
        NSMutableAttributedString *avengersInfinityW = [[NSMutableAttributedString alloc] initWithString:@"Avengers: Infinity War\nStunt Co Ordinator\n"];
        [avengersInfinityW addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, 23)];
        [avengersInfinityW addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(23, 18)];
        [avengersInfinityW addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(41, 1)];
        [avengersInfinityW addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, avengersInfinityW.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [avengersInfinityW addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, avengersInfinityW.length)];
        }
        [avengersInfinityW addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.013 brightness:0.425 alpha:1] range:NSMakeRange(23, 18)];
        CGContextSaveGState(context);
        [avengersInfinityW drawInRect:CGRectMake(12, 10, 253, 49)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! #1
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 390);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Image
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 278, 0);
            
            //! Mask
            UIBezierPath *mask3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 85, 85) cornerRadius:4];
            CGContextSaveGState(context);
            [[UIColor colorWithHue:0.667 saturation:0.016 brightness:0.953 alpha:1] setFill];
            [mask3 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask3 addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! 2016
        NSMutableAttributedString *_6 = [[NSMutableAttributedString alloc] initWithString:@"2016"];
        [_6 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, _6.length)];
        [_6 addAttribute:NSKernAttributeName value:@(-0.24) range:NSMakeRange(0, _6.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 20;
            paragraphStyle.minimumLineHeight = 20;
            [_6 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _6.length)];
        }
        [_6 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, _6.length)];
        CGContextSaveGState(context);
        [_6 drawAtPoint:CGPointMake(12, 56)];
        CGContextRestoreGState(context);
        
        //! The Commuter Stunt C
        NSMutableAttributedString *theCommuterStuntC = [[NSMutableAttributedString alloc] initWithString:@"The Commuter\nStunt Co Ordinator\n"];
        [theCommuterStuntC addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, 13)];
        [theCommuterStuntC addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(13, 18)];
        [theCommuterStuntC addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(31, 1)];
        [theCommuterStuntC addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, theCommuterStuntC.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [theCommuterStuntC addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, theCommuterStuntC.length)];
        }
        [theCommuterStuntC addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.013 brightness:0.425 alpha:1] range:NSMakeRange(13, 18)];
        CGContextSaveGState(context);
        [theCommuterStuntC drawInRect:CGRectMake(12, 10, 253, 49)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Line dark
    // Warning: New symbols are not supported.
    //! Top bar
    {
        CGContextSaveGState(context);
        
        //! Background
        UIBezierPath *background = [UIBezierPath bezierPath];
        [background moveToPoint:CGPointZero];
        [background addLineToPoint:CGPointMake(375, 0)];
        [background addLineToPoint:CGPointMake(375, 75)];
        [background addLineToPoint:CGPointMake(0, 75)];
        [background addLineToPoint:CGPointZero];
        [background closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0);
        CGContextBeginTransparencyLayer(context, nil);
        {
            background.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [background fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! Back
        NSMutableAttributedString *back = [[NSMutableAttributedString alloc] initWithString:@"Back"];
        [back addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:17] range:NSMakeRange(0, back.length)];
        [back addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, back.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [back addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, back.length)];
        }
        CGContextSaveGState(context);
        [back drawAtPoint:CGPointMake(31, 37)];
        CGContextRestoreGState(context);
        
        //! Back icon
        UIBezierPath *backIcon = [UIBezierPath bezierPath];
        [backIcon moveToPoint:CGPointMake(9.22, 0)];
        [backIcon addLineToPoint:CGPointMake(0, 9)];
        [backIcon addLineToPoint:CGPointMake(9.22, 18)];
        [backIcon addLineToPoint:CGPointMake(11, 16.23)];
        [backIcon addLineToPoint:CGPointMake(3.6, 9)];
        [backIcon addLineToPoint:CGPointMake(11, 1.78)];
        [backIcon addLineToPoint:CGPointMake(9.22, 0)];
        [backIcon closePath];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 12, 39);
        backIcon.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.963 saturation:0.107 brightness:0.137 alpha:1] setFill];
        [backIcon fill];
        CGContextRestoreGState(context);
        
        //! Status Bar/Black/Base
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! icons8-download
    // Warning: Image layers are not supported.
    //! User
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 70);
        
        //! Top Bar / Switcher
        // Warning: New symbols are not supported.
        
        //! Line dark
        // Warning: New symbols are not supported.
        
        //! Buttons / Rounded / 30px Stroked Blue
        // Warning: New symbols are not supported.
        
        //! Stunt Co-Ordinator,
        NSMutableAttributedString *stuntCoOrdinator = [[NSMutableAttributedString alloc] initWithString:@"Stunt Co-Ordinator, Driver"];
        [stuntCoOrdinator addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, stuntCoOrdinator.length)];
        [stuntCoOrdinator addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, stuntCoOrdinator.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [stuntCoOrdinator addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, stuntCoOrdinator.length)];
        }
        [stuntCoOrdinator addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, stuntCoOrdinator.length)];
        CGContextSaveGState(context);
        [stuntCoOrdinator drawInRect:CGRectMake(61, 142, 254, 25)];
        CGContextRestoreGState(context);
        
        //! John Hopkins
        NSMutableAttributedString *johnHopkins = [[NSMutableAttributedString alloc] initWithString:@"John Hopkins"];
        [johnHopkins addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".SFNSDisplay" size:26] range:NSMakeRange(0, johnHopkins.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 32;
            paragraphStyle.minimumLineHeight = 32;
            [johnHopkins addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, johnHopkins.length)];
        }
        CGContextSaveGState(context);
        [johnHopkins drawAtPoint:CGPointMake(105, 102)];
        CGContextRestoreGState(context);
        
        //! Userpic
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 143, 0);
            
            //! Mask
            UIBezierPath *mask4 = [UIBezierPath bezierPath];
            [mask4 moveToPoint:CGPointMake(45, 90)];
            [mask4 addCurveToPoint:CGPointMake(90, 45) controlPoint1:CGPointMake(69.85, 90) controlPoint2:CGPointMake(90, 69.85)];
            [mask4 addCurveToPoint:CGPointMake(45, 0) controlPoint1:CGPointMake(90, 20.15) controlPoint2:CGPointMake(69.85, 0)];
            [mask4 addCurveToPoint:CGPointMake(0, 45) controlPoint1:CGPointMake(20.15, 0) controlPoint2:CGPointMake(0, 20.15)];
            [mask4 addCurveToPoint:CGPointMake(45, 90) controlPoint1:CGPointMake(0, 69.85) controlPoint2:CGPointMake(20.15, 90)];
            [mask4 closePath];
            CGContextSaveGState(context);
            mask4.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [mask4 fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask4 addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Icons / Social Round / Accept
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! Buttons / Rounded / 30px Stroked Blue
    // Warning: New symbols are not supported.
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    //! Rectangle
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 99, 24)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 18, 334);
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
}

+ (void)drawProfile1Skills {
    [StyleKit drawProfile1SkillsWithFrame:CGRectMake(0, 0, 375, 667) resizing:StyleKitResizingBehaviorAspectFit];
}
+ (void)drawProfile1SkillsWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);
    
    //! Background Color
    [UIColor.whiteColor setFill];
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    //! #3
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 672);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! Line dark
    // Warning: New symbols are not supported.
    //! User
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 70);
        
        //! Top Bar / Switcher
        // Warning: New symbols are not supported.
        
        //! Line dark
        // Warning: New symbols are not supported.
        
        //! Buttons / Rounded / 30px Stroked Blue
        // Warning: New symbols are not supported.
        
        //! Buttons / Rounded / 30px Stroked Blue
        // Warning: New symbols are not supported.
        
        //! Stunt Co-Ordinator,
        NSMutableAttributedString *stuntCoOrdinator = [[NSMutableAttributedString alloc] initWithString:@"Stunt Co-Ordinator, Driver"];
        [stuntCoOrdinator addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, stuntCoOrdinator.length)];
        [stuntCoOrdinator addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, stuntCoOrdinator.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [stuntCoOrdinator addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, stuntCoOrdinator.length)];
        }
        [stuntCoOrdinator addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.549 alpha:1] range:NSMakeRange(0, stuntCoOrdinator.length)];
        CGContextSaveGState(context);
        [stuntCoOrdinator drawInRect:CGRectMake(61, 142, 254, 25)];
        CGContextRestoreGState(context);
        
        //! John Hopkins
        NSMutableAttributedString *johnHopkins = [[NSMutableAttributedString alloc] initWithString:@"John Hopkins"];
        [johnHopkins addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".SFNSDisplay" size:26] range:NSMakeRange(0, johnHopkins.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            paragraphStyle.maximumLineHeight = 32;
            paragraphStyle.minimumLineHeight = 32;
            [johnHopkins addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, johnHopkins.length)];
        }
        CGContextSaveGState(context);
        [johnHopkins drawAtPoint:CGPointMake(105, 102)];
        CGContextRestoreGState(context);
        
        //! Userpic
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 143, 0);
            
            //! Mask
            UIBezierPath *mask = [UIBezierPath bezierPath];
            [mask moveToPoint:CGPointMake(45, 90)];
            [mask addCurveToPoint:CGPointMake(90, 45) controlPoint1:CGPointMake(69.85, 90) controlPoint2:CGPointMake(90, 69.85)];
            [mask addCurveToPoint:CGPointMake(45, 0) controlPoint1:CGPointMake(90, 20.15) controlPoint2:CGPointMake(69.85, 0)];
            [mask addCurveToPoint:CGPointMake(0, 45) controlPoint1:CGPointMake(20.15, 0) controlPoint2:CGPointMake(0, 20.15)];
            [mask addCurveToPoint:CGPointMake(45, 90) controlPoint1:CGPointMake(0, 69.85) controlPoint2:CGPointMake(20.15, 90)];
            [mask closePath];
            CGContextSaveGState(context);
            mask.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [mask fill];
            CGContextRestoreGState(context);
            
            //! Mask (Outline Mask)
            CGContextSaveGState(context);
            [mask addClip];
            
            //! Bitmap
            // Warning: Image layers are not supported.
            
            CGContextRestoreGState(context);
            // End Mask (Outline Mask)
            
            CGContextRestoreGState(context);
        }
        
        //! Icons / Social Round / Accept
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! Top bar
    {
        CGContextSaveGState(context);
        
        //! Background
        UIBezierPath *background = [UIBezierPath bezierPath];
        [background moveToPoint:CGPointZero];
        [background addLineToPoint:CGPointMake(375, 0)];
        [background addLineToPoint:CGPointMake(375, 75)];
        [background addLineToPoint:CGPointMake(0, 75)];
        [background addLineToPoint:CGPointZero];
        [background closePath];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0);
        CGContextBeginTransparencyLayer(context, nil);
        {
            background.usesEvenOddFillRule = YES;
            [UIColor.whiteColor setFill];
            [background fill];
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        //! Back
        NSMutableAttributedString *back = [[NSMutableAttributedString alloc] initWithString:@"Back"];
        [back addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".AppleSystemUIFont" size:17] range:NSMakeRange(0, back.length)];
        [back addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, back.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [back addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, back.length)];
        }
        CGContextSaveGState(context);
        [back drawAtPoint:CGPointMake(31, 37)];
        CGContextRestoreGState(context);
        
        //! Back icon
        UIBezierPath *backIcon = [UIBezierPath bezierPath];
        [backIcon moveToPoint:CGPointMake(9.22, 0)];
        [backIcon addLineToPoint:CGPointMake(0, 9)];
        [backIcon addLineToPoint:CGPointMake(9.22, 18)];
        [backIcon addLineToPoint:CGPointMake(11, 16.23)];
        [backIcon addLineToPoint:CGPointMake(3.6, 9)];
        [backIcon addLineToPoint:CGPointMake(11, 1.78)];
        [backIcon addLineToPoint:CGPointMake(9.22, 0)];
        [backIcon closePath];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 12, 39);
        backIcon.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.963 saturation:0.107 brightness:0.137 alpha:1] setFill];
        [backIcon fill];
        CGContextRestoreGState(context);
        
        //! Status Bar/Black/Base
        // Warning: New symbols are not supported.
        
        CGContextRestoreGState(context);
    }
    //! British-Stunt-Register_avatar_1520347266
    // Warning: Image layers are not supported.
    //! Sort by
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 381);
        
        //! Background
        UIBezierPath *background2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 375, 166)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 31);
        [UIColor.whiteColor setFill];
        [background2 fill];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Hand Gliding
        NSMutableAttributedString *handGliding = [[NSMutableAttributedString alloc] initWithString:@"Hand Gliding"];
        [handGliding addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, handGliding.length)];
        [handGliding addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, handGliding.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [handGliding addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, handGliding.length)];
        }
        CGContextSaveGState(context);
        [handGliding drawAtPoint:CGPointMake(12, 104)];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Aerial Work
        NSMutableAttributedString *aerialWork = [[NSMutableAttributedString alloc] initWithString:@"Aerial Work"];
        [aerialWork addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, aerialWork.length)];
        [aerialWork addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, aerialWork.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [aerialWork addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, aerialWork.length)];
        }
        CGContextSaveGState(context);
        [aerialWork drawAtPoint:CGPointMake(12, 49)];
        CGContextRestoreGState(context);
        
        //! Line
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(-0.5, -0.5)];
        [line addLineToPoint:CGPointMake(1, 1)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 47, 66);
        line.lineCapStyle = kCGLineCapSquare;
        line.lineWidth = 1;
        [[UIColor colorWithWhite:0.592 alpha:1] setStroke];
        [line stroke];
        CGContextRestoreGState(context);
        
        //! Line / Type #1
        // Warning: New symbols are not supported.
        
        //! Aerial Skills
        NSMutableAttributedString *aerialSkills = [[NSMutableAttributedString alloc] initWithString:@"Aerial Skills"];
        [aerialSkills addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, aerialSkills.length)];
        [aerialSkills addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, aerialSkills.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [aerialSkills addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, aerialSkills.length)];
        }
        [aerialSkills addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.025 brightness:0.459 alpha:1] range:NSMakeRange(0, aerialSkills.length)];
        CGContextSaveGState(context);
        [aerialSkills drawAtPoint:CGPointMake(11, 0)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! Sort by
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 559);
        
        //! Background
        UIBezierPath *background3 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 375, 166)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 38);
        [UIColor.whiteColor setFill];
        [background3 fill];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Hand Gliding
        NSMutableAttributedString *handGliding2 = [[NSMutableAttributedString alloc] initWithString:@"Hand Gliding"];
        [handGliding2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, handGliding2.length)];
        [handGliding2 addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, handGliding2.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [handGliding2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, handGliding2.length)];
        }
        CGContextSaveGState(context);
        [handGliding2 drawAtPoint:CGPointMake(12, 110)];
        CGContextRestoreGState(context);
        
        //! Line light
        // Warning: New symbols are not supported.
        
        //! Arrangement
        NSMutableAttributedString *arrangement = [[NSMutableAttributedString alloc] initWithString:@"Arrangement"];
        [arrangement addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:15] range:NSMakeRange(0, arrangement.length)];
        [arrangement addAttribute:NSKernAttributeName value:@(-0.36) range:NSMakeRange(0, arrangement.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [arrangement addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, arrangement.length)];
        }
        CGContextSaveGState(context);
        [arrangement drawAtPoint:CGPointMake(12, 56)];
        CGContextRestoreGState(context);
        
        //! Line
        UIBezierPath *line2 = [UIBezierPath bezierPath];
        [line2 moveToPoint:CGPointMake(-0.5, -0.5)];
        [line2 addLineToPoint:CGPointMake(1, 1)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 47, 73);
        line2.lineCapStyle = kCGLineCapSquare;
        line2.lineWidth = 1;
        [[UIColor colorWithWhite:0.592 alpha:1] setStroke];
        [line2 stroke];
        CGContextRestoreGState(context);
        
        //! Line / Type #1
        // Warning: New symbols are not supported.
        
        //! Combat Skills
        NSMutableAttributedString *combatSkills = [[NSMutableAttributedString alloc] initWithString:@"Combat Skills"];
        [combatSkills addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SFProText-Semibold" size:17] range:NSMakeRange(0, combatSkills.length)];
        [combatSkills addAttribute:NSKernAttributeName value:@(-0.41) range:NSMakeRange(0, combatSkills.length)];
        {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.maximumLineHeight = 22;
            paragraphStyle.minimumLineHeight = 22;
            [combatSkills addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, combatSkills.length)];
        }
        [combatSkills addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHue:1 saturation:0.026 brightness:0.459 alpha:1] range:NSMakeRange(0, combatSkills.length)];
        CGContextSaveGState(context);
        [combatSkills drawAtPoint:CGPointMake(12, 0)];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    //! icons8-download
    // Warning: Image layers are not supported.
    //! Rectangle 2
    UIBezierPath *rectangle2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 90, 22)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 23, 334);
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
}


#pragma mark - Canvas Images

//! All Views

+ (UIImage *)imageOfSignUp {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawSignUp];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfSignIn {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawSignIn];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfHome {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawHome];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfWelcome {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawWelcome];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfMembers {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawMembers];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfProfileAbout {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawProfileAbout];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfProfile1Credits {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawProfile1Credits];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfProfile1Skills {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 0);
    [StyleKit drawProfile1Skills];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Resizing Behavior

CGRect StyleKitResizingBehaviorApply(StyleKitResizingBehavior behavior, CGRect rect, CGRect target) {
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero)) {
        return rect;
    }
    
    CGSize scales = CGSizeZero;
    scales.width = ABS(target.size.width / rect.size.width);
    scales.height = ABS(target.size.height / rect.size.height);
    
    switch (behavior) {
        case StyleKitResizingBehaviorAspectFit: {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case StyleKitResizingBehaviorAspectFill: {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case StyleKitResizingBehaviorStretch:
            break;
        
        case StyleKitResizingBehaviorCenter: {
            scales.width = 1;
            scales.height = 1;
            break;
        }
    }
    
    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = target.origin.x + (target.size.width - result.size.width) / 2;
    result.origin.y = target.origin.y + (target.size.height - result.size.height) / 2;
    return result;
}


@end
