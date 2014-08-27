//
//  GitHubUserSearch.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/27/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubUserSearch.h"

@implementation GitHubUserSearch

-(id)init {
    self = [super init];
    return self;
}
-(id)initWith:(NSString *)login andAvatarURL:(NSString *)avatarURL {
    self = [super init];
    if (self) {
        _login = login;
        _avatarURL = avatarURL;
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
        // NSLog(@"item = %@", item.description);
        NSString *login = [item objectForKey:@"login"];
        NSString *avatarURL = [item objectForKey:@"avatar_url"];
        
        GitHubUserSearch *result = [[GitHubUserSearch alloc] initWith:login andAvatarURL:avatarURL];
        
        [results addObject:result];
    }
    
    //    for (GitHubSearchResult *result in results) {
    //        NSLog(@"%@ %@ %@", result.gitHubID, result.name, result.desc);
    //    }
    
    return results;
}

@end
