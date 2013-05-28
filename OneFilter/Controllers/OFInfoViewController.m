//
//  OFInfoViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFInfoViewController.h"

#import "OFInfoTableViewCell.h"

static int INFO_NUMBER_OF_ROWS = 9;

@interface OFInfoViewController ()

@end

@implementation OFInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    int row = indexPath.row;
    switch (row) {
        case kOFInfoCellTypeAbout:
            [self performSegueWithIdentifier:@"OFAboutInfoViewController" sender:nil];
            break;
        case kOFInfoCellTypeInstagram:

            break;
        case kOFInfoCellTypeFacebook:

            break;
        case kOFInfoCellTypeSupport:

            break;
        case kOFInfoCellTypeShareApp:

            break;
        case kOFInfoCellTypeTerms:

            break;
        case kOFInfoCellTypePrivacy:

            break;
        case kOFInfoCellTypeRateApp:

            break;
        case kOFInfoCellTypeMoreApps:

            break;
        default:

            break;
    }
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return INFO_NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OFInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OFInfoTableViewCell"];
    int row = indexPath.row;
    switch (row) {
        case kOFInfoCellTypeAbout:
            cell.description.text = @"About";
            break;
        case kOFInfoCellTypeInstagram:
            cell.description.text = @"Follow us on Instagram";
            break;
        case kOFInfoCellTypeFacebook:
            cell.description.text = @"Follow us on Facebook";
            break;
        case kOFInfoCellTypeSupport:
            cell.description.text = @"Support & Feedback";
            break;
        case kOFInfoCellTypeShareApp:
            cell.description.text = @"Share this App";
            break;
        case kOFInfoCellTypeTerms:
            cell.description.text = @"Terms of Service";
            break;
        case kOFInfoCellTypePrivacy:
            cell.description.text = @"Privacy Policy";
            break;
        case kOFInfoCellTypeRateApp:
            cell.description.text = @"Rate App";
            break;
        case kOFInfoCellTypeMoreApps:
            cell.description.text = @"More Apps";
            break;            
        default:
            cell.description.text = @"About";
            break;
    }
    
    return cell;
}

#pragma mark IBAction s
- (IBAction)done:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NO];
}
@end
