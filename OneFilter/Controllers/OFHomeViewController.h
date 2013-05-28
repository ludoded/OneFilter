//
//  OFHomeViewController.h
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFBaseViewController.h"
#import "OFModel.h"
#import "GMGridView.h"

@interface OFHomeViewController : OFBaseViewController <OFMainScreenUi, GMGridViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet GMGridView *gridView;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end
