//
//  OFAlertView.h
//  OneFilter
//
//  Created by Aik Ampardjian on 09.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFAlertView : NSObject {
    @protected
    UIView *_view;
    NSMutableArray *_blocks;
    CGFloat _height;
    NSString *_title;
    NSString *_message;
    BOOL _shown;
    BOOL _cancelBounce;
}

+ (OFAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showInfoAlertViewWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showErrorAlert:(NSError *)error;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)setDestructiveButtonWithTitle:(NSString *)title block: (void (^)())block;
- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title color:(NSString *)color block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addComponents:(CGRect)frame;

- (void)show;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
- (void)setupDisplay;

@property (nonatomic, strong) UIImage * backgroundImage;
@property (nonatomic, readonly) UIView * view;
@property (nonatomic) BOOL vignetteBackground;

@end
