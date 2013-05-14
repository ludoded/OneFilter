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

static int count = 0;

@interface OFHomeViewController () {
    __strong OFAlertView * alert;
    NSArray * imageArray;
    NSMutableArray * mutableArray;
    ALAssetsLibrary * library;
}

@end

@implementation OFHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self customizeAppearance];
}

#pragma mark - Base Methods

- (void)customizeAppearance
{
    // background color
    self.view.backgroundColor = [UIColor colorWithRed:60.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0];
    
    // Alert View
//    [self showAccessAlert]; //TODO
    
    // get all pictures
    [self getAllPictures];
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

-(void)getAllPictures
{
    imageArray=[[NSArray alloc] init];
    mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (*stop) {
            return ;
        }
        // TODO : access granted
        *stop = TRUE;
    } failureBlock:^(NSError *error) {
        // TODO: User denied access. Tell them we can't do anything.
    }];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             if ([mutableArray count]==count)
                             {
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 [self allPhotosCollected:imageArray];
                             }
                         }
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}

-(void)allPhotosCollected:(NSArray*)imgArray
{
    //write your code here after getting all the photos from library...
    NSLog(@"all pictures are %@",imgArray);
}

@end
