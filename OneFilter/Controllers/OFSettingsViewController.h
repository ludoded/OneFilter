//
//  OFSettingsViewController.h
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFBaseViewController.h"

typedef enum OFSettingCells
{
    kOFSettingCellTypeCameraMode = 0,
    kOFSettingCellTypeSaveOriginal,
    kOFSettingCellTypeShowWatermark,
    kOFSettingCellTypeShowAdvertisments,
    kOFSettingCellTypeNone
} OFSettingCellType;

@interface OFSettingsViewController : OFBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

- (IBAction)done:(id)sender;

@end
