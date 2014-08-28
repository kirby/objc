//
//  AddRepoViewController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/28/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "AddRepoViewController.h"
#import "GitHubController.h"
#import "GitHubCreateRepo.h"

@interface AddRepoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegement;
@property (weak, nonatomic) IBOutlet UITextField *repoNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *repoDescriptionTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *autoInitSegement;
- (IBAction)saveRepoButton:(id)sender;

@property (strong) GitHubController *gitHubController;
@property (strong) NSMutableArray *gitHubResults;

@end

@implementation AddRepoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _autoInitSegement.selectedSegmentIndex = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gitHubController = [GitHubController sharedController];
    
    NSString *initialize = _autoInitSegement.selectedSegmentIndex == 0 ? @"true" : @"false";
    NSString *scope = _scopeSegement.selectedSegmentIndex == 0 ? @"false" : @"true";
    
    GitHubCreateRepo *newRepo = [[GitHubCreateRepo alloc] initWith:_repoNameLabel.text andDescription:_repoDescriptionTextView.text andAutoInitialize:initialize andScope:scope];
    
    [_gitHubController createRepo:newRepo completion:^(NSMutableArray *results) {
        _gitHubResults = results;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveRepoButton:(id)sender {
    
    NSString *initialize = _autoInitSegement.selectedSegmentIndex == 0 ? @"true" : @"false";
    NSString *scope = _scopeSegement.selectedSegmentIndex == 0 ? @"false" : @"true";
    
    GitHubCreateRepo *newRepo = [[GitHubCreateRepo alloc] initWith:_repoNameLabel.text andDescription:_repoDescriptionTextView.text andAutoInitialize:initialize andScope:scope];
    
    [_gitHubController createRepo:newRepo completion:^(NSMutableArray *results) {
        _gitHubResults = results;
        
    }];
    
}

@end