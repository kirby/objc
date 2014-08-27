//
//  MyReposViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "MyReposViewController.h"
#import "GitHubController.h"
#import "GitHubMyRepos.h"

@interface MyReposViewController ()<UITableViewDataSource>
{
    GitHubController *gitHubController;
    NSMutableArray *gitHubResults;
    __weak IBOutlet UITableView *tableView;
}
@end

@implementation MyReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gitHubController = [GitHubController sharedController];
    gitHubResults = [[NSMutableArray alloc] init];
    
    [gitHubController fetchMyRepos:^(NSMutableArray *results) {
        gitHubResults = results;
        [tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gitHubResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyReposCell"];
    
    GitHubMyRepos *result = [gitHubResults objectAtIndex:indexPath.row];
    cell.textLabel.text = result.name;
    
    return cell;
}

@end
