//
//  OFModel.m
//  OneFilter
//
//  Created by Aik Ampardjian on 11.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFModel.h"


static OFModel * _sharedInstance = nil;

@implementation OFModel

+ (OFModel *)sharedInastance
{
    if (!_sharedInstance) {
        _sharedInstance = [[OFModel alloc] init];
    }
    return _sharedInstance;
}

@end
