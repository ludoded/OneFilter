//
//  OFModel.m
//  OneFilter
//
//  Created by Aik Ampardjian on 11.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFModel.h"

@implementation NSArray (Reverse)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end

@implementation OFMainScreenModel

- (id)init
{
    self = [super init];
    if (self) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void)authorizeAssets
{
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (*stop) {
            return ;
        }
        _assetAuthorizationStatus = YES;
        NSLog(@"_assetAuthorizationStatus = %@", @"YES");
        *stop = TRUE;
    } failureBlock:^(NSError *error) {
        _assetAuthorizationStatus = NO;
        NSLog(@"_assetAuthorizationStatus = %@", @"NO");
    }];
}

-(void)pullOutImages
{
    _imageArray=[[NSArray alloc] init];
    _mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    _library = [[ALAssetsLibrary alloc] init];
    __block int startIndex;
    __block int i = 0;
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
            [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
            
            NSURL *url= (NSURL*) [[result defaultRepresentation]url];
            
            [_library assetForURL:url
                     resultBlock:^(ALAsset *asset) {
//                         if (i >= startIndex)
                             [_mutableArray addObject:[asset defaultRepresentation ]];
//                         NSLog(@"_mutableArray.count = %d", _mutableArray.count);
                         if (_mutableArray.count ==_numberOfAssets)
                         {
                             _imageArray=[[NSArray alloc] initWithArray:_mutableArray];
                             [self allPhotosCollected:_imageArray];
                         }
                         i++;
                     }
                    failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
            
        }
    };

    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        if(group != nil) {
            NSString *g=[NSString stringWithFormat:@"%@",group];
            NSLog(@"gg:%@",g);
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            _count=33;
            _numberOfAssets = [group numberOfAssets];
            int diff = _numberOfAssets - _count;
            startIndex = ( diff < 0) ? 0 : diff;
            NSLog(@"_numberOfAssets :%d", _numberOfAssets);
            NSLog(@"_count :%d", _count);
            NSLog(@"startIndex :%d", startIndex);
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [_library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}

-(void)allPhotosCollected:(NSArray*)imgArray
{
    NSLog(@"all pictures are %@",imgArray);
    [_delegate showPulledImages:[imgArray reversedArray]];
}

@end


static OFModel * _sharedInstance = nil;

@implementation OFModel

- (id)init
{
    self = [super init];
    if (self) {
        _mainModel = [[OFMainScreenModel alloc] init];
    }
    return self;
}

+ (OFModel *)sharedInastance
{
    if (!_sharedInstance) {
        _sharedInstance = [[OFModel alloc] init];
    }
    return _sharedInstance;
}

@end
