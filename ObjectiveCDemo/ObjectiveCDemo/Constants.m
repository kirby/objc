//
//  Constants.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/26/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Constants.h"

// OAuth 2 - step 1
NSString * const kGitHubClientID = @"a0bee2148930a4257eb8";
NSString * const kGitHubClientSecret = @"c39510a5afb9c9e248260866548d03cf4958a623";
NSString * const kGitHubCallbackURI = @"githuboauth://git_callback";
NSString * const kGitHubScopes = @"user,repo";
NSString * const kGitHubOAuthURL = @"https://github.com/login/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@";

// OAuth 2 - step 2
NSString * const kGitHubAccessTokenURL = @"https://github.com/login/oauth/access_token";
NSString * const kGitHubAccessTokenPayload = @"client_id=%@&client_secret=%@&code=%@";

// Session
NSString * const kGitHubAuthorizationHeader = @"Authorization";
NSString * const kGitHubAuthorizationHeaderValue = @"token %@";

// Endpoints
NSString * const kGitHubSearchURL = @"https://api.github.com/search/repositories?q=%@+language:Swift&sort=stars&order=desc";
NSString * const kGitHubReposURL = @"https://api.github.com/user/repos";

@implementation Constants

@end