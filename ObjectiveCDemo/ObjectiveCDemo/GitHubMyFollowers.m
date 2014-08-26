//
//  GitHubMyFollowers.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubMyFollowers.h"

@implementation GitHubMyFollowers

-(id)init {
    self = [super init];
    return self;
}

-(id)initWith:(NSString *)login andHTMLURL:(NSString *)html_url {
    self = [super init];
    if (self) {
        _login = login;
        _html_url = html_url;
    }
    return self;
}

+(NSMutableArray *)parseWithData:(NSData *)data {
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!json) {
        NSLog(@"json parsing failed");
    }
    
    if (![json isKindOfClass:[NSDictionary class]]) {
        NSLog(@"top level is not a dictionary");
    }
    
    NSArray *items = [json objectForKey:@"items"];
    
    for (NSDictionary *item in items) {
        NSString *login = [item objectForKey:@"login"];
        NSString *html_url = [item objectForKey:@"html_url"];
        
        GitHubMyFollowers *result = [[GitHubMyFollowers alloc] initWith:login andHTMLURL:html_url];
        
        [results addObject:result];
    }
    
    return results;
}

@end