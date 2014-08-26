//
//  GitHubMyFollowers.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubMyFollowers : NSObject

@property (readonly) NSString *login;
@property (readonly) NSString *html_url;

-(id)init;
-(id)initWith:(NSString *)login andHTMLURL:(NSString *)html_url;

+(NSMutableArray *)parseWithData:(NSData *)data;

@end