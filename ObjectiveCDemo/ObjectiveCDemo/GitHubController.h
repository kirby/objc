//
//  GitHubController.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubController : NSObject

@property (readonly) NSString *searchEndpoint;

-(id)init;
-(void)search:(NSString *)q completion:(void (^)(NSMutableArray *results))completion;
-(void)fetchMyRepos:(NSString *)token completion:(void (^)(NSMutableArray *results))completion;
-(void)fetchMyFollowers:(NSString *)token completion:(void (^)(NSMutableArray *results))completion;

@end