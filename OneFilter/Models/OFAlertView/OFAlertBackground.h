//
//  OFAlertBackground.h
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFAlertBackground : UIWindow {
    @private
    UIWindow *_previousKeyWindow;
}

+ (OFAlertBackground *)sharedInstance;

- (void)addToMainWindow:(UIView *)view;
- (void)reduceAlphaIfEmpty;
- (void)removeView:(UIView *)view;

@property (nonatomic, strong) UIImage * backgroundImage;
@property (nonatomic, readwrite) BOOL vignetteBackground;

@end
