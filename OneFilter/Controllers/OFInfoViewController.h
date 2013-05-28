//
//  OFInfoViewController.h
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFBaseViewController.h"

typedef enum {
    kOFInfoCellTypeAbout = 0,
    kOFInfoCellTypeInstagram,
    kOFInfoCellTypeFacebook,
    kOFInfoCellTypeSupport,
    kOFInfoCellTypeShareApp,
    kOFInfoCellTypeTerms,
    kOFInfoCellTypePrivacy,
    kOFInfoCellTypeRateApp,
    kOFInfoCellTypeMoreApps,
    kOFInfoCellTypeNone
}OFInfoCellType;

@interface OFInfoViewController : OFBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

- (IBAction)done:(UIButton *)sender;

@end
