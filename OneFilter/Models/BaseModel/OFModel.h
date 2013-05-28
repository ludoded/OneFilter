//
//  OFModel.h
//  OneFilter
//
//  Created by Aik Ampardjian on 11.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol OFMainScreenUi <NSObject>

- (void)showPulledImages:(NSArray *)images;

@end

@interface OFMainScreenModel : NSObject {
    ALAssetsLibrary * _library;
    NSArray * _imageArray;
    NSMutableArray * _mutableArray;
    int _count;
    int _numberOfAssets;
}

@property (nonatomic, assign) BOOL assetAuthorizationStatus;
@property (nonatomic, copy) UIImage * mainImage;
@property (nonatomic, weak) id<OFMainScreenUi> delegate;

- (void)authorizeAssets;
- (void)pullOutImages;

@end

@interface OFModel : NSObject {
}

@property (nonatomic, strong) OFMainScreenModel * mainModel;

+ (OFModel *)sharedInastance;

@end
