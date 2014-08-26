//
//  MyFollowersViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "MyFollowersViewController.h"
#import "GitHubController.h"
#import "GitHubMyFollowers.h"

@interface MyFollowersViewController ()<UITableViewDataSource>
{
    GitHubController *gitHubController;
    NSMutableArray *gitHubSearchResults;
    __weak IBOutlet UITableView *tableView;
}
@end

@implementation MyFollowersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gitHubController = [[GitHubController alloc] init];
    gitHubSearchResults = [[NSMutableArray alloc] init];
    
    [gitHubController fetchMyFollowers:@"TOKEN" completion:^(NSMutableArray *results) {
        gitHubSearchResults = results;
        [tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gitHubSearchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFollowersCell"];
    
    GitHubMyFollowers *result = [gitHubSearchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = result.login;
    
    return cell;
}

@end
