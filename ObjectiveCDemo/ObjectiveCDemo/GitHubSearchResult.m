//
//  GitHubSearchResult.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubSearchResult.h"

@implementation GitHubSearchResult

-(id)init {
    self = [super init];
    return self;
}
-(id)initWith:(NSString *)gitHubID andName:(NSString *)name andDescription:(NSString *)desc {
    self = [super init];
    if (self) {
        _gitHubID = gitHubID;
        _name = name;
        _desc = desc;
    }
    return self;
}

+(NSMutableArray *)parseWithData:(NSData *)data {
    
//    NSLog(@"%@", data);
    
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
//        NSLog(@"item = %@", item.description);
        NSString *gitHubID = [item objectForKey:@"id"];
        NSString *name = [item objectForKey:@"name"];
        NSString *desc = [item objectForKey:@"description"];
        
        GitHubSearchResult *result = [[GitHubSearchResult alloc] initWith:gitHubID andName:name andDescription:desc];
        
        [results addObject:result];
    }
    
//    for (GitHubSearchResult *result in results) {
//        NSLog(@"%@ %@ %@", result.gitHubID, result.name, result.desc);
//    }

    return results;
}

@end