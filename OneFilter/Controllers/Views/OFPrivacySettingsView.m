//
//  OFPrivacySettingsView.m
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFPrivacySettingsView.h"

@implementation OFPrivacySettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self customization];
}

- (void)customization
{
    // adjust new fonts to labels and change their color.
    _titleLabel.textColor = [UIColor colorWithRed:188.0 / 255.0 green:185.0 / 255.0 blue:185.0 / 255.0 alpha:1.0];
    _titleLabel.font = [UIFont fontWithName:@"DIN Black" size:17];
    _firstLabel.textColor = _secondLabel.textColor = _thirdLabel.textColor = [UIColor colorWithRed:149.0 / 255.0 green:144.0 / 255.0 blue:144.0 / 255.0 alpha:1.0];
    _firstLabel.font      = _secondLabel.font      = _thirdLabel.font      = [UIFont fontWithName:@"DIN Medium" size:18];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
