//
//  OFBaseModalTableViewCell.m
//  OneFilter
//
//  Created by Aik Ampardjian on 26.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFBaseModalTableViewCell.h"

@implementation OFBaseModalTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _description.textColor = [UIColor colorWithRed:187.0f / 255.0f green:183.0f / 255.0f blue:183.0 / 255.0 alpha:1.0f];
    _description.font = [UIFont fontWithName:@"DIN-Bold" size:18];
}

@end
