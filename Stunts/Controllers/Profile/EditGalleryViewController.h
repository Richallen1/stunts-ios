//
//  EditGalleryViewController.h
//  Stunts
//
//  Created by Richard Allen on 25/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditGalleryViewController : UIViewController

@property (nonatomic, weak) __block PFObject *profile;

@end