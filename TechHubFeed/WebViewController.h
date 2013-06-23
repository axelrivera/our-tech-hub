//
//  WebViewController.h
//
//  Created by Axel Rivera on 9/7/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *actionString;
@property (strong, nonatomic) NSDictionary *dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
