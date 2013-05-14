//
//  OFAlertViewUI.h
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#ifndef OFAlertViewUI_h
#define OFAlertViewUI_h

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
#define NSTextAlignmentCenter       UITextAlignmentCenter
#define NSLineBreakByWordWrapping   UILineBreakModeWordWrap
#define NSLineBreakByClipping       UILineBreakModeClip

#endif

#ifndef IOS_LESS_THAN_6
#define IOS_LESS_THAN_6 !([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending)

#endif

#define NeedsLandscapePhoneTweaks (UIInterfaceOrientationIsLandscape ([[UIApplication sharedApplication] statusBarOrientation]) && UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)

// AlertView configuration

#define kAlertViewBounce                20
#define kAlertViewBorder                (NeedsLandscapePhoneTweaks ? 5 : 10)
#define kAlertButtonHeight              (NeedsLandscapePhoneTweaks ? 35 : 44)

#define kAlertViewTitleFont             [UIFont boldSystemFontOfSize:20]
#define kAlertViewTitleTextColor        [UIColor colorWithWhite: 244.0 / 255.0 alpha:1.0]
#define kAlertViewTitleShadowColor      [UIColor blackColor]
#define kAlertViewTitleShadowOffset     CGSizeMake(0, 0)

#define kAlertViewMessageFont           [UIFont boldSystemFontOfSize:18]
#define kAlertViewMessageTextColor      [UIColor colorWithWhite: 244.0 / 255.0 alpha:1.0]
#define kAlertViewMessageShadowColor    [UIColor blackColor]
#define kAlertViewMessageShadowOffset   CGSizeMake(0, 0)

#define kAlertViewButtonFont            [UIFont boldSystemFontOfSize:18]
#define kAlertViewButtonTextColor       [UIColor whiteColor]
#define kAlertViewButtonShadowColor     [UIColor blackColor]
#define kAlertViewButtonShadowOffset    CGSizeMake(0, 0)

#define kAlertViewBackground            @"alert-box-background.png"
#define kAlertViewBackgroundLandscape   @"alert-box-background.png"
#define kAlertViewBackgroundCapHeight   38

#endif