//
//  Constants.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#ifndef ObjectiveCDemo_Constants_h
#define ObjectiveCDemo_Constants_h

@interface Constants : NSObject

// OAuth 2 - step 1
extern NSString * const kGitHubClientID;
extern NSString * const kGitHubClientSecret;
extern NSString * const kGitHubCallbackURI;
extern NSString * const kGitHubOAuthURL;
extern NSString * const kGitHubScopes;

// OAuth 2 - step 2
extern NSString * const kGitHubAccessTokenURL;
extern NSString * const kGitHubAccessTokenPayload;

// Session
extern NSString * const kGitHubAuthorizationHeader;
extern NSString * const kGitHubAuthorizationHeaderValue;

// Endpoints
extern NSString * const kGitHubSearchRepositoriesURL;
extern NSString * const kGitHubSearchUsersURL;

extern NSString * const kGitHubReposURL;

@end

#endif