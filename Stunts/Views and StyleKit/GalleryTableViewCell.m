//
//  GalleryTableViewCell.m
//  Stunts
//
//  Created by Richard Allen on 22/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "GalleryTableViewCell.h"

@implementation GalleryTableViewCell
@synthesize noImageLabel;
@synthesize img1;
@synthesize img2;
@synthesize img3;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
