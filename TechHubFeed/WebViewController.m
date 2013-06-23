//
//  WebViewController.m
//
//  Created by Axel Rivera on 9/7/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "WebViewController.h"

#import <Social/Social.h>

@interface WebViewController () <UIWebViewDelegate, UIActionSheetDelegate>

@end

@implementation WebViewController

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        self.title = dictionary[@"title"];
        _actionString = dictionary[@"url"];
        _dictionary = dictionary;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(shareAction:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadWebView:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
}

#pragma mark - Selector Actions

- (void)reloadWebView:(id)sender
{
    NSURL *webURL = [NSURL URLWithString:self.actionString];
    if (webURL) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:webURL];
        [self.webView loadRequest:request];
    }
}

- (void)shareAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Share...";
    actionSheet.delegate = self;

    NSInteger cancelIndex = 0;

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        [actionSheet addButtonWithTitle:@"Twitter"];
        cancelIndex++;
    }

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        [actionSheet addButtonWithTitle:@"Facebook"];
        cancelIndex++;
    }

    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = cancelIndex;

    [actionSheet showInView:self.view];
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];

    NSString *text = self.dictionary[@"title"];
    NSString *URLString = self.dictionary[@"url"];

    if ([title isEqualToString:@"Twitter"]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        NSURL *URL = [NSURL URLWithString:URLString];
        [tweetSheet addURL:URL];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    } else if ([title isEqualToString:@"Facebook"]) {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

        [fbSheet setInitialText:text];
        [fbSheet addURL:[NSURL URLWithString:URLString]];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
}

@end
