//
//  OFSettingsTableViewCell.h
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFSettingsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * description;
@property (nonatomic, weak) IBOutlet UISwitch * switcher;

@end
