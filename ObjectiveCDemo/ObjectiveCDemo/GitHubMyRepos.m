//
//  GitHubMyRepos.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubMyRepos.h"

@implementation GitHubMyRepos

-(id)init {
    self = [super init];
    return self;
}

-(id)initWith:(NSString *)name andDescription:(NSString *)desc andHTMLURL:(NSString *)html_url {
    self = [super init];
    if (self) {
        _name = name;
        _desc = desc;
        _html_url = html_url;
    }
    return self;
}

+(NSMutableArray *)parseWithData:(NSData *)data {
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!json) {
        NSLog(@"json parsing failed");
    }
    
    if (![json isKindOfClass:[NSArray class]]) {
        NSLog(@"top level is not an array");
    }
    
//    NSLog(@"json = \n %@", json);
    
//    NSArray *items = [json objectAtIndex:0];
    
    for (NSDictionary *item in json) {
      //  NSLog(@"item = \n %@", item);
        NSString *name = [item objectForKey:@"name"];
        NSString *desc = [item objectForKey:@"description"];
        NSString *html_url = [item objectForKey:@"html_url"];
        
        GitHubMyRepos *result = [[GitHubMyRepos alloc] initWith:name andDescription:desc andHTMLURL:html_url];
        
        [results addObject:result];
    }
    return results;
}

@end