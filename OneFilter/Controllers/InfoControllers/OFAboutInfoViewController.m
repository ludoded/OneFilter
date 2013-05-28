//
//  OFAboutInfoViewController.m
//  OneFilter
//
//  Created by Aik Ampardjian on 27.05.13.
//  Copyright (c) 2013 Jordan Price. All rights reserved.
//

#import "OFAboutInfoViewController.h"

@interface OFAboutInfoViewController ()

@end

@implementation OFAboutInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setting Html
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"a19text" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_webView loadHTMLString:htmlString baseURL:baseURL];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    
    // Setting scrollView
    _scrollView.contentSize = CGSizeMake(320, 1060);
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)twitter:(id)sender {
    UIApplication * _app = [UIApplication sharedApplication];
    BOOL canOpen = [_app canOpenURL:[NSURL URLWithString:@"twitter://"]];
    if (canOpen) [_app openURL:[NSURL URLWithString:@"twitter://user?screen_name=jor193"]];
    else [_app openURL:[NSURL URLWithString:@"http://twitter.com/jor193"]];
}
@end
