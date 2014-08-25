//
//  GitHubSearchResult.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubSearchResult : NSObject

@property (readonly) NSString *gitHubID;
@property (readonly) NSString *name;
@property (readonly) NSString *desc;

-(id)init;
-(id)initWith:(NSString *)gitHubID andName:(NSString *)name andDescription:(NSString *)desc;

+(NSMutableArray *)parseWithData:(NSData *)data;

@end