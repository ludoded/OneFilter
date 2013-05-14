//
//  OFSettingsViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFSettingsViewController.h"

#import "OFSettingsTableViewCell.h"

const int SETTINGS_NUMBER_OF_ROWS = 4;

@interface OFSettingsViewController ()

@end

@implementation OFSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Define the datasource and delegate of tableView
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
        case 0:
            cell.description.text = @"Start app in camera mode";
            break;
            
        case 1:
            cell.description.text = @"Save original photo";
            break;
            
        case 2:
            cell.description.text = @"Show watermark";
            break;
            
        case 3:
            cell.description.text = @"Show advertisments";
            break;
            
        default:
            cell.description.text = @"Start app in camera mode";
            break;
    }
    return cell;
}


#pragma mark IBAction s

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NO];
}

@end
