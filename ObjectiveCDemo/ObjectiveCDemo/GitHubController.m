//
//  GitHubController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubController.h"
#import "GitHubSearchResult.h"

@interface GitHubController ()

@end

@implementation GitHubController

-(id)init {
    self = [super init];
    if (self) {
        _searchEndpoint = @"https://api.github.com/search/repositories?q=tetris+language:Swift&sort=stars&order=desc";
    }
    return self;
}

-(void)search:(NSString *)q completion:(void (^)(NSMutableArray *))completion {
    
//    NSLog(@"search with hardcoded string");
    
    NSURL *url = [[NSURL alloc] initWithString:_searchEndpoint];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                NSLog(@"Bad Status Code");
            } else {
                completion([GitHubSearchResult parseWithData:data]);
            }
        }
    }] resume];
}

@end