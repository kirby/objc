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


@property (strong) GitHubController *gitHubController;

@end

@implementation AddRepoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _autoInitSegement.selectedSegmentIndex = 1;
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _gitHubController = [GitHubController sharedController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveRepoButton:(id)sender {
    
    NSString *initialize = _autoInitSegement.selectedSegmentIndex == 0 ? @"true" : @"false";
    NSString *scope = _scopeSegement.selectedSegmentIndex == 0 ? @"false" : @"true";
    
    GitHubCreateRepo *newRepo = [[GitHubCreateRepo alloc] initWith:_repoNameLabel.text andDescription:_repoDescriptionTextView.text andAutoInitialize:initialize andScope:scope];
    
    [_gitHubController createRepo:newRepo completion:^(BOOL result) {
        if (result) {
            [self.navigationController popToRootViewControllerAnimated:TRUE];
        } else {
            NSLog(@"Could not create the new repo");
        }
    }];
}

@end