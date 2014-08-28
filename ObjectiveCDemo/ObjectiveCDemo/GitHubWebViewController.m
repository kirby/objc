//
//  GitHubWebViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/27/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "GitHubWebViewController.h"

@interface GitHubWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GitHubWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:_webView.frame];
    [_webView removeFromSuperview];
    
    [self.view addSubview:webView];
    
    NSURL *githuburl = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:githuburl];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
