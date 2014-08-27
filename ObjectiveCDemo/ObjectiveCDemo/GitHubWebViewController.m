//
//  GitHubWebViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/27/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

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
    NSURL *githuburl = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:githuburl];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
