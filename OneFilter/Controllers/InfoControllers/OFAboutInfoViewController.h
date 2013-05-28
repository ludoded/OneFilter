//
//  OFAboutInfoViewController.h
//  OneFilter
//
//  Created by Aik Ampardjian on 27.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFAboutInfoViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)back:(UIButton *)sender;
- (IBAction)twitter:(id)sender;

@end
