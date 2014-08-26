//
//  GitHubMyRepos.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubMyRepos : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *desc;
@property (readonly) NSString *html_url;

-(id)init;
-(id)initWith:(NSString *)name andDescription:(NSString *)desc andHTMLURL:(NSString *)html_url;

+(NSMutableArray *)parseWithData:(NSData *)data;

@end