//
//  GitHubController.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GitHubController : NSObject

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSString *token;

-(id) init;
+(GitHubController *) sharedController;
+(UIImage *) imageFromData:(NSData *)data;

-(void) handleCallbackURL:(NSURL *)url;
-(void) gitHubAuthentication;

-(void) search:(NSString *)query completion:(void (^)(NSMutableArray *results))completion;
-(void) searchUser:(NSString *)query completion:(void (^)(NSMutableArray *results))completion;
-(void) fetchMyRepos:(void (^)(NSMutableArray *results))completion;
-(void) fetchMyFollowers:(void (^)(NSMutableArray *results))completion;

-(void) fetchAvatar:(NSString *)avatarURL completion:(void (^)(UIImage *image))completion;

@end