//
//  OFAlertView.m
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFAlertView.h"
#import "OFAlertBackground.h"
#import "OFAlertViewUI.h"

@implementation OFAlertView

static UIImage * background = nil;
static UIImage * backgroundLandscape = nil;
static UIFont * titleFont = nil;
static UIFont * messageFont = nil;
static UIFont * buttonFont = nil;

+ (void)initialize
{
    if (self == [OFAlertView class]) {
        background = [[UIImage imageNamed: kAlertViewBackground] stretchableImageWithLeftCapWidth:0 topCapHeight:kAlertViewBackgroundCapHeight];
        
        backgroundLandscape = [[UIImage imageNamed:kAlertViewBackgroundLandscape] stretchableImageWithLeftCapWidth:0 topCapHeight:kAlertViewBackgroundCapHeight];
        
        titleFont = kAlertViewTitleFont;
        messageFont = kAlertViewMessageFont;
        buttonFont = kAlertViewButtonFont;
    }
}

+ (OFAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    return [[OFAlertView alloc] initWithTitle:title message:message];
}

+ (void)showInfoAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    OFAlertView * alert = [[OFAlertView alloc] initWithTitle:title message:message];
    [alert setCancelButtonWithTitle:@"Dismiss" block:nil];
    [alert show];
}

+ (void)showErrorAlert:(NSError *)error
{
    OFAlertView * alert = [[OFAlertView alloc] initWithTitle:@"Error Occured"
                                                     message:[NSString stringWithFormat:@"Operation failed: %@", error]];
    [alert setCancelButtonWithTitle:@"Dismiss" block:nil];
    [alert show];
}

- (void)addComponents:(CGRect)frame
{
    if (_title) {
        CGSize size = [_title sizeWithFont:titleFont
                         constrainedToSize:CGSizeMake(frame.size.width - kAlertViewBorder * 2, 1000)
                             lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel * labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewBorder, _height, frame.size.width - kAlertViewBorder * 2, size.height)];
        labelView.font = titleFont;
        labelView.numberOfLines = 0;
        labelView.lineBreakMode = NSLineBreakByWordWrapping;
        labelView.textColor = kAlertViewTitleTextColor;
        labelView.backgroundColor = [UIColor clearColor];
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.shadowColor = kAlertViewTitleShadowColor;
        labelView.shadowOffset = kAlertViewTitleShadowOffset;
        labelView.text = _title;
        [_view addSubview:labelView];
        
        _height += size.height + kAlertViewBorder;
    }
    
    if (_message) {
        CGSize size = [_message sizeWithFont:messageFont
                           constrainedToSize:CGSizeMake(frame.size.width - kAlertViewBorder * 2, 1000)
                               lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel * labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewBorder, _height, frame.size.width - kAlertViewBorder * 2, size.height)];
        labelView.font = messageFont;
        labelView.numberOfLines = 0;
        labelView.lineBreakMode = NSLineBreakByWordWrapping;
        labelView.textColor = kAlertViewMessageTextColor;
        labelView.backgroundColor = [UIColor clearColor];
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.shadowColor = kAlertViewMessageShadowColor;
        labelView.shadowOffset = kAlertViewMessageShadowOffset;
        labelView.text = _message;
        [_view addSubview:labelView];
        
        _height += size.height + kAlertViewBorder;
    }
}

- (void)setupDisplay
{
    [[_view subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    UIWindow *parentView = [OFAlertBackground sharedInstance];
    CGRect frame = parentView.bounds;
    frame.origin.x = floorf((frame.size.width - background.size.width) * .5);
    frame.size.width = background.size.width;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        frame.size.width += 150;
        frame.origin.x -= 75;
    }
    
    _view.frame = frame;
    
    _height = kAlertViewBorder + 15;
    
    if (NeedsLandscapePhoneTweaks) {
        _height -= 15; // landscape phones need to trimmed a bit
    }
    
    [self addComponents:frame];
    
    if (_shown)
        [self show];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    
    if (self) {
        _title = [title copy];
        _message = [message copy];
        
        _view = [[UIView alloc] init];
        _view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        _blocks = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupDisplay) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        
        if ([self class] == [OFAlertView class])
            [self setupDisplay];
        
        _vignetteBackground = NO;
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)addButtonWithTitle:(NSString *)title color:(NSString *)color block:(void (^)())block
{
    // _blocks is an array each element of also is an array with next element: 1) block, 2) title text, 3) color of text
    [_blocks addObject:[NSArray arrayWithObjects:
                        block ? [block copy] : [NSNull null],
                        title,
                        color,
                        nil]];
}

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title color:@"green" block:block];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title color:@"black" block:block];
}

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title color:@"red" block:block];
}

- (void)show
{
    _shown = YES;
    
    BOOL isSecondButton = NO;
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < _blocks.count; i++) {
        NSArray * block = [_blocks objectAtIndex:i];
        NSString * title = [block objectAtIndex:1];
        NSString * color = [block objectAtIndex:2];
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"alert-%@-button-normal.png",color]];
        UIImage * tappedImage = [UIImage imageNamed:[NSString stringWithFormat:@"alert-%@-button-tapped.png",color]];
        image = [image stretchableImageWithLeftCapWidth:(int)(image.size.width + 1) >> 1 topCapHeight:0];
        tappedImage = [tappedImage stretchableImageWithLeftCapWidth:(int)(tappedImage.size.width + 1) >> 1 topCapHeight:0];
        
        CGFloat maxHalfWidth = floorf((_view.bounds.size.width - kAlertViewBorder * 3) * .5);
        CGFloat width = _view.bounds.size.width - kAlertViewBorder * 2;
        CGFloat xOffset = kAlertViewBorder;
        if (isSecondButton){
            width = maxHalfWidth;
            xOffset = width + kAlertViewBorder * 2;
            isSecondButton = NO;
        } else if (i + 1 < _blocks.count) {
            // Another button
            // Check if fits the same line
            CGSize size = [title sizeWithFont:buttonFont
                                  minFontSize:10
                               actualFontSize:nil
                                     forWidth:_view.bounds.size.width - kAlertViewBorder * 2
                                lineBreakMode:NSLineBreakByClipping];
            
            if (size.width < maxHalfWidth - kAlertViewBorder) {
                // It might fit
                // Check next button
                
                NSArray * block2 = [_blocks objectAtIndex:i + 1];
                NSString * title2 = [block2 objectAtIndex:1];
                size = [title2 sizeWithFont:buttonFont
                                minFontSize:10
                             actualFontSize:nil
                                   forWidth:_view.bounds.size.width - kAlertViewBorder * 2
                              lineBreakMode:NSLineBreakByClipping];
                
                if (size.width < maxHalfWidth - kAlertViewBorder) {
                    isSecondButton = YES; // For Next iteration
                    width = maxHalfWidth;
                }
            }
        } else if (_blocks.count == 1) {
            // In this case the only button sizes according to the text
            CGSize size = [title sizeWithFont:buttonFont
                            minFontSize:10
                         actualFontSize:nil
                               forWidth:_view.bounds.size.width - kAlertViewBorder * 2
                          lineBreakMode:NSLineBreakByClipping];
            size.width = MAX(size.width, 80);
            if (size.width + 2 * kAlertViewBorder < width) {
                width = size.width + 2 * kAlertViewBorder;
                xOffset = floorf((_view.bounds.size.width - width) * .5);
            }
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xOffset, _height, width, kAlertButtonHeight);
        button.titleLabel.font = buttonFont;
        if (IOS_LESS_THAN_6) {
#pragma clan diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            button.titleLabel.minimumFontSize = 10;
        } else {
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.titleLabel.adjustsLetterSpacingToFitWidth = YES;
            button.titleLabel.minimumScaleFactor = .1;
        }
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.shadowOffset = kAlertViewButtonShadowOffset;
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:tappedImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:tappedImage forState:UIControlStateSelected];
        
        [button setTitleColor:kAlertViewButtonTextColor forState:UIControlStateNormal];
        [button setTitleColor:kAlertViewButtonTextColor forState:UIControlStateHighlighted];
        [button setTitleColor:kAlertViewButtonTextColor forState:UIControlStateSelected];
        
        [button setTitleShadowColor:kAlertViewButtonShadowColor forState:UIControlStateNormal];
        [button setTitleShadowColor:kAlertViewButtonShadowColor forState:UIControlStateHighlighted];
        [button setTitleShadowColor:kAlertViewButtonShadowColor forState:UIControlStateSelected];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateSelected];
        button.accessibilityLabel = title;
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_view addSubview:button];
        
        if (!isSecondButton)
            _height += kAlertButtonHeight + kAlertViewBorder;
        
        index++;
    }
    
    if (_height < background.size.height)
    {
        CGFloat offset = background.size.height - _height;
        _height = background.size.height;
        CGRect frame;
        for (NSUInteger i = 0; i < _blocks.count; i++) {
            UIButton * btn = (UIButton *)[_view viewWithTag:i + 1];
            frame = btn.frame;
            frame.origin.y += offset;
            btn.frame = frame;
        }
    }
    
    CGRect frame = _view.frame;
    frame.origin.y = - _height;
    frame.size.height = _height;
    _view.frame = frame;
    
    UIImageView * modalBackground = [[UIImageView alloc] initWithFrame:_view.bounds];
    
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        modalBackground.image = backgroundLandscape;
    else
        modalBackground.image = background;
    
    modalBackground.contentMode = UIViewContentModeScaleToFill;
    modalBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_view insertSubview:modalBackground atIndex:0];
    
    if (_backgroundImage){
        [OFAlertBackground sharedInstance].backgroundImage = _backgroundImage;
        _backgroundImage = nil;
    }
    
    [OFAlertBackground sharedInstance].vignetteBackground = _vignetteBackground;
    [[OFAlertBackground sharedInstance] addToMainWindow:_view];
    
    __block CGPoint center = _view.center;
    center.y = floorf([OFAlertBackground sharedInstance].bounds.size.height * .5) + kAlertViewBounce;
    
    _cancelBounce = NO;
    
    [UIView animateWithDuration:.4
                          delay:.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(){
                         [OFAlertBackground sharedInstance].alpha = 1.0f;
                         _view.center = center;
                     }
                     completion:^(BOOL finished) {
                         if (_cancelBounce)
                             return;
                         
                         [UIView animateWithDuration:.1
                                               delay:.0
                                             options:0
                                          animations:^{
                                              center.y -= kAlertViewBounce;
                                              _view.center = center;
                                          }
                                          completion:^(BOOL finished){
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"AlertViewFinishedAnimation" object:self];
                                          }];
                     }];
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    _shown = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (buttonIndex >= 0 && buttonIndex < [_blocks count])
    {
        id obj = [[_blocks objectAtIndex:buttonIndex] objectAtIndex:0];
        if (![obj isEqual:[NSNull null]]) {
            ((void(^)())obj)();
        }
    }
    
    if (animated)
    {
        [UIView animateWithDuration:.1
                              delay:.0
                            options:0
                         animations:^{
                             CGPoint center = _view.center;
                             center.y += 20;
                             _view.center = center;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:.4
                                                   delay:.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  CGRect frame = _view.frame;
                                                  frame.origin.y = -frame.size.height;
                                                  _view.frame = frame;
                                                  [[OFAlertBackground sharedInstance] reduceAlphaIfEmpty];
                                              }
                                              completion:^(BOOL finished) {
                                                  [[OFAlertBackground sharedInstance] removeView:_view];
                                              }];
                         }];
    } else {
        [[OFAlertBackground sharedInstance] removeView:_view];
    }
}


#pragma mark - IBAction s

- (void)buttonClicked:(id)sender
{
    int buttonIndex = [(UIButton *)sender tag] - 1;
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}













@end
