//
//  OFHomeViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 07.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFHomeViewController.h"
#import "OFAlertView.h"

#import <AssetsLibrary/AssetsLibrary.h>

static int count = 20;
const CGSize OF_GRID_ELEMENT_SIZE = {97, 97};


@interface OFHomeViewController () {
    __strong OFAlertView * alert;
    NSArray * imageArray;
    NSMutableArray * mutableArray;
    ALAssetsLibrary * library;
    OFModel * _model;
    OFMainScreenModel * _mainModel;
}

@end

@implementation OFHomeViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _model = [OFModel sharedInastance];
        _mainModel = _model.mainModel;
        imageArray = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self customizeAppearance];
}

#pragma mark - OFMainScreenUi

- (void)showPulledImages:(NSArray *)images
{
    imageArray = images;
    
//    [_gridView reloadData];
}

#pragma mark - Base Methods

- (void)customizeAppearance
{
    // background color
    self.view.backgroundColor = [UIColor colorWithRed:60.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0];
    
    // Setting gridView
    _gridView.dataSource = self;
    _gridView.delegate = self;
    _gridView.itemSpacing = 7;
    
    // get all pictures
    _mainModel.delegate = self;
    [_mainModel authorizeAssets];
    [_mainModel pullOutImages];
}

- (void)showAccessAlert
{
    alert = [OFAlertView alertWithTitle:@"" message:@"\"One Filter\" Would Like to Access Your Photos"];
    [alert setCancelButtonWithTitle:@"Don't Allow" block:^{
        NSLog(@"Don't allow");
    }];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"OK");
    }];
    [alert show];

}

#pragma mark GMGridViewDataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return imageArray.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation == (UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationLandscapeLeft) ) ? OF_GRID_ELEMENT_SIZE : OF_GRID_ELEMENT_SIZE;
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell * cell = [gridView dequeueReusableCellWithIdentifier:@"OF_GRIDVIEW_CELL"];
    if (!cell) {
        cell = [[GMGridViewCell alloc] init];
        cell.reuseIdentifier = @"OF_GRIDVIEW_CELL";
    }
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:(CGRect) {CGPointZero, OF_GRID_ELEMENT_SIZE}];
    imgView.image = [imageArray objectAtIndex:index];
    imgView.contentMode = UIViewContentModeCenter;
    cell.contentView = imgView;
    return cell;
}

@end
