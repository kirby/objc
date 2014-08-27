//
//  GitHubController.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/25/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"
#import "GitHubController.h"
#import "GitHubSearchResult.h"
#import "GitHubUserSearch.h"
#import "GitHubMyRepos.h"

@interface GitHubController ()

@end

@implementation GitHubController

-(id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

+(GitHubController *)sharedController {
    static dispatch_once_t pred;
    static GitHubController *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[GitHubController alloc] init];
        // Check user defaults for OAuth token
        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
        if (token) {
            shared.token = token;
            // create the shared session object
            shared.session = [shared createSessionWithToken:token];
        } else {
            [shared performSelector:@selector(gitHubAuthentication) withObject:nil afterDelay:0.1f];
        }
    });
    return shared;
}

-(void)gitHubAuthentication {
    NSString *urlString = [NSString stringWithFormat:kGitHubOAuthURL,kGitHubClientID,kGitHubCallbackURI,kGitHubScopes];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(void)handleCallbackURL:(NSURL *)url {
    // parse temporary 'code' out of the url query string
    // E.g. code=0ea4c4870da54aa8f484
    NSString *code = [url.query componentsSeparatedByString:@"="].lastObject;
    
    // build up access token request
    NSString *payloadString = [NSString stringWithFormat:kGitHubAccessTokenPayload, kGitHubClientID, kGitHubClientSecret, code];
    
    // convert urlString to data
    NSData *payloadData = [payloadString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *bytes = [NSString stringWithFormat:@"%lu", (unsigned long)[payloadData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGitHubAccessTokenURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:bytes forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:payloadData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
            if (error) {
                NSLog(@"Error %@", error.localizedDescription);
            } else {
                if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                    NSLog(@"Bad Status Code");
                } else {
                    // get token from the resonse payload
                    NSString *token = [self parseTokenFromData:data];
                    self.token = token;
                    self.session = [self createSessionWithToken:token];
                    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                }
            }
    }]resume ];
}

-(NSString *) parseTokenFromData:(NSData *)data {
    
    // convert data to NSString
    NSString *payload = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&scope=user%2Cgist&token_type=bearer
    
    NSString *access_token = [payload componentsSeparatedByString:@"&"][0];
    NSString *token = [access_token componentsSeparatedByString:@"="][1];
    
    return token;
}

-(NSURLSession *) createSessionWithToken:(NSString *)token {

    NSLog(@"token = %@", token);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSDictionary *headerDictionary = @{
       kGitHubAuthorizationHeader : [NSString stringWithFormat:kGitHubAuthorizationHeaderValue, token]};
    
    NSLog(@"headerDictionrary %@", headerDictionary);
    [configuration setHTTPAdditionalHeaders:headerDictionary];
    
    return [NSURLSession sessionWithConfiguration:configuration];
}

-(void)search:(NSString *)query completion:(void (^)(NSMutableArray *))completion {
    
//    NSLog(@"search with hardcoded string");
    
    NSURL *url = [[NSURL alloc] initWithString: [NSString stringWithFormat:kGitHubSearchRepositoriesURL, query]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                NSLog(@"Bad Status Code");
            } else {
                completion([GitHubSearchResult parseWithData:data]);
            }
        }
    }] resume];
}

-(void)searchUser:(NSString *)query completion:(void (^)(NSMutableArray *))completion {
    
    NSLog(@"searchUser: %@", query);
    
    NSURL *url = [[NSURL alloc] initWithString: [NSString stringWithFormat:kGitHubSearchUsersURL, query]];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                NSLog(@"Bad Status Code");
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion([GitHubUserSearch parseWithData:data]);
                }];
            }
        }
    }] resume];
}

-(void)fetchMyRepos:(void (^)(NSMutableArray *))completion {
    NSURL *url = [[NSURL alloc] initWithString:kGitHubReposURL];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                NSLog(@"Bad Status Code %@", response);
            } else {
                completion([GitHubMyRepos parseWithData:data]);
            }
        }
    }] resume];
}

-(void)fetchMyFollowers:(void (^)(NSMutableArray *))completion {
//    NSURL *url = [[NSURL alloc] initWithString:_searchEndpoint];

//    
//    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        if (error) {
//            NSLog(@"Error %@", error.localizedDescription);
//        } else {
//            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
//                NSLog(@"Bad Status Code");
//            } else {
//                completion([GitHubSearchResult parseWithData:data]);
//            }
//        }
//    }] resume];
}

-(void) fetchAvatar:(NSString *)avatarURL completion:(void (^)(UIImage *))completion {
    
    NSLog(@"fetchAvatarWithURL %@", avatarURL);
    NSURL *url = [[NSURL alloc] initWithString:avatarURL];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            if ([(NSHTTPURLResponse *)response statusCode] != 200) {
                NSLog(@"Bad Status Code %@", response);
            } else {
                completion([UIImage imageWithData:data]);
            }
        }
    }] resume];
}


@end