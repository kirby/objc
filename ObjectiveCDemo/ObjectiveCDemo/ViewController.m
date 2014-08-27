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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupEndpoints];
    [self setupSegues];
    gitHubController = [GitHubController sharedController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [endpoints addObject: @"Search Users"];
}

-(void)setupSegues {
    segues = [[NSMutableArray alloc] init];
    [segues addObject:@"ShowMyRepos"];
    [segues addObject:@"ShowMyFollowers"];
    [segues addObject:@"ShowSearchResults"];
    [segues addObject:@"ShowSearchUsers"];
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
//    NSLog(@"selected tableview row is %ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:segues[indexPath.row] sender:self];

}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//}

@end
