//
//  OFSettingsViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFSettingsViewController.h"

#import "OFSettingsTableViewCell.h"

#import "TTFadeSwitch.h"

const int SETTINGS_NUMBER_OF_ROWS = 4;

@interface OFSettingsViewController () {
    NSUserDefaults * _userDefaults;
}

@end

@implementation OFSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Define the datasource and delegate of tableView
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _userDefaults = [NSUserDefaults standardUserDefaults];
}

#pragma mark Custom Methods

- (TTFadeSwitch *)getFadeSwitchWithTag:(OFSettingCellType)cellType
{
    TTFadeSwitch *fadeLabelSwitchLabel = [[TTFadeSwitch alloc] initWithFrame:CGRectMake(237, 8, 77, 28)];
    fadeLabelSwitchLabel.thumbImage = [UIImage imageNamed:@"on-off-toggle-normal"];
    fadeLabelSwitchLabel.trackMaskImage = [UIImage imageNamed:@"on-toggle"];
    fadeLabelSwitchLabel.thumbHighlightImage = [UIImage imageNamed:@"on-off-toggle-tapped"];
    fadeLabelSwitchLabel.trackImageOn = [UIImage imageNamed:@"on-toggle"];
    fadeLabelSwitchLabel.trackImageOff = [UIImage imageNamed:@"off-toggle"];
    fadeLabelSwitchLabel.onLabel.font = [UIFont boldSystemFontOfSize:11];
    fadeLabelSwitchLabel.offLabel.font = [UIFont boldSystemFontOfSize:11];
    fadeLabelSwitchLabel.onLabel.textColor = [UIColor whiteColor];
    fadeLabelSwitchLabel.offLabel.textColor = [UIColor whiteColor];
    fadeLabelSwitchLabel.onLabel.shadowColor = [UIColor colorWithRed:0.121569 green:0.600000 blue:0.454902 alpha:1.0];
    fadeLabelSwitchLabel.offLabel.shadowColor = [UIColor colorWithRed:0.796078 green:0.211765 blue:0.156863 alpha:1.0];
    fadeLabelSwitchLabel.onLabel.shadowOffset = CGSizeMake(0, 1.0);
    fadeLabelSwitchLabel.offLabel.shadowOffset = CGSizeMake(0, 1.0);
    fadeLabelSwitchLabel.thumbInsetX = -3.0;
    fadeLabelSwitchLabel.thumbOffsetY = 0.0;
    fadeLabelSwitchLabel.tag = cellType;
    fadeLabelSwitchLabel.on = [self getBoolStateForSwitchControl:cellType];
    [fadeLabelSwitchLabel addTarget:self action:@selector(fadeSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    return fadeLabelSwitchLabel;
}

- (NSString *)getKeyFromCellType:(OFSettingCellType)cellType
{
    NSString * key = @"";
    switch (cellType) {
        case kOFSettingCellTypeCameraMode:
            key = @"kOFSettingCellTypeCameraMode";
            break;
        case kOFSettingCellTypeSaveOriginal:
            key = @"kOFSettingCellTypeSaveOriginal";
            break;
        case kOFSettingCellTypeShowWatermark:
            key = @"kOFSettingCellTypeShowWatermark";
            break;
        case kOFSettingCellTypeShowAdvertisments:
            key = @"kOFSettingCellTypeShowAdvertisments";
            break;
        default:
            key = @"kOFSettingCellTypeCameraMode";
            break;
    }
    return key;
}

- (BOOL)getBoolStateForSwitchControl:(OFSettingCellType)cellType
{
    return [_userDefaults boolForKey:[self getKeyFromCellType:cellType]];
}

#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SETTINGS_NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OFSettingsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OFSettingsTableViewCell"];
    int row = indexPath.row;
    switch (row) {
        case kOFSettingCellTypeCameraMode:
            cell.description.text = @"Start app in camera mode";
            break;
            
        case kOFSettingCellTypeSaveOriginal:
            cell.description.text = @"Save original photo";
            break;
            
        case kOFSettingCellTypeShowWatermark:
            cell.description.text = @"Show watermark";
            break;
            
        case kOFSettingCellTypeShowAdvertisments:
            cell.description.text = @"Show advertisments";
            break;
            
        default:
            cell.description.text = @"Start app in camera mode";
            break;
    }
    
    [cell addSubview:[self getFadeSwitchWithTag:row]]; // Adding switch control
    
    return cell;
}


#pragma mark IBAction s

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void)fadeSwitchValueChanged:(TTFadeSwitch *)sender
{
    NSString * key = [self getKeyFromCellType:sender.tag];
    [_userDefaults setBool:sender.on forKey:key];
}

@end
