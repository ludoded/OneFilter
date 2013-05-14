//
//  OFSettingsViewController.h
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFBaseViewController.h"

@interface OFSettingsViewController : OFBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)done:(id)sender;

@end
