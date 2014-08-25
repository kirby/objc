//
//  ViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "ViewController.h"
#import "GitHubController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    GitHubController *gitHubController;
    NSMutableArray *endpoints;
    NSMutableArray *segues;
}
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    gitHubController = [[GitHubController alloc] init];
    [self setupEndpoints];
    [self setupSegues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupEndpoints {
    endpoints = [[NSMutableArray alloc] init];
    [endpoints addObject: @"My Repos"];
    [endpoints addObject: @"My Followers"];
    [endpoints addObject: @"Search"];
}

-(void)setupSegues {
    segues = [[NSMutableArray alloc] init];
    [segues addObject:@"ShowMyRepos"];
    [segues addObject:@"ShowMyFollowers"];
    [segues addObject:@"ShowSearchResults"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return endpoints.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"GitHubEndpointCell"];
    
    cell.textLabel.text = endpoints[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected tableview row is %ld",(long)indexPath.row);
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ShowSearchResults" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end