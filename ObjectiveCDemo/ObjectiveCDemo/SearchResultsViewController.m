//
//  SearchResultsViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "GitHubController.h"
#import "GitHubSearchResult.h"

@interface SearchResultsViewController ()<UITableViewDataSource>
{
    GitHubController *gitHubController;
    NSMutableArray *gitHubSearchResults;
    __weak IBOutlet UITableView *tableView;
}
@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    gitHubController = [[GitHubController alloc] init];
    gitHubSearchResults = [[NSMutableArray alloc] init];
    
    [gitHubController search:@"tetris" completion:^(NSMutableArray *results) {
        gitHubSearchResults = results;
        [tableView reloadData];
//        for (GitHubSearchResult *result in results) {
//            NSLog(@"%@ %@ %@", result.gitHubID, result.name, result.desc);
//        }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    GitHubSearchResult *result = [gitHubSearchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = result.name;
    
    return cell;
}

@end
