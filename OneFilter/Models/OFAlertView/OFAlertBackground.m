//
//  OFAlertBackground.m
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFAlertBackground.h"

@implementation OFAlertBackground

static OFAlertBackground *_sharedInstance = nil;

+ (OFAlertBackground *)sharedInstance
{
    @synchronized(self) {
        if (!_sharedInstance) {
            _sharedInstance = [[OFAlertBackground alloc] init];
        }
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!_sharedInstance) {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    NSAssert(NO, @"[OFAlertBackground alloc] explicitly called on singleton class.");
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)setRotation: (NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if (
        (UIInterfaceOrientationIsLandscape(orientation) && orientationFrame.size.height > orientationFrame.size.width) ||
        (UIInterfaceOrientationIsPortrait(orientation) && orientationFrame.size.width > orientationFrame.size.height)
        ) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    self.transform = CGAffineTransformIdentity;
    self.frame = orientationFrame;
    
    CGFloat posY = orientationFrame.size.height / 2;
    CGFloat posX = orientationFrame.size.width / 2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(posX, orientationFrame.size.height - posY);
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI_2;
            newCenter = CGPointMake(posY, posX);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI_2;
            newCenter = CGPointMake(orientationFrame.size.height - posY, posX);
            break;
            
        case UIInterfaceOrientationPortrait:
            rotateAngle = .0;
            newCenter = CGPointMake(posX, posY);
            break;
            
        default:
            rotateAngle = .0;
            newCenter = CGPointMake(posX, posY);
            break;
    }
    
    self.transform = CGAffineTransformMakeRotation(rotateAngle);
    self.center = newCenter;
    
    [self setNeedsDisplay];
    [self layoutSubviews];
}

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar;
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithWhite:.0 alpha:.5]; //Black semi-color background
        self.vignetteBackground = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRotation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        
        [self setRotation:nil];
    }
    return self;
}

- (void)addToMainWindow:(UIView *)view
{
    [self setRotation:nil];
    
    if ([self.subviews containsObject:view])
        return;
    
    if (self.hidden) {
        _previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
        self.alpha = .0f;
        self.hidden = NO;
        [self makeKeyWindow];
    }
    
    // Enable interaction in case something had been added to this window
    self.userInteractionEnabled = YES;
    
    if (self.subviews.count > 0)
        ((UIView *)[self.subviews lastObject]).userInteractionEnabled = NO;
    
    if (_backgroundImage) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:_backgroundImage];
        backgroundView.frame = self.bounds;
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:backgroundView];
        _backgroundImage = nil;
    }
    
    [self addSubview:view];
}

- (void)reduceAlphaIfEmpty
{
    if (self.subviews.count == 1 ||
        (self.subviews.count == 2 && [[self.subviews objectAtIndex:0] isKindOfClass:[UIImageView class]])) {
        self.alpha = .0f;
        self.userInteractionEnabled = NO;
    }
}

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];
    
    UIView * topView = [self.subviews lastObject];
    if ([topView isKindOfClass:[UIImageView class]]) {
        [topView removeFromSuperview];
    }
    
    if (self.subviews.count == 0) {
        self.hidden = YES;
        [_previousKeyWindow makeKeyWindow];
    } else {
        ((UIView *)[self.subviews lastObject]).userInteractionEnabled = YES;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (_backgroundImage || !_vignetteBackground)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    size_t locationCount = 2;
    CGFloat locations[2] = {.0f, 1.0f};
    CGFloat colors[8] = {.0f, .0f, .0f, .0f, .0f, .0f, .0f, .75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationCount);
    CGColorSpaceRelease(colorSpace);
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    float radius = MIN(self.bounds.size.width, self.bounds.size.height);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}


@end
