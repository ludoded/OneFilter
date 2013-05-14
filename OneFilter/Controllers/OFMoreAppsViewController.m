//
//  OFMoreAppsViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFMoreAppsViewController.h"

#import <QuartzCore/QuartzCore.h>

const int MORE_APPS_NUMBER_OF_ROWS = 11;

@interface OFMoreAppsViewController ()

@end

@implementation OFMoreAppsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Define the Datasource and Delegate of tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MORE_APPS_NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OFMoreAppsTableViewCell"];
    int row = indexPath.row;
    if (fmod(row, 2) == 0) {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

#pragma mark IBAction s

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
