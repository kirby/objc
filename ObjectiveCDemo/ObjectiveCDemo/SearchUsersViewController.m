//
//  SearchUsersViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/27/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "SearchUsersViewController.h"
#import "GitHubController.h"
#import "GitHubUserSearch.h"
#import "UserCollectionViewCell.h"
#import "GitHubWebViewController.h"

@interface SearchUsersViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
{
    GitHubController *gitHubController;
    NSMutableArray *gitHubResults;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    _collectionView.dataSource = self;
    gitHubController = [GitHubController sharedController];
    gitHubResults = [[NSMutableArray alloc] init];
    
//    [gitHubController fetchMyRepos:^(NSMutableArray *results) {
//        gitHubResults = results;
//        [_collectionView reloadData];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [gitHubController searchUser:searchBar.text completion:^(NSMutableArray *results) {
        gitHubResults = results;
        [_collectionView reloadData];
     }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return gitHubResults.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCell" forIndexPath:indexPath];
    
    // Configure the cell
    long currentTag = cell.tag + 1;
    cell.tag = currentTag;
    
    GitHubUserSearch *result = [gitHubResults objectAtIndex:indexPath.row];
    
    cell.loginLabel.text = result.login;
    cell.htmlURL = result.htmlURL;
    
    [gitHubController fetchAvatar:result.avatarURL completion:^(UIImage *image) {
        if (cell.tag == currentTag) {
            cell.imageView.image = image;
            [cell setNeedsDisplay];
        }
    }];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ShowGitHubWeb" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    GitHubUserSearch *user = [gitHubResults objectAtIndex:indexPath.row];
    
    GitHubWebViewController *vc = segue.destinationViewController;
//    UserCollectionViewCell *selectedCell = (UserCollectionViewCell *)sender;
    
    NSArray *items = [_collectionView indexPathsForSelectedItems];
    NSIndexPath *ip = items[0];
    NSLog(@"items.count = %lu", (unsigned long)items.count);
//    
//    UserCollectionViewCell *selectedCell = items.firstObject;
//    
//    NSIndexPath *indexPath = [_collectionView indexPathForCell:selectedCell];
    
    GitHubUserSearch *user = [gitHubResults objectAtIndex:ip.row];
    vc.url = user.htmlURL;
    
    /*
        let photoVC = segue.destinationViewController as PhotoViewController
        var selectedCell = sender as PhotoCell
        var indexPath = self.collectionView.indexPathForCell(selectedCell)
        photoVC.asset = self.photoAssets![indexPath.item] as PHAsset
     */
    
}

@end
