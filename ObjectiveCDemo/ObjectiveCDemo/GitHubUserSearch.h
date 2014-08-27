//
//  GitHubUserSearch.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/27/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubUserSearch : NSObject

@property (readonly) NSString *login;
@property (readonly) NSString *avatarURL;

-(id)init;
-(id)initWith:(NSString *)login andAvatarURL:(NSString *)avatarURL;

+(NSMutableArray *)parseWithData:(NSData *)data;

@end
