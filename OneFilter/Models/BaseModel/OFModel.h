//
//  OFModel.h
//  OneFilter
//
//  Created by Aik Ampardjian on 11.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OFModel : NSObject {
}

@property (nonatomic, copy) UIImage * mainImage;

+ (OFModel *)sharedInastance;

@end
